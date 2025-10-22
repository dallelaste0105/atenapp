import 'package:flutter/material.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/ColorExample.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Foto de perfil
                const Positioned(
                  bottom: 10,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage('assets/img/example.png'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),

            const Text(
              'Maurício Reis Doefer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Estudante do IFC',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_fire_department, color: Colors.white),
                SizedBox(width: 6),
                Text(
                  '224 dias',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C4E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _StatusInfo(title: 'Avançado', value: 'Mat. 32/78'),
                      _StatusInfo(title: 'Nível', value: '54'),
                      _StatusInfo(title: 'Liga', value: 'Platina (2º)'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Conquistas em Destaque',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.military_tech, color: Colors.grey, size: 40),
                      Icon(Icons.emoji_events, color: Colors.orange, size: 40),
                      Icon(Icons.star, color: Colors.yellow, size: 40),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C4E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Todas as Conquistas',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Filtrar por Matéria: ',
                        style: TextStyle(color: Colors.white),
                      ),
                      DropdownButton<String>(
                        dropdownColor: Colors.black,
                        value: 'Matemática',
                        style: const TextStyle(color: Colors.white),
                        items: const [
                          DropdownMenuItem(
                            value: 'Matemática',
                            child: Text('Matemática'),
                          ),
                          DropdownMenuItem(
                            value: 'História',
                            child: Text('História'),
                          ),
                          DropdownMenuItem(
                            value: 'Química',
                            child: Text('Química'),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _StatusInfo extends StatelessWidget {
  final String title;
  final String value;

  const _StatusInfo({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
