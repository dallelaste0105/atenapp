import 'package:flutter/material.dart';
import '../../../classes/questionClass.dart';

final QuestionClassInstance = QuestionClass();

class QuestionScreen extends StatefulWidget {
  final String subject;
  final String topic;
  final String subTopic;
  final int difficulty;
  final String searchType;
  final int howMany;
  final String context;

  const QuestionScreen({
    super.key,
    required this.subject,
    required this.topic,
    required this.subTopic,
    required this.difficulty,
    required this.searchType,
    required this.howMany,
    required this.context
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Future<void> _loadQuestionsFuture;

  @override
  void initState() {
    super.initState();
    _loadQuestionsFuture = QuestionClassInstance.takeSaveQuestionDataFunction(
      widget.subject,
      widget.topic,
      widget.subTopic,
      widget.difficulty,
      widget.searchType,
      widget.howMany,
    );
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

            final question = QuestionClassInstance.showFirstQuestion();

            if (question == null) {
              QuestionClassInstance.addPointsContext(context);
              return const Text("Sua resposta foi registrada");
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(question.toString()),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    QuestionClassInstance.verifyAccuracy("A");
                    setState(() {
                      QuestionClassInstance.excludeFirstQuestion();
                    });
                  },
                  child: const Text("A"),
                ),
                ElevatedButton(
                  onPressed: () {
                    QuestionClassInstance.verifyAccuracy("B");
                    setState(() {
                      QuestionClassInstance.excludeFirstQuestion();
                    });
                  },
                  child: const Text("B"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}