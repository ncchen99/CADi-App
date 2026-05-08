// Figma: 1:1384 (病人狀態總覽)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../shared/theme/app_theme.dart';

class PatientStatusScreen extends StatelessWidget {
  const PatientStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('家人狀態',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting + robot — matches Figma 1:1384 layout
            _StatusHeader().animate().fadeIn(duration: 500.ms),
            const SizedBox(height: 24),
            // Status cards
            _StatusCard(
              label: '今日情緒',
              value: '情緒穩定',
              icon: Icons.sentiment_satisfied_rounded,
              color: const Color(0xFFE5F5E5),
              iconColor: Colors.green,
            ).animate().fadeIn(delay: 100.ms).slideX(begin: 0.05),
            const SizedBox(height: 12),
            _StatusCard(
              label: '目前位置',
              value: '客廳',
              icon: Icons.location_on_rounded,
              color: const Color(0xFFE8F4FF),
              iconColor: Colors.blue,
            ).animate().fadeIn(delay: 180.ms).slideX(begin: 0.05),
            const SizedBox(height: 12),
            _StatusCard(
              label: '最後更新',
              value: '30 分鐘前',
              icon: Icons.access_time_rounded,
              color: AppColors.surface,
              iconColor: AppColors.secondaryText,
            ).animate().fadeIn(delay: 260.ms).slideX(begin: 0.05),
            const SizedBox(height: 28),
            // AI Chat CTA
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed: () => context.go('/family/chat'),
                icon: const Icon(Icons.chat_bubble_rounded, size: 18),
                label: const Text('詢問 CADi 照護建議',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryText,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                ),
              ),
            ).animate().fadeIn(delay: 350.ms),
          ],
        ),
      ),
    );
  }
}

class _StatusHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.glowBlue.withOpacity(0.3),
            AppColors.glowPurple.withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('今天感覺怎麼樣',
                    style: TextStyle(
                        fontSize: 13, color: AppColors.secondaryText)),
                SizedBox(height: 4),
                Text('Hi',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryText)),
              ],
            ),
          ),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.glowBlue.withOpacity(0.4),
            ),
            child: const Icon(Icons.smart_toy_rounded,
                size: 40, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const _StatusCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: iconColor),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.secondaryText)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText)),
            ],
          ),
        ],
      ),
    );
  }
}
