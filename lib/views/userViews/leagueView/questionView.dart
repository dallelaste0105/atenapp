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
  // ETAPA 1: Crie uma variável Future para o FutureBuilder observar
  late Future<void> _loadQuestionsFuture;

  @override
  void initState() {
    super.initState();
    // ETAPA 2: Atribua a função que *busca* os dados a essa variável
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
        // ETAPA 3: Use o _loadQuestionsFuture como o 'future'
        child: FutureBuilder<void>(
          future: _loadQuestionsFuture, // <-- MUDANÇA IMPORTANTE
          builder: (context, snapshot) {
            // Se ainda estiver carregando, mostre o spinner
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            // Se a busca de dados deu erro (ex: falha na API)
            if (snapshot.hasError) {
              return Text(
                'Erro ao carregar questão: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              );
            }

            // Se terminou de carregar (ConnectionState.done) e não teve erro,
            // podemos com segurança tentar mostrar a questão.
            
            // ETAPA 4: Chame a função *síncrona* para obter os dados
            final question = QuestionClassInstance.showFirstQuestion();

            // Verificamos se a busca não retornou nenhuma questão
            if (question == null) {
              return const Text("Nenhuma questão encontrada.");
            }

            // Se tudo deu certo, mostre a questão
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(question.toString()),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      QuestionClassInstance.excludeFirstQuestion();
                      // O setState vai reconstruir a tela, 
                      // showFirstQuestion() será chamado de novo
                      // e mostrará a próxima questão (ou "Nenhuma questão").
                    });
                  },
                  child: const Text("Responder"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}