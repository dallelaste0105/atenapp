import 'package:flutter/material.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;

class FriendsAndSchoolPage extends StatefulWidget {
  const FriendsAndSchoolPage({super.key});

  @override
  State<FriendsAndSchoolPage> createState() => _FriendsAndSchoolPageState();
}

class _FriendsAndSchoolPageState extends State<FriendsAndSchoolPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.Colors.background_black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/ColorExample.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: ThemeColors.Colors.background_white,
                    backgroundImage: const AssetImage('assets/img/example.png'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            // Nome e informações
            const Text(
              'IFC Campus Concórdia',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Instituto Federal',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const Text(
              'Super Ativa',
              style: TextStyle(color: Colors.lightGreenAccent, fontSize: 14),
            ),

            const SizedBox(height: 24),

            // Seção de turmas
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C4E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text(
                        'Todas as Suas Turmas',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Botões das turmas
                  Column(
                    children: [
                      _SubjectButton(title: 'Matemática'),
                      const SizedBox(height: 6),
                      _SubjectButton(title: 'Química'),
                      const SizedBox(height: 6),
                      _SubjectButton(title: 'Física'),
                    ],
                  ),

                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Ver Todas as Suas Turmas',
                      style: TextStyle(
                        color: Colors.white70,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Liga de Amigos
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C4E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text(
                        'Liga de Amigos',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Lista da Liga
                  const _FriendRank(
                    position: 1,
                    name: 'Bazz Segio',
                    level: 'Intermediário (28/64)',
                    score: 82,
                  ),
                  const _FriendRank(
                    position: 2,
                    name: 'Maurício Reis Doefer',
                    level: 'Avançado (85/100)',
                    score: 79,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// Botão da matéria
class _SubjectButton extends StatelessWidget {
  final String title;
  const _SubjectButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[800],
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Item da Liga de Amigos
class _FriendRank extends StatelessWidget {
  final int position;
  final String name;
  final String level;
  final int score;

  const _FriendRank({
    required this.position,
    required this.name,
    required this.level,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Row(
        children: [
          Text(
            '$position',
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  level,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '$score',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
