import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String locationType;
  final List<String> subjects;
  final int daysLeft;
  final String timeLeft;
  final String backgroundImage;

  const EventCard({
    super.key,
    required this.title,
    required this.locationType,
    required this.subjects,
    required this.daysLeft,
    required this.timeLeft,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            // ignore: deprecated_member_use
            Colors.black.withOpacity(0.55),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),

            // Linha com localização
            Row(
              children: [
                const Icon(Icons.place, color: Colors.white, size: 18),
                const SizedBox(width: 4),
                Text(
                  locationType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Botões das matérias
            Wrap(
              spacing: 6,
              children: [
                for (var subject in subjects)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      subject,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                if (subjects.length > 2)
                  const Icon(Icons.add, color: Colors.white, size: 16),
              ],
            ),
            const SizedBox(height: 12),
            // Linha inferior
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "$daysLeft dias",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Começa em: $timeLeft",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
