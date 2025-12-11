import 'package:flutter/material.dart';
class ProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final Color backgroundColor;
  final Color progressColor;
  final String label;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 120,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final strokeWidth = size * 0.1;
    final radius = (size - strokeWidth) / 2;

    return SizedBox(
      width: size,
      height: size + 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(size, size),
                  painter: _ProgressRingPainter(
                    progress: 0,
                    strokeWidth: strokeWidth,
                    radius: radius,
                    backgroundColor: backgroundColor,
                    progressColor: backgroundColor,
                  ),
                ),
                CustomPaint(
                  size: Size(size, size),
                  painter: _ProgressRingPainter(
                    progress: progress,
                    strokeWidth: strokeWidth,
                    radius: radius,
                    backgroundColor: Colors.transparent,
                    progressColor: progressColor,
                  ),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final double radius;
  final Color backgroundColor;
  final Color progressColor;

  _ProgressRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.radius,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}