import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../client/widgets/client_chrome.dart';
import '../../shared/theme/app_theme.dart';

class FamilySoftBackground extends StatelessWidget {
  final Widget child;
  final bool warm;

  const FamilySoftBackground({
    super.key,
    required this.child,
    this.warm = false,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          colors: warm
              ? const [Color(0xFFFFE8D9), Color(0xFFFFF8EF), Color(0xFFFFFFFF)]
              : const [Color(0xFFF5F2FF), Color(0xFFF5FAFF), Color(0xFFFFFFFF)],
          stops: const [0, 0.48, 1],
        ),
      ),
      child: child,
    );
  }
}

class FamilyTopBar extends StatelessWidget {
  final VoidCallback? onBack;
  final bool tools;
  final Color color;

  const FamilyTopBar({
    super.key,
    this.onBack,
    this.tools = false,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClientBackButton(color: color, onTap: onBack ?? () => context.pop()),
        const Spacer(),
        if (tools) ...[
          Icon(Icons.search_rounded, size: 21, color: color),
          const SizedBox(width: 22),
          Icon(Icons.swap_horiz_rounded, size: 23, color: color),
        ],
      ],
    );
  }
}

class FamilyPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const FamilyPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class FamilyStatusPill extends StatelessWidget {
  final String mood;
  final String location;
  final String time;

  const FamilyStatusPill({
    super.key,
    required this.mood,
    required this.location,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: const Color(0xFFECEFF4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          _PillItem(icon: Icons.auto_awesome_rounded, text: mood),
          const Spacer(),
          _PillItem(icon: Icons.place_outlined, text: location),
          const Spacer(),
          _PillItem(icon: Icons.visibility_rounded, text: time),
        ],
      ),
    );
  }
}

class _PillItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PillItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF6EA6C9)),
        const SizedBox(width: 5),
        Text(
          text,
          style: AppTextStyles.caption(
            context,
          ).copyWith(color: AppColors.primaryText, fontSize: 10),
        ),
      ],
    );
  }
}

class FamilyVideoStill extends StatelessWidget {
  final bool horizontal;
  final bool dark;

  const FamilyVideoStill({
    super.key,
    this.horizontal = false,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          horizontal
              ? 'assets/images/life_story/photo_9.jpg'
              : 'assets/images/life_story/photo_13.jpg',
          fit: BoxFit.cover,
        ),
        if (dark)
          const DecoratedBox(
            decoration: BoxDecoration(color: Color(0x66000000)),
          ),
        Center(
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.78),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: AppColors.primaryText,
              size: 36,
            ),
          ),
        ),
      ],
    );
  }
}
