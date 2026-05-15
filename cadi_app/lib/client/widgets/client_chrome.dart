import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../shared/theme/app_theme.dart';

class ClientGradientBackground extends StatelessWidget {
  final Widget child;
  final bool peachOnly;

  const ClientGradientBackground({
    super.key,
    required this.child,
    this.peachOnly = true,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          colors: peachOnly
              ? const [
                  Color(0xFFFFD8C7),
                  Color(0xFFFFF7EB),
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ]
              : const [
                  Color(0xFFF5F2FF),
                  Color(0xFFF5FAFF),
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ],
          stops: const [0, 0.34, 0.67, 1],
        ),
      ),
      child: child,
    );
  }
}

class ClientBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color color;

  const ClientBackButton({super.key, this.onTap, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      icon: Icon(Icons.chevron_left_rounded, color: color, size: 24),
      onPressed: onTap ?? () => Navigator.maybePop(context),
    );
  }
}

class CadiWordmark extends StatelessWidget {
  final double size;

  const CadiWordmark({super.key, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/Group 118.png',
      width: size * 2.75,
      fit: BoxFit.contain,
      semanticLabel: 'CADi',
      filterQuality: FilterQuality.high,
    );
  }
}

class CadiTinyMark extends StatelessWidget {
  final double size;

  const CadiTinyMark({super.key, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: _TinyMarkPainter()),
    );
  }
}

class CadiPrimaryPill extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final double width;

  const CadiPrimaryPill({
    super.key,
    required this.label,
    this.onTap,
    this.width = 168,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.peachLight,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.peachLight.withValues(alpha: 0.65),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        child: Text(label),
      ),
    );
  }
}

class CadiInputPill extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSend;
  final String? hintText;
  final bool showMic;
  final bool showPlus;

  const CadiInputPill({
    super.key,
    this.controller,
    this.onSend,
    this.hintText,
    this.showMic = true,
    this.showPlus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFECECEC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (showPlus) ...[
            const Icon(
              Icons.add_circle_rounded,
              color: AppColors.peach,
              size: 24,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 1,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend?.call(),
              decoration: InputDecoration(
                isCollapsed: true,
                hintText: hintText,
                hintStyle: AppTextStyles.caption(
                  context,
                ).copyWith(color: const Color(0xFFB9B5B1)),
                border: InputBorder.none,
              ),
              style: AppTextStyles.body(context),
            ),
          ),
          if (showMic) ...[
            const Icon(
              Icons.mic_none_rounded,
              color: AppColors.peach,
              size: 24,
            ),
            const SizedBox(width: 12),
          ],
          GestureDetector(
            onTap: onSend,
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.peach,
              child: Icon(
                Icons.navigation_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CadiSoftBot extends StatelessWidget {
  final double size;
  final bool blurred;

  const CadiSoftBot({super.key, this.size = 154, this.blurred = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 0.9,
      child: CustomPaint(painter: _BotPainter(blurred: blurred)),
    );
  }
}

class CadiFloatingNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<IconData> icons;

  const CadiFloatingNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(31),
        border: Border.all(color: const Color(0xFFEFEFEF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x24000000),
            blurRadius: 16,
            offset: Offset(0, 7),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(icons.length, (index) {
          final selected = currentIndex == index;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: selected ? 76 : 48,
              height: 46,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: selected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                boxShadow: selected
                    ? const [
                        BoxShadow(
                          color: Color(0x16000000),
                          blurRadius: 12,
                          offset: Offset(0, 5),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icons[index],
                color: AppColors.peach,
                size: selected ? 26 : 23,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _TinyMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.13
      ..color = AppColors.peach;
    canvas.drawCircle(size.center(Offset.zero), size.width * 0.32, paint);
    canvas.drawCircle(size.center(Offset.zero), size.width * 0.1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BotPainter extends CustomPainter {
  final bool blurred;

  _BotPainter({required this.blurred});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Soft drop shadow beneath the bot.
    final shadow = Paint()
      ..color = const Color(0x22000000)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.96),
        width: w * 0.62,
        height: h * 0.08,
      ),
      shadow,
    );

    // Egg-shaped body with a subtle bottom cleft.
    final bodyPath = _buildBodyPath(w, h);
    final body = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFBF5EC), Color(0xFFEFE6D8)],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..maskFilter = blurred
          ? const MaskFilter.blur(BlurStyle.normal, 1.2)
          : null;
    canvas.drawPath(bodyPath, body);

    // Inner highlight to give the body a soft 3D feel.
    final highlight = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.42, h * 0.22),
        width: w * 0.38,
        height: h * 0.18,
      ),
      highlight,
    );

    // Grainy side "ears" — drawn as textured ellipses with speckle dots.
    _drawGrainyEar(
      canvas,
      Rect.fromCenter(
        center: Offset(w * 0.13, h * 0.52),
        width: w * 0.11,
        height: h * 0.30,
      ),
    );
    _drawGrainyEar(
      canvas,
      Rect.fromCenter(
        center: Offset(w * 0.87, h * 0.52),
        width: w * 0.11,
        height: h * 0.30,
      ),
    );

    // Yellow pill eyes near the top, with a soft glow.
    final eyeGlow = Paint()
      ..color = const Color(0xFFFFF4B0).withValues(alpha: 0.55)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    final eye = Paint()..color = const Color(0xFFFFF18A);

    final eyeW = w * 0.04;
    final eyeH = h * 0.10;
    final eyeY = h * 0.22;
    for (final cx in [w * 0.39, w * 0.61]) {
      final rect = Rect.fromCenter(
        center: Offset(cx, eyeY),
        width: eyeW,
        height: eyeH,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect.inflate(2), Radius.circular(eyeW)),
        eyeGlow,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(eyeW)),
        eye,
      );
    }
  }

  Path _buildBodyPath(double w, double h) {
    // Egg silhouette: wider, rounded top; slightly tapered bottom with a tiny dip.
    final left = w * 0.14;
    final right = w * 0.86;
    final top = h * 0.04;
    final bottom = h * 0.92;
    final midY = h * 0.55;

    final path = Path()
      ..moveTo(w * 0.5, top)
      // top-right curve
      ..cubicTo(right + (w * 0.04), top, right, midY * 0.6, right, midY)
      // right side down to bottom-right
      ..cubicTo(
        right,
        bottom - h * 0.05,
        w * 0.78,
        bottom,
        w * 0.58,
        bottom - h * 0.02,
      )
      // small bottom cleft
      ..cubicTo(
        w * 0.54,
        bottom + h * 0.01,
        w * 0.46,
        bottom + h * 0.01,
        w * 0.42,
        bottom - h * 0.02,
      )
      // bottom-left up
      ..cubicTo(w * 0.22, bottom, left, bottom - h * 0.05, left, midY)
      // left side up to top
      ..cubicTo(left, midY * 0.6, left - (w * 0.04), top, w * 0.5, top)
      ..close();
    return path;
  }

  void _drawGrainyEar(Canvas canvas, Rect rect) {
    // Base soft fill.
    final base = Paint()
      ..color = const Color(0xFF9AA4AD).withValues(alpha: 0.32)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawOval(rect, base);

    // Speckle texture clipped to the ear oval.
    canvas.save();
    canvas.clipPath(Path()..addOval(rect));
    final rng = math.Random(rect.center.dx.toInt());
    final dot = Paint()
      ..color = const Color(0xFF6A7682).withValues(alpha: 0.55);
    final dotCount = 90;
    for (var i = 0; i < dotCount; i++) {
      final dx = rect.left + rng.nextDouble() * rect.width;
      final dy = rect.top + rng.nextDouble() * rect.height;
      final r = 0.4 + rng.nextDouble() * 0.9;
      dot.color = Color.fromRGBO(
        90 + rng.nextInt(40),
        100 + rng.nextInt(40),
        110 + rng.nextInt(40),
        0.35 + rng.nextDouble() * 0.4,
      );
      canvas.drawCircle(Offset(dx, dy), r, dot);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _BotPainter oldDelegate) =>
      oldDelegate.blurred != blurred;
}

class OrganicMoodOrb extends StatefulWidget {
  final double size;

  const OrganicMoodOrb({super.key, this.size = 176});

  @override
  State<OrganicMoodOrb> createState() => _OrganicMoodOrbState();
}

class _OrganicMoodOrbState extends State<OrganicMoodOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
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
        return SizedBox.square(
          dimension: widget.size,
          child: CustomPaint(painter: _OrbPainter(progress: _controller.value)),
        );
      },
    );
  }
}

class _OrbPainter extends CustomPainter {
  final double progress;

  _OrbPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w * 0.5, h * 0.48);
    final breathing = math.sin(progress * math.pi * 2) * w * 0.006;

    final shadow = Paint()
      ..shader =
          const LinearGradient(
            colors: [
              Color(0x00FFFFFF),
              Color(0x33FFA384),
              Color(0x16F0D2A1),
              Color(0x00FFFFFF),
            ],
          ).createShader(
            Rect.fromCenter(
              center: Offset(w * 0.5, h * 0.88),
              width: w * 0.56,
              height: h * 0.07,
            ),
          )
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 0.035);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.88),
        width: w * 0.48,
        height: h * 0.024,
      ),
      shadow,
    );

    final bodyRect = Rect.fromCenter(
      center: center,
      width: w * 0.62 + breathing,
      height: h * 0.62 + breathing,
    );
    final body = Paint()
      ..shader = const RadialGradient(
        center: Alignment(0.0, 0.08),
        radius: 0.62,
        colors: [
          Color(0xFFFFF6D8),
          Color(0xFFFFE0BB),
          Color(0xFFFFB18E),
          Color(0x00FFB18E),
        ],
        stops: [0.0, 0.46, 0.78, 1.0],
      ).createShader(bodyRect.inflate(w * 0.06))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 0.018);
    canvas.drawOval(bodyRect, body);

    final glow = Paint()
      ..color = const Color(0xFFFFD6B5).withValues(alpha: 0.22)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 0.055);
    canvas.drawOval(bodyRect.inflate(w * 0.025), glow);

    _drawSideCaps(canvas, size, breathing);
    _drawFace(canvas, size);
  }

  void _drawSideCaps(Canvas canvas, Size size, double breathing) {
    final w = size.width;
    final h = size.height;
    final leftCap = Rect.fromCenter(
      center: Offset(w * 0.24, h * 0.48),
      width: w * 0.28 + breathing,
      height: h * 0.34,
    );
    final rightCap = Rect.fromCenter(
      center: Offset(w * 0.76, h * 0.47),
      width: w * 0.27 + breathing,
      height: h * 0.32,
    );

    final leftPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(0.25, 0.04),
        colors: [Color(0xFFFFF2E7), Color(0xFFFFBA99), Color(0x00FFBA99)],
        stops: [0.0, 0.62, 1.0],
      ).createShader(leftCap.inflate(w * 0.04))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 0.015);
    final rightPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.12, 0.02),
        colors: [Color(0xFFFFF2E7), Color(0xFFFFBA99), Color(0x00FFBA99)],
        stops: [0.0, 0.6, 1.0],
      ).createShader(rightCap.inflate(w * 0.04))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 0.015);

    _drawSoftEarEdge(canvas, leftCap, isLeft: true);
    canvas.drawOval(leftCap, leftPaint);
    canvas.drawOval(rightCap, rightPaint);
  }

  void _drawSoftEarEdge(Canvas canvas, Rect cap, {required bool isLeft}) {
    final clip = Path()..addOval(cap);
    final edge = Paint()
      ..color = const Color(0xFF828990).withValues(alpha: 0.36)
      ..style = PaintingStyle.stroke
      ..strokeWidth = cap.width * 0.035
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, cap.width * 0.012);

    canvas.save();
    canvas.clipPath(clip);
    final x = isLeft
        ? cap.left + cap.width * 0.12
        : cap.right - cap.width * 0.12;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(x, cap.center.dy),
        width: cap.width * 0.72,
        height: cap.height * 1.02,
      ),
      isLeft ? -math.pi / 2 : math.pi / 2,
      math.pi,
      false,
      edge,
    );
    canvas.restore();
  }

  void _drawFace(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final eyePaint = Paint()..color = Colors.white.withValues(alpha: 0.9);
    final dashW = w * 0.035;
    final dashH = h * 0.009;
    final startX = w * 0.285;

    for (final y in [h * 0.438, h * 0.502]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(startX, y, dashW, dashH),
          Radius.circular(dashH),
        ),
        eyePaint,
      );
      canvas.drawCircle(
        Offset(startX - dashW * 0.38, y + dashH / 2),
        dashH / 2,
        eyePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _OrbPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
