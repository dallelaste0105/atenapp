import 'package:flutter/material.dart';
import '../../../classes/questionClass.dart';

class QuestionScreen extends StatelessWidget {
  final String subject;
  final String topic;
  final String subTopic;
  final int difficulty;
  final String searchType;
  final int howMany;

  const QuestionScreen({
    super.key,
    required this.subject,
    required this.topic,
    required this.subTopic,
    required this.difficulty,
    required this.searchType,
    required this.howMany,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Responda")),
      body: Center(
        child: FutureBuilder<dynamic>(
          future: QuestionClass().takeSaveQuestionDataFunction(
            subject,
            topic,
            subTopic,
            difficulty,
            searchType,
            howMany,
          ),
          builder: (context, snapshot) {
            
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return const Text(
                'Erro ao carregar questão',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              );
            }

            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Questão carregada:",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }

            return const Text('Nenhum dado encontrado.');
          },
        ),
      ),
    );
  }
}
