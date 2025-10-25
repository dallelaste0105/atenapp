import 'package:flutter/material.dart';

class SubjectLine extends StatelessWidget {
  final List<Color> colors;
  final double circleSize;
  final double spacing;
  final double lineWidth;
  final Function(int index) onItemTap;

  const SubjectLine({
    super.key,
    required this.colors,
    this.circleSize = 80,
    this.spacing = 50,
    this.lineWidth = 4,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: _LinePainter(
          colors: colors,
          circleSize: circleSize,
          spacing: spacing,
          lineWidth: lineWidth,
        ),
        child: SizedBox(
          width: circleSize * 1.2,
          height: colors.length * (circleSize + spacing),
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (int i = 0; i < colors.length; i++)
                Positioned(
                  top: i * (circleSize + spacing),
                  child: GestureDetector(
                    onTap: () => onItemTap(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: circleSize,
                      height: circleSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [colors[i], colors[i].withOpacity(0.6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colors[i].withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final List<Color> colors;
  final double circleSize;
  final double spacing;
  final double lineWidth;

  _LinePainter({
    required this.colors,
    required this.circleSize,
    required this.spacing,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < colors.length - 1; i++) {
      final startY = (circleSize / 2) + i * (circleSize + spacing);
      final endY = (circleSize / 2) + (i + 1) * (circleSize + spacing);
      final x = size.width / 2;
      canvas.drawLine(Offset(x, startY), Offset(x, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
