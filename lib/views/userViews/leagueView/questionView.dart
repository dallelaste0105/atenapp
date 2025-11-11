import 'package:flutter/material.dart';
import '../../../classes/questionClass.dart';

final QuestionClassInstance = QuestionClass();

class QuestionScreen extends StatefulWidget {
  final String subTopic;
  final int difficulty;
  final int howMany;

  const QuestionScreen({
    super.key,
    required this.subTopic,
    required this.difficulty,
    required this.howMany,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Future<void> _loadQuestionsFuture;
  bool finished = false; // ✅ controla se acabou as perguntas

  @override
  void initState() {
    super.initState();
    _loadQuestionsFuture = QuestionClassInstance.takeSaveQuestionDataFunction(
      widget.subTopic,
      widget.difficulty,
      widget.howMany,
    );
  }

  void _answerQuestion(String answer) {
    QuestionClassInstance.verifyAccuracy(answer);
    setState(() {
      QuestionClassInstance.excludeFirstQuestion();
      if (QuestionClassInstance.questionsList.isEmpty) {
        finished = true;
        // ✅ Chama a função que envia pontos ao backend
        QuestionClassInstance.addPointsContext("league");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Responda")),
      body: Center(
        child: FutureBuilder<void>(
          future: _loadQuestionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text(
                'Erro ao carregar questão: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              );
            }

            // ✅ Se terminou todas as perguntas:
            if (finished) {
              return const Text("Sua resposta foi registrada!");
            }

            final question = QuestionClassInstance.showFirstQuestion();

            if (question == null) {
              return const Text("Carregando pergunta...");
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  question["statement"].toString(),
                  style: const TextStyle(color: Colors.red),
                ),
                Text("Opção A: ${question["a"].toString()}"),
                Text("Opção B: ${question["b"].toString()}"),
                Text("Opção C: ${question["c"].toString()}"),
                Text("Opção D: ${question["d"].toString()}"),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _answerQuestion("a"),
                  child: const Text("A"),
                ),
                ElevatedButton(
                  onPressed: () => _answerQuestion("b"),
                  child: const Text("B"),
                ),
                ElevatedButton(
                  onPressed: () => _answerQuestion("c"),
                  child: const Text("C"),
                ),
                ElevatedButton(
                  onPressed: () => _answerQuestion("d"),
                  child: const Text("D"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
