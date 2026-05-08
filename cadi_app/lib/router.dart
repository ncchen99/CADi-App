import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'client/screens/client_home_screen.dart';
import 'client/screens/mood_checkin_screen.dart';
import 'client/screens/ai_chat_screen.dart';
import 'client/screens/life_story_screen.dart';
import 'client/screens/onboarding_screen.dart';
import 'client/screens/motivation_screen.dart';
import 'family/screens/family_home_screen.dart';
import 'family/screens/patient_status_screen.dart';
import 'family/screens/family_chat_screen.dart';
import 'family/screens/patient_letter_screen.dart';

final router = GoRouter(
  initialLocation: '/mode-select',
  routes: [
    GoRoute(
      path: '/mode-select',
      builder: (_, __) => const ModeSelectScreen(),
    ),
    // CLIENT routes
    GoRoute(
      path: '/client/onboarding',
      builder: (_, __) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/client',
      builder: (_, __) => const ClientHomeScreen(),
      routes: [
        GoRoute(
          path: 'mood',
          builder: (_, __) => const MoodCheckinScreen(),
        ),
        GoRoute(
          path: 'chat',
          builder: (_, __) => const AiChatScreen(mode: ChatMode.client),
        ),
        GoRoute(
          path: 'life-story',
          builder: (_, __) => const LifeStoryScreen(),
        ),
        GoRoute(
          path: 'motivation',
          builder: (_, __) => const MotivationScreen(),
        ),
      ],
    ),
    // FAMILY routes
    GoRoute(
      path: '/family',
      builder: (_, __) => const FamilyHomeScreen(),
      routes: [
        GoRoute(
          path: 'status',
          builder: (_, __) => const PatientStatusScreen(),
        ),
        GoRoute(
          path: 'chat',
          builder: (_, __) => const AiChatScreen(mode: ChatMode.family),
        ),
        GoRoute(
          path: 'letter',
          builder: (_, __) => const PatientLetterScreen(),
        ),
      ],
    ),
  ],
);

class ModeSelectScreen extends StatelessWidget {
  const ModeSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'CADi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3A3939),
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '請選擇使用模式',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF7A7A7A)),
              ),
              const SizedBox(height: 60),
              _ModeCard(
                title: '我是病人',
                subtitle: '個人陪伴模式',
                icon: Icons.person_rounded,
                color: const Color(0xFFD4C5F9),
                onTap: () => context.go('/client/onboarding'),
              ),
              const SizedBox(height: 16),
              _ModeCard(
                title: '我是家屬',
                subtitle: '照護支援模式',
                icon: Icons.family_restroom_rounded,
                color: const Color(0xFFC5E8F9),
                onTap: () => context.go('/family'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3A3939),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF7A7A7A),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 16, color: Color(0xFF7A7A7A)),
          ],
        ),
      ),
    );
  }
}
