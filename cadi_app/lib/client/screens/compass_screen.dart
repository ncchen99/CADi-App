// C11 / C12 — 定位指北針 (Figma nodes 1:6, 1:7)
// 機器人的位置就是光圈裡面那個精靈的位置,中間有點像指北針,指向機器人位置
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme/app_theme.dart';
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
  late bool _variant;

  @override
  void initState() {
    super.initState();
    _variant = widget.variant;
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Spin nicely
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backPath = widget.familyMode ? '/family' : '/client';
    return Scaffold(
      body: ClientGradientBackground(
        peachOnly: !widget.familyMode,
        child: SafeArea(
          child: GestureDetector(
            onHorizontalDragEnd: (_) {
              setState(() => _variant = !_variant);
            },
            behavior: HitTestBehavior.opaque,
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  left: 8,
                  child: ClientBackButton(onTap: () => context.go(backPath)),
                ),
                Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      widget.familyMode ? '家屬指北針' : '尋找機器人',
                      style: GoogleFonts.lexend(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF3A3939),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: AnimatedBuilder(
                    animation: _ctrl,
                    builder: (context, _) {
                      return CustomPaint(
                        size: const Size(320, 320),
                        painter: _CompassPainter(
                          angle: _ctrl.value * 2 * math.pi,
                          variant: _variant,
                          familyMode: widget.familyMode,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 120,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _ctrl,
                      builder: (context, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'listen ',
                              style: GoogleFonts.lexend(
                                color: const Color(0xFF9E958E),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.5,
                              ),
                            ),
                            ...List.generate(3, (i) {
                              final active = ((_ctrl.value * 3).floor() % 3) == i;
                              return AnimatedOpacity(
                                duration: const Duration(milliseconds: 150),
                                opacity: active ? 1.0 : 0.25,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: Text(
                                    '●',
                                    style: TextStyle(
                                      color: AppColors.peach,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 60,
                  child: Center(
                    child: Text(
                      _variant ? '機器人就在附近' : '機器人位於東北方 12m',
                      style: AppTextStyles.body(context).copyWith(
                        color: const Color(0xFF3A3939),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 22,
                  child: Center(
                    child: Text(
                      '左右滑動切換顯示',
                      style: AppTextStyles.caption(context).copyWith(
                        color: const Color(0xFF9E958E),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  final double angle;
  final bool variant;
  final bool familyMode;

  _CompassPainter({
    required this.angle,
    required this.variant,
    required this.familyMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.width / 2;

    // 1. Concentric fuzzy/glowing halos using RadialGradient
    final outerGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFEADA).withValues(alpha: 0.65),
          const Color(0xFFFFF7EB).withValues(alpha: 0.15),
          const Color(0xFFFFFFFF).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: r));
    canvas.drawCircle(center, r, outerGlow);

    // Inner fuzzy halo ring
    final innerGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFD5C2).withValues(alpha: 0.45),
          const Color(0xFFFFEADA).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: r * 0.7));
    canvas.drawCircle(center, r * 0.7, innerGlow);

    // concentric thin stroked lines for compass realism
    final linePaint = Paint()
      ..color = const Color(0xFFFFB292).withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, r * 0.75, linePaint);
    canvas.drawCircle(center, r * 0.52, linePaint);

    // Draw little tick marks on outer ring for compass aesthetic
    final tickPaint = Paint()
      ..color = const Color(0xFFFFB292).withValues(alpha: 0.5)
      ..strokeWidth = 1.5;
    for (int i = 0; i < 12; i++) {
      final double theta = i * 2 * math.pi / 12;
      final p1 = center + Offset(math.cos(theta), math.sin(theta)) * (r * 0.72);
      final p2 = center + Offset(math.cos(theta), math.sin(theta)) * (r * 0.77);
      canvas.drawLine(p1, p2, tickPaint);
    }

    // 2. Beautiful 3D-looking peach/orange central sphere
    final centerSphereRect = Rect.fromCircle(center: center, radius: r * 0.28);
    final centerSphere = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.25, -0.25),
        radius: 0.8,
        colors: [
          Color(0xFFFFEADC),
          Color(0xFFFF8E6C),
          Color(0xFFE05F38),
        ],
      ).createShader(centerSphereRect);
    
    // Shadow for central 3D sphere
    canvas.drawCircle(
      center + const Offset(0, 4),
      r * 0.28,
      Paint()
        ..color = const Color(0x22000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawCircle(center, r * 0.28, centerSphere);

    // 3. A sharp white needle/arrow pointing from the center outward
    final needleAngle = angle - math.pi / 2;
    final tip = center + Offset(math.cos(needleAngle), math.sin(needleAngle)) * (r * 0.65);
    
    final needlePath = Path();
    final baseAngleLeft = needleAngle + math.pi / 2 + 0.15;
    final baseAngleRight = needleAngle - math.pi / 2 - 0.15;
    final baseLeft = center + Offset(math.cos(baseAngleLeft), math.sin(baseAngleLeft)) * 10;
    final baseRight = center + Offset(math.cos(baseAngleRight), math.sin(baseAngleRight)) * 10;
    needlePath.moveTo(tip.dx, tip.dy);
    needlePath.lineTo(baseLeft.dx, baseLeft.dy);
    needlePath.lineTo(baseRight.dx, baseRight.dy);
    needlePath.close();

    final needlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    // Draw needle shadow
    canvas.save();
    canvas.translate(0, 3);
    canvas.drawPath(
      needlePath,
      Paint()
        ..color = const Color(0x1F000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.restore();
    
    canvas.drawPath(needlePath, needlePaint);

    // 4. A cute yellow elf/sprite in a small circle rotating smoothly along the outer ring
    // We place it on the outer ring, aligned with the pointing needle angle or slightly offset
    final elfAngle = needleAngle; // Keep in sync for standard direction pointer
    final elfCenter = center + Offset(math.cos(elfAngle), math.sin(elfAngle)) * (r * 0.76);

    // Shadow for elf base
    canvas.drawCircle(
      elfCenter,
      18,
      Paint()
        ..color = const Color(0x1A000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // White circle base
    final elfBasePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(elfCenter, 18, elfBasePaint);

    // Yellow gradient face
    final elfFacePaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.1, -0.1),
        radius: 0.8,
        colors: [
          Color(0xFFFFF6D8),
          Color(0xFFFFD17B),
          Color(0xFFFF9E6C),
        ],
      ).createShader(Rect.fromCircle(center: elfCenter, radius: 15));
    canvas.drawCircle(elfCenter, 15, elfFacePaint);

    // Eyes
    final eyePaint = Paint()..color = const Color(0xFF4A3E3D);
    canvas.drawCircle(elfCenter + const Offset(-4, -1), 1.8, eyePaint);
    canvas.drawCircle(elfCenter + const Offset(4, -1), 1.8, eyePaint);

    // Blush cheeks
    final cheekPaint = Paint()
      ..color = const Color(0xFFFF5E5E).withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.2);
    canvas.drawCircle(elfCenter + const Offset(-6, 3), 2.2, cheekPaint);
    canvas.drawCircle(elfCenter + const Offset(6, 3), 2.2, cheekPaint);

    // 5. Family overlay position (optional, maintained for integrity)
    if (familyMode) {
      final userOffset = center + const Offset(0, 96);
      canvas.drawCircle(
        userOffset,
        8,
        Paint()
          ..color = AppColors.glowBlue
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CompassPainter old) =>
      old.angle != angle || old.variant != variant;
}
