import 'package:flutter/material.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;
import 'package:muto_system/widgets/SubjectLine.dart';

class SubjectProgressPage extends StatelessWidget {
  const SubjectProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.Colors.background_black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '85/100',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      Text(
                        'Fazendo por 60 dias',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const SubjectLine(
              colors: [Colors.blue, Colors.blue, Colors.blue, Colors.blue],
              circleSize: 90,
              spacing: 70,
            ),
          ],
        ),
      ),
    );
  }
}
