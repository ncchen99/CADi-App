// C11 / C12 — 定位指北針 (Figma nodes 1:6, 1:7)
// 機器人的位置就是光圈裡面那個精靈的位置,中間有點像指北針,指向機器人位置
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      duration: const Duration(seconds: 12),
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
                      widget.familyMode ? '家屬指北針' : '定位指北針',
                      style: AppTextStyles.heading1(context),
                    ),
                  ),
                ),
                Center(
                  child: AnimatedBuilder(
                    animation: _ctrl,
                    builder: (context, _) {
                      return CustomPaint(
                        size: const Size(300, 300),
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
                  bottom: 60,
                  child: Center(
                    child: Text(
                      _variant ? '機器人就在附近' : '機器人位於東北方 12m',
                      style: AppTextStyles.body(context),
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
                      style: AppTextStyles.caption(context),
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

    // outer glow ring
    final glow = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.peachLight.withValues(alpha: 0.5),
          AppColors.peach.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: r));
    canvas.drawCircle(center, r, glow);

    // middle ring
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = AppColors.peach.withValues(alpha: 0.6);
    canvas.drawCircle(center, r * 0.66, ring);
    canvas.drawCircle(center, r * 0.42, ring);

    // bot dot (white = robot)
    final bot = Paint()..color = Colors.white;
    canvas.drawCircle(center, 10, bot);

    // needle pointing
    final needleAngle = variant ? angle * 0.3 : angle;
    final tip =
        center +
        Offset(
              math.cos(needleAngle - math.pi / 2),
              math.sin(needleAngle - math.pi / 2),
            ) *
            (r * 0.6);
    final needle = Paint()
      ..color = AppColors.peach
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, tip, needle);
    canvas.drawCircle(tip, 6, Paint()..color = AppColors.peach);

    // family overlay — user position
    if (familyMode) {
      final userOffset = center + const Offset(0, 90);
      canvas.drawCircle(userOffset, 8, Paint()..color = AppColors.glowBlue);
    }
  }

  @override
  bool shouldRepaint(covariant _CompassPainter old) =>
      old.angle != angle || old.variant != variant;
}
