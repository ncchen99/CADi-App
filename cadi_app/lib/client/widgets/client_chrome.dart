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
                  Color(0xFFFFD7C7),
                  Color(0xFFFFF4E7),
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFCF8),
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
    return Text(
      'CADi',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.peach,
        fontSize: size,
        fontWeight: FontWeight.w800,
        letterSpacing: size * 0.08,
        shadows: const [
          Shadow(color: Color(0x55FFB08A), blurRadius: 8, offset: Offset(0, 1)),
          Shadow(color: Colors.white, blurRadius: 1, offset: Offset(0, -1)),
        ],
      ),
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
    final body = Paint()
      ..color = const Color(0xFFF6EFE7).withValues(alpha: 0.9)
      ..maskFilter = blurred
          ? const MaskFilter.blur(BlurStyle.normal, 10)
          : null;
    final side = Paint()
      ..color = const Color(0xFF738088).withValues(alpha: 0.42)
      ..maskFilter = blurred
          ? const MaskFilter.blur(BlurStyle.normal, 3)
          : null;
    final eye = Paint()..color = const Color(0xFFFFFFB9).withValues(alpha: 0.9);

    final rect = Rect.fromLTWH(
      size.width * 0.18,
      size.height * 0.05,
      size.width * 0.64,
      size.height * 0.82,
    );
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topLeft: Radius.circular(size.width * 0.34),
        topRight: Radius.circular(size.width * 0.34),
        bottomLeft: Radius.circular(size.width * 0.08),
        bottomRight: Radius.circular(size.width * 0.08),
      ),
      body,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.12,
          size.height * 0.47,
          size.width * 0.09,
          size.height * 0.36,
        ),
        const Radius.circular(18),
      ),
      side,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.79,
          size.height * 0.47,
          size.width * 0.09,
          size.height * 0.36,
        ),
        const Radius.circular(18),
      ),
      side,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.38,
          size.height * 0.35,
          size.width * 0.035,
          size.height * 0.12,
        ),
        const Radius.circular(6),
      ),
      eye,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.59,
          size.height * 0.35,
          size.width * 0.035,
          size.height * 0.12,
        ),
        const Radius.circular(6),
      ),
      eye,
    );
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
        return CustomPaint(
          size: Size.square(widget.size),
          painter: _OrbPainter(progress: _controller.value),
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
    final center = size.center(Offset.zero);
    final paint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFFF1D9), Color(0xFFFFB78F), Color(0x00FFB78F)],
        stops: [0, 0.48, 1],
      ).createShader(Rect.fromCircle(center: center, radius: size.width * 0.47))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    final path = Path();
    for (var i = 0; i < 42; i++) {
      final angle = i / 42 * math.pi * 2;
      final wobble = math.sin(angle * 3 + progress * math.pi * 2) * 6;
      final radius = size.width * 0.34 + wobble;
      final point = center + Offset(math.cos(angle), math.sin(angle)) * radius;
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);

    final satellite = Paint()
      ..shader =
          const RadialGradient(
            colors: [Colors.white, Color(0xFFFFB99A), Color(0x00FFB99A)],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.2, size.height * 0.52),
              radius: 46,
            ),
          )
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.52),
      42,
      satellite,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.45),
      42,
      satellite,
    );
  }

  @override
  bool shouldRepaint(covariant _OrbPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
