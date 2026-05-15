// Figma: 1:1384 (患者狀態總覽)
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../client/widgets/client_chrome.dart';
import '../../shared/theme/app_theme.dart';
import '../widgets/family_chrome.dart';

class PatientStatusScreen extends StatelessWidget {
  const PatientStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FamilySoftBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            child: Column(
              children: [
                FamilyTopBar(onBack: () => context.go('/family')),
                const SizedBox(height: 12),
                FamilyPanel(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),
                  child: Column(
                    children: [
                      Text(
                        'Hi',
                        style: AppTextStyles.displayLarge(context).copyWith(
                          color: const Color(0xFF6EA6C9),
                          fontSize: 34,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '今天患者感覺怎麼樣',
                        style: AppTextStyles.body(context).copyWith(fontSize: 13),
                      ),
                      const SizedBox(height: 30),
                      const CadiSoftBot(size: 164),
                      const SizedBox(height: 30),
                      const FamilyStatusPill(
                        mood: '情緒穩定',
                        location: '客廳',
                        time: '30 分鐘前',
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 420.ms).slideY(begin: 0.04),
                const SizedBox(height: 18),
                _StatusTile(
                  icon: Icons.auto_awesome_rounded,
                  label: '今日情緒',
                  value: '平靜、願意互動',
                ).animate().fadeIn(delay: 100.ms),
                const SizedBox(height: 10),
                _StatusTile(
                  icon: Icons.place_outlined,
                  label: '目前位置',
                  value: '客廳附近',
                ).animate().fadeIn(delay: 170.ms),
                const SizedBox(height: 10),
                _StatusTile(
                  icon: Icons.schedule_rounded,
                  label: '最後偵測',
                  value: '30 分鐘前',
                ).animate().fadeIn(delay: 240.ms),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton.icon(
                    onPressed: () => context.go('/family/chat'),
                    icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                    label: const Text('詢問 CADi 照護建議'),
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF6EA6C9),
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 320.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatusTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFECEFF4)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF6EA6C9)),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.caption(context).copyWith(fontSize: 12),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.body(context).copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
