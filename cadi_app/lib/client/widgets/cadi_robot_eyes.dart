import 'dart:math' as math;
import 'package:flutter/material.dart';

class CadiRobotEyes extends StatefulWidget {
  final double size;
  final Color color;

  const CadiRobotEyes({
    super.key,
    this.size = 64,
    this.color = const Color(0xFFFFF18A), // Matches soft yellow robot eye color in _BotPainter
  });

  @override
  State<CadiRobotEyes> createState() => _CadiRobotEyesState();
}

class _CadiRobotEyesState extends State<CadiRobotEyes>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.size * 1.5,
          height: widget.size,
          child: CustomPaint(
            painter: _RobotEyesPainter(
              progress: _controller.value,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}

class _RobotEyesPainter extends CustomPainter {
  final double progress;
  final Color color;

  _RobotEyesPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Glowing effect: breathing size
    final breathing = math.sin(progress * math.pi * 2) * 1.5;

    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6 + breathing.abs());

    final eyePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // The i i shape:
    // For each eye (left and right), we draw a dot at the top and a vertical pill below it.
    // Horizontal center for left and right eyes
    final leftX = w * 0.35;
    final rightX = w * 0.65;

    final dotRadius = h * 0.09;
    final dotY = h * 0.22 + breathing * 0.3;
    final pillW = h * 0.12;
    final pillH = h * 0.42;
    final pillY = h * 0.44;

    for (final cx in [leftX, rightX]) {
      // 1. Draw Dot Glow
      canvas.drawCircle(Offset(cx, dotY), dotRadius + 2, glowPaint);
      // Draw Dot
      canvas.drawCircle(Offset(cx, dotY), dotRadius, eyePaint);

      // 2. Draw Pill Glow
      final pillRect = Rect.fromCenter(
        center: Offset(cx, pillY + pillH / 2),
        width: pillW,
        height: pillH,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(pillRect.inflate(2), Radius.circular(pillW / 2)),
        glowPaint,
      );
      // Draw Pill
      canvas.drawRRect(
        RRect.fromRectAndRadius(pillRect, Radius.circular(pillW / 2)),
        eyePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RobotEyesPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
