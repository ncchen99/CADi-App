import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'shared/storage/app_storage.dart';
import 'client/screens/ai_chat_screen.dart';
import 'client/screens/archive_screens.dart';
import 'client/screens/client_home_screen.dart';
import 'client/screens/client_splash_screen.dart';
import 'client/screens/compass_screen.dart';
import 'client/screens/edu_video_screen.dart';
import 'client/screens/life_story_screen.dart';
import 'client/screens/mood_checkin_screen.dart';
import 'client/screens/mosaic_puzzle_screen.dart';
import 'client/screens/motivation_screen.dart';
import 'client/screens/onboarding_intro_screen.dart';
import 'client/screens/onboarding_screen.dart';
import 'client/screens/status_gallery_screen.dart';
import 'client/screens/tunnel_morning_screen.dart';
import 'client/screens/tunnel_quote_screen.dart';
import 'family/screens/family_home_screen.dart';
import 'family/screens/family_letter_screens.dart';
import 'family/screens/family_splash_screen.dart';
import 'family/screens/family_video_screens.dart';
import 'family/screens/patient_letter_screen.dart';
import 'family/screens/patient_status_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    if (state.matchedLocation != '/') return null;
    final mode = AppStorage.lastMode;
    if (mode == 'client') {
      return AppStorage.onboardingDone
          ? '/client'
          : '/client/onboarding/intro';
    }
    if (mode == 'family') return '/family/splash';
    return '/mode-select';
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const SizedBox.shrink(),
    ),
    GoRoute(
      path: '/mode-select',
      builder: (_, __) => const ModeSelectScreen(),
    ),

    // ── CLIENT ──────────────────────────────────────
    GoRoute(
      path: '/client/onboarding/intro', // C0
      builder: (_, __) => const OnboardingIntroScreen(),
    ),
    GoRoute(
      path: '/client/onboarding', // C1 → C2 → C3 (PageView)
      builder: (_, __) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/client/onboarding/gallery', // C4
      builder: (_, __) => const StatusGalleryScreen(),
    ),
    GoRoute(
      path: '/client/splash', // C5
      builder: (_, __) => const ClientSplashScreen(),
    ),
    GoRoute(
      path: '/client', // C6
      builder: (_, __) => const ClientHomeScreen(),
      routes: [
        GoRoute(
          path: 'mood',
          builder: (_, __) => const MoodCheckinScreen(),
        ),
        GoRoute(
          path: 'chat', // C9 已開始
          builder: (_, __) =>
              const AiChatScreen(mode: ChatMode.client, started: true),
        ),
        GoRoute(
          path: 'chat-new', // C8 剛開始
          builder: (_, __) =>
              const AiChatScreen(mode: ChatMode.client, started: false),
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
    GoRoute(
      path: '/client/mosaic', // C7
      builder: (_, __) => const MosaicPuzzleScreen(),
    ),
    GoRoute(
      path: '/client/edu-video', // C10
      builder: (_, __) => const EduVideoScreen(),
    ),
    GoRoute(
      path: '/client/compass', // C11
      builder: (_, __) => const CompassScreen(),
    ),
    GoRoute(
      path: '/client/compass-2', // C12
      builder: (_, __) => const CompassScreen(variant: true),
    ),
    // ── Tunnel sequence (N1→N2→N3) ─────
    GoRoute(
      path: '/client/tunnel/morning', // N1
      builder: (_, __) => const TunnelMorningScreen(),
    ),
    GoRoute(
      path: '/client/tunnel/play', // N2
      builder: (_, __) => const MotivationScreen(),
    ),
    GoRoute(
      path: '/client/tunnel/quote', // N3
      builder: (_, __) => const TunnelQuoteScreen(),
    ),
    // ── Archive (A1–A6) ────────────────
    GoRoute(
      path: '/client/archive/date', // A1
      builder: (_, __) => const ArchiveDateScreen(),
    ),
    GoRoute(
      path: '/client/archive/content', // A2
      builder: (_, __) => const ArchiveContentScreen(),
    ),
    GoRoute(
      path: '/client/archive/emotion', // A3
      builder: (_, __) => const ArchiveEmotionScreen(),
    ),
    GoRoute(
      path: '/client/archive/emotion-list', // A4
      builder: (_, __) => const ArchiveEmotionListScreen(),
    ),
    GoRoute(
      path: '/client/archive/date-detail', // A5
      builder: (_, __) => const ArchiveDateDetailScreen(),
    ),
    GoRoute(
      path: '/client/archive/content-detail', // A6
      builder: (_, __) => const ArchiveContentDetailScreen(),
    ),

    // ── FAMILY ──────────────────────────────────────
    GoRoute(
      path: '/family/splash', // F0
      builder: (_, __) => const FamilySplashScreen(),
    ),
    GoRoute(
      path: '/family', // F1
      builder: (_, __) => const FamilyHomeScreen(),
      routes: [
        GoRoute(
          path: 'status',
          builder: (_, __) => const PatientStatusScreen(),
        ),
        GoRoute(
          path: 'chat', // F4 已開始
          builder: (_, __) =>
              const AiChatScreen(mode: ChatMode.family, started: true),
        ),
        GoRoute(
          path: 'chat-new', // F3 剛開始
          builder: (_, __) =>
              const AiChatScreen(mode: ChatMode.family, started: false),
        ),
        GoRoute(
          path: 'letter',
          builder: (_, __) => const PatientLetterScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/family/compass', // F2
      builder: (_, __) => const CompassScreen(familyMode: true),
    ),
    // ── Letter sequence (F5–F9) ────
    GoRoute(
      path: '/family/letter/notify', // F5
      builder: (_, __) => const FamilyLetterNotifyScreen(),
    ),
    GoRoute(
      path: '/family/letter/envelope', // F6
      builder: (_, __) => const FamilyEnvelopeScreen(),
    ),
    GoRoute(
      path: '/family/letter/glow', // F7
      builder: (_, __) => const FamilyLetterGlowScreen(),
    ),
    GoRoute(
      path: '/family/letter/gradient', // F8
      builder: (_, __) => const FamilyLetterGradientScreen(),
    ),
    GoRoute(
      path: '/family/letter/content', // F9
      builder: (_, __) => const FamilyLetterContentScreen(),
    ),
    // ── Video (F10–F12) ────
    GoRoute(
      path: '/family/video/list', // F10
      builder: (_, __) => const FamilyVideoListScreen(),
    ),
    GoRoute(
      path: '/family/video/vertical', // F11
      builder: (_, __) => const FamilyVerticalVideoScreen(),
    ),
    GoRoute(
      path: '/family/video/horizontal', // F12
      builder: (_, __) => const FamilyHorizontalVideoScreen(),
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
                onTap: () async {
                  await AppStorage.setMode('client');
                  if (!context.mounted) return;
                  context.go(
                    AppStorage.onboardingDone
                        ? '/client'
                        : '/client/onboarding/intro',
                  );
                },
              ),
              const SizedBox(height: 16),
              _ModeCard(
                title: '我是家屬',
                subtitle: '照護支援模式',
                icon: Icons.family_restroom_rounded,
                color: const Color(0xFFC5E8F9),
                onTap: () async {
                  await AppStorage.setMode('family');
                  if (!context.mounted) return;
                  context.go('/family/splash');
                },
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: () async {
                  await AppStorage.clearAll();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('已清除本地紀錄'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: const Text(
                  '清除本地紀錄',
                  style: TextStyle(color: Color(0xFF9A9A9A), fontSize: 12),
                ),
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
          color: color.withValues(alpha: 0.3),
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
