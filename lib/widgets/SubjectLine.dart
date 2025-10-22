import 'package:flutter/material.dart';

class SubjectLine extends StatelessWidget {
  final List<Color> colors;
  final double circleSize;
  final double spacing;
  final double lineWidth;

  const SubjectLine({
    super.key,
    required this.colors,
    this.circleSize = 80,
    this.spacing = 50,
    this.lineWidth = 4,
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
          width: circleSize,
          height: colors.length * (circleSize + spacing),
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (int i = 0; i < colors.length; i++)
                Positioned(
                  top: i * (circleSize + spacing),
                  child: _FrostedCircle(color: colors[i], size: circleSize),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FrostedCircle extends StatelessWidget {
  final Color color;
  final double size;

  const _FrostedCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.7),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 3,
          ),
        ],
      ),
      child: const Icon(Icons.star_border, color: Colors.white, size: 34),
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
      ..color = Colors.white.withOpacity(0.2)
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
