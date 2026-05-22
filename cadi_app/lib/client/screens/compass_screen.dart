// C11 / C12 — 定位指北針 (Figma nodes 1:6, 1:7)
// 機器人的位置就是光圈裡面那個精靈的位置,中間有點像指北針,指向機器人位置
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/client_chrome.dart';

class CompassScreen extends StatefulWidget {
  final bool variant; // false = C11, true = C12
  final bool familyMode; // F2 重用
  const CompassScreen({
    super.key,
    this.variant = false,
    this.familyMode = false,
  });

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backPath = widget.familyMode ? '/family' : '/client/mood';
    return Scaffold(
      body: ClientGradientBackground(
        peachOnly: !widget.familyMode,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final visualSize = (constraints.maxWidth * 0.76).clamp(
                292.0,
                340.0,
              );
              final visualTop = constraints.maxHeight * 0.275;
              final listenBottom = constraints.maxHeight * 0.17;

              return Stack(
                children: [
                  Positioned(
                    top: 14,
                    left: 6,
                    child: ClientBackButton(onTap: () => context.go(backPath)),
                  ),
                  Positioned(
                    top: visualTop,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _ctrl,
                        builder: (context, _) {
                          return CustomPaint(
                            size: Size.square(visualSize),
                            painter: _CompassPainter(
                              progress: _ctrl.value,
                              variant: widget.variant,
                              familyMode: widget.familyMode,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: listenBottom,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _ctrl,
                        builder: (context, _) {
                          return _ListenIndicator(progress: _ctrl.value);
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ListenIndicator extends StatelessWidget {
  final double progress;

  const _ListenIndicator({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'listen',
          style: GoogleFonts.lexend(
            color: const Color(0xFF8D8D8D),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(width: 8),
        ...List.generate(4, (index) {
          final phase = (progress + index * 0.16) % 1.0;
          final lift = (math.sin(phase * 2 * math.pi) + 1) * 3.0;
          return Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Transform.translate(
              offset: Offset(0, -lift),
              child: Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF8D8D8D,
                  ).withValues(alpha: 0.58 + (lift / 6) * 0.32),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _CompassPainter extends CustomPainter {
  final double progress;
  final bool variant;
  final bool familyMode;

  _CompassPainter({
    required this.progress,
    required this.variant,
    required this.familyMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.width / 2;
    final pulse = (math.sin(progress * 2 * math.pi) + 1) / 2;

    if (familyMode) {
      _paintFamilyCompass(canvas, size, center, r, pulse);
      return;
    }

    final haloCenter = center + Offset(0, r * 0.02);
    final ringPaint = Paint()
      ..color = const Color(0xFFFFC6A9).withValues(alpha: 0.42)
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.2
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.11);
    canvas.drawCircle(haloCenter, r * (0.63 + pulse * 0.012), ringPaint);

    final softGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFE1D3).withValues(alpha: 0.22),
          const Color(0xFFFFE9DC).withValues(alpha: 0.10),
          Colors.white.withValues(alpha: 0),
        ],
        stops: const [0.0, 0.58, 1.0],
      ).createShader(Rect.fromCircle(center: haloCenter, radius: r * 0.92));
    canvas.drawCircle(haloCenter, r * 0.92, softGlow);

    final sphereRadius = r * 0.295;
    final centerSphereRect = Rect.fromCircle(
      center: center + Offset(0, r * 0.01),
      radius: sphereRadius,
    );
    final centerSphere = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.25, -0.25),
        radius: 0.95,
        colors: [Color(0xFFFFF6ED), Color(0xFFFFC09D), Color(0xFFFF8C62)],
      ).createShader(centerSphereRect);

    canvas.drawCircle(
      center + Offset(0, r * 0.035),
      sphereRadius,
      Paint()
        ..color = const Color(0x26000000)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.038),
    );
    canvas.drawCircle(center + Offset(0, r * 0.01), sphereRadius, centerSphere);

    final highlight = Paint()
      ..shader =
          RadialGradient(
            colors: [
              Colors.white.withValues(alpha: 0.78),
              Colors.white.withValues(alpha: 0),
            ],
          ).createShader(
            Rect.fromCircle(
              center: center + Offset(-r * 0.14, -r * 0.14),
              radius: r * 0.08,
            ),
          );
    canvas.drawCircle(
      center + Offset(-r * 0.14, -r * 0.14),
      r * 0.08,
      highlight,
    );
    canvas.drawCircle(
      center + Offset(0, r * 0.01),
      r * 0.035,
      Paint()..color = Colors.white,
    );

    final needleAngle = -math.pi / 4.8;
    final tip =
        center +
        Offset(math.cos(needleAngle), math.sin(needleAngle)) * (r * 0.4);
    final needlePath = Path();
    final baseAngleLeft = needleAngle + math.pi / 2 + 0.15;
    final baseAngleRight = needleAngle - math.pi / 2 - 0.15;
    final needleBase =
        center +
        Offset(math.cos(needleAngle), math.sin(needleAngle)) * (r * 0.22);
    final baseLeft =
        needleBase +
        Offset(math.cos(baseAngleLeft), math.sin(baseAngleLeft)) * (r * 0.045);
    final baseRight =
        needleBase +
        Offset(math.cos(baseAngleRight), math.sin(baseAngleRight)) *
            (r * 0.045);
    needlePath.moveTo(tip.dx, tip.dy);
    needlePath.lineTo(baseLeft.dx, baseLeft.dy);
    needlePath.lineTo(baseRight.dx, baseRight.dy);
    needlePath.close();

    canvas.drawPath(needlePath, Paint()..color = Colors.white);

    final botAngle = -math.pi / 4.65;
    final botCenter =
        center + Offset(math.cos(botAngle), math.sin(botAngle)) * (r * 0.78);
    final botRadius = r * 0.095;
    final botRingRadius = r * 0.16;

    canvas.drawCircle(botCenter, botRingRadius, Paint()..color = Colors.white);
    canvas.drawCircle(
      botCenter,
      botRingRadius,
      Paint()
        ..color = const Color(0xFFFFCB75)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final botPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.1, -0.1),
        radius: 0.8,
        colors: [Color(0xFFFFF3E8), Color(0xFFFFC09A), Color(0xFFFF9E6C)],
      ).createShader(Rect.fromCircle(center: botCenter, radius: botRadius));
    canvas.drawCircle(botCenter, botRadius, botPaint);

    final botEyePaint = Paint()..color = Colors.white.withValues(alpha: 0.78);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: botCenter + Offset(-botRadius * 0.22, -botRadius * 0.18),
          width: botRadius * 0.12,
          height: botRadius * 0.36,
        ),
        Radius.circular(botRadius * 0.1),
      ),
      botEyePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: botCenter + Offset(botRadius * 0.22, -botRadius * 0.18),
          width: botRadius * 0.12,
          height: botRadius * 0.36,
        ),
        Radius.circular(botRadius * 0.1),
      ),
      botEyePaint,
    );
  }

  void _paintFamilyCompass(
    Canvas canvas,
    Size size,
    Offset center,
    double r,
    double pulse,
  ) {
    final blue = const Color(0xFFBBD5E8);
    final orbitPaint = Paint()
      ..color = const Color(0xFF235B7A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: r * 0.83),
      math.pi * 1.08,
      math.pi * 0.84,
      false,
      orbitPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: r * 0.83),
      math.pi * 0.08,
      math.pi * 0.84,
      false,
      orbitPaint,
    );

    final ringPaint = Paint()
      ..color = blue.withValues(alpha: 0.34)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var i = 0; i < 5; i++) {
      canvas.drawCircle(center, r * (0.47 + i * 0.018), ringPaint);
    }

    canvas.drawCircle(
      center,
      r * 0.42,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: 0.82),
            blue.withValues(alpha: 0.9),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: r * 0.42)),
    );

    final dotPaint = Paint()..color = const Color(0xFFDDDDDD);
    for (var row = -3; row <= 3; row++) {
      for (var col = -3; col <= 3; col++) {
        if (row.abs() + col.abs() > 4) continue;
        final radius = row == 0 && col == 0 ? 4.5 : 2.8;
        canvas.drawCircle(
          center + Offset(col * 11, row * 11),
          radius,
          dotPaint,
        );
      }
    }

    canvas.drawCircle(
      center + Offset(0, -r * 0.83),
      r * 0.17,
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(
      center + Offset(0, -r * 0.83),
      r * 0.17,
      Paint()
        ..color = blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final userCenter = center + Offset(0, r * 0.83);
    canvas.drawCircle(userCenter, r * 0.065, Paint()..color = Colors.white);
    canvas.drawCircle(
      userCenter,
      r * 0.065,
      Paint()
        ..color = const Color(0xFF59748B)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawCircle(
      userCenter,
      r * (0.033 + pulse * 0.004),
      Paint()..color = const Color(0xFFFFB47C),
    );
  }

  @override
  bool shouldRepaint(covariant _CompassPainter old) =>
      old.progress != progress ||
      old.variant != variant ||
      old.familyMode != familyMode;
}
