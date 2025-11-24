import 'package:Atena/classes/championshipClass.dart';
import 'package:flutter/material.dart';

ChampionshipClass championshipClassInstance = ChampionshipClass();

class ChooseFilteredQuestionsForBlockViewScreen extends StatefulWidget {
  @override
  State<ChooseFilteredQuestionsForBlockViewScreen> createState() =>
      _ChooseFilteredQuestionsForBlockViewScreenState();
}

class _ChooseFilteredQuestionsForBlockViewScreenState
    extends State<ChooseFilteredQuestionsForBlockViewScreen> {
  String? selectedSubject;
  String? selectedTopic;
  String? selectedSubtopic;

  int? selectedDifficulty;
  int? selectedQuantity;

  List subjects = [];
  List topics = [];
  List subtopics = [];

  bool loadingSubjects = true;
  bool loadingTopics = false;
  bool loadingSubtopics = false;

  @override
  void initState() {
    super.initState();
    loadSubjects();
  }

  Future<void> loadSubjects() async {
    setState(() => loadingSubjects = true);

    subjects = await championshipClassInstance.getContents("subject", "");

    setState(() => loadingSubjects = false);
  }

  Future<void> loadTopics(String subject) async {
    setState(() {
      loadingTopics = true;
      topics = [];
      selectedTopic = null;
      selectedSubtopic = null;
      subtopics = [];
    });

    topics = await championshipClassInstance.getContents("topic", subject);

    setState(() => loadingTopics = false);
  }

  Future<void> loadSubtopics(String topic) async {
    setState(() {
      loadingSubtopics = true;
      subtopics = [];
      selectedSubtopic = null;
    });

    subtopics =
        await championshipClassInstance.getContents("subtopic", topic);

    setState(() => loadingSubtopics = false);
  }

  Widget buildDropdown({
    required String label,
    required String? value,
    required List items,
    required bool isLoading,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: isLoading
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : DropdownButton<String>(
                  value: value,
                  hint: Text("Selecione"),
                  isExpanded: true,
                  underline: SizedBox(),
                  items: items
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: onChanged,
                ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Questões filtradas")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildDropdown(
                label: "Matéria",
                value: selectedSubject,
                items: subjects,
                isLoading: loadingSubjects,
                onChanged: (value) {
                  setState(() => selectedSubject = value);
                  loadTopics(value!);
                },
              ),

              if (selectedSubject != null)
                buildDropdown(
                  label: "Tópico",
                  value: selectedTopic,
                  items: topics,
                  isLoading: loadingTopics,
                  onChanged: (value) {
                    setState(() => selectedTopic = value);
                    loadSubtopics(value!);
                  },
                ),

              if (selectedTopic != null)
                buildDropdown(
                  label: "Subtópico",
                  value: selectedSubtopic,
                  items: subtopics,
                  isLoading: loadingSubtopics,
                  onChanged: (value) {
                    setState(() => selectedSubtopic = value);
                  },
                ),

              /// Dificuldade 1-3
              if (selectedSubtopic != null)
                buildDropdown(
                  label: "Dificuldade (1-3)",
                  value: selectedDifficulty?.toString(),
                  items: ["1", "2", "3"],
                  isLoading: false,
                  onChanged: (value) {
                    setState(() => selectedDifficulty = int.parse(value!));
                  },
                ),

              /// Quantidade
              if (selectedDifficulty != null)
                buildDropdown(
                  label: "Quantidade",
                  value: selectedQuantity?.toString(),
                  items: List.generate(20, (i) => (i + 1).toString()),
                  isLoading: false,
                  onChanged: (value) {
                    setState(() => selectedQuantity = int.parse(value!));
                  },
                ),

              SizedBox(height: 30),

              /// Botão final
              if (selectedQuantity != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                  onPressed: () {
                    championshipClassInstance.addNotConfirmedFilteredQuestions(selectedSubtopic, selectedDifficulty, selectedQuantity);
                  },
                  child: Text("Confirmar filtros",
                      style: TextStyle(fontSize: 18)),
                )
            ],
          ),
        ),
      ),
    );
  }
}
