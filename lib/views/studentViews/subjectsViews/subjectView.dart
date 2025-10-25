import 'package:flutter/material.dart';
// Certifique-se de que os imports abaixo estão corretos no seu projeto
import 'package:muto_system/configs/colors.dart' as ThemeColors;
import 'package:muto_system/models/QuestionModel.dart';
import 'package:muto_system/views/studentViews/subjectsViews/questionView.dart';
import 'package:muto_system/views/widgets/SubjectLine.dart';

class SubjectProgressPage extends StatelessWidget {
  const SubjectProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    // A lógica de dado SIMPLES é mantida: apenas um exemplo de questão
    final questionExample = QuestionModel(
      id: 1,
      subject: "Matemática Avançada",
      text: "Qual é o valor de x na equação 2x + 5 = 15?",
      options: ["A) 3", "B) 4", "C) 5", "D) 6"],
      correctAnswer: "C) 5",
    );

    return Scaffold(
      backgroundColor: ThemeColors.Colors.background_black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho estilizado
            _buildHeader(),
            const SizedBox(height: 24),

            // Cards de estatísticas estilizados
            _buildStatisticsCards(),
            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Fase Atual',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // SubjectLine com Lógica Original (1 item) e SEM itemBuilder
            SubjectLine(
              colors: const [
                Colors.blue, // A cor azul preenche o círculo
              ],
              circleSize: 80,
              spacing: 60,

              // **REMOVIDO O itemBuilder**

              // Lógica de onTap ORIGINAL MANTIDA
              onItemTap: (index) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestaoCard.fromModel(
                      question: questionExample,
                      tituloMateria: questionExample.subject,
                      textoQuestao: questionExample.text,
                      opcoes: questionExample.options,
                      onConfirmar: (opcaoSelecionada) {
                        // Lógica ao confirmar a resposta
                        print("Opção selecionada: $opcaoSelecionada");
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói o cabeçalho com informações do usuário/nível, com estilo aprimorado.
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade800, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white10,
            backgroundImage: AssetImage('assets/img/example.png'),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Avançado',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '85/100 pontos',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Text(
                '60 dias de estudo contínuo',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Constrói os cards de estatísticas (aprimoramento de estilo).
  Widget _buildStatisticsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _buildStatCard(
            icon: Icons.star_rate_rounded,
            title: '85/100',
            subtitle: 'Pontuação Total',
            color: Colors.amber.shade700,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            icon: Icons.local_fire_department_rounded,
            title: '60 dias',
            subtitle: 'Streak de Estudo',
            color: Colors.red.shade700,
          ),
        ],
      ),
    );
  }

  /// Widget auxiliar para um card de estatística individual com design moderno.
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade800.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
