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
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Responda")),
      body: Center(
        child: FutureBuilder<dynamic>(
          future: QuestionClassInstance.showFirstQuestion(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text(
                'Erro ao carregar e-mail: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              );
            }

            if (snapshot.hasData) {
              final question = snapshot.data!;
              return Column(children: [
                Text(question),
                ElevatedButton(onPressed: () {
                      setState(() {
                        QuestionClassInstance.excludeFirstQuestion();
                      });
                    }, child: Text("Responder"))
              ]);
            }
            return const Text("Erro ao carregar questão");
          }
          ),
      ),
    );
  }
}
