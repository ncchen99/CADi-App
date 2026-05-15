// F5–F9 家屬安慰/信封序列
// F5 1:62 安慰通知, F6 1:59 信封, F7 1:56 光球, F8 1:67 漸層, F9 1:58 信封內容
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';

// ── F5 家屬安慰通知 (1:62) ──
class FamilyLetterNotifyScreen extends StatelessWidget {
  const FamilyLetterNotifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF5),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.push('/family/letter/envelope'),
          child: Stack(
            children: [
              Positioned(
                top: 80,
                left: 24,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.favorite_rounded,
                          color: AppColors.peach, size: 36),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('家人想念你',
                                style: AppTextStyles.heading2(context)),
                            const SizedBox(height: 4),
                            Text(
                              '使用者心情似乎不太好,點開看看',
                              style: AppTextStyles.caption(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().slideY(begin: -0.5, duration: 500.ms),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 60,
                child: Center(
                  child: Text(
                    '輕點任意處繼續',
                    style: AppTextStyles.caption(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── F6 信封家屬 (1:59) ──
class FamilyEnvelopeScreen extends StatelessWidget {
  const FamilyEnvelopeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF5),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.push('/family/letter/glow'),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 220,
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppColors.peachLight,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.mail_outline_rounded,
                      size: 80, color: Colors.white),
                )
                    .animate()
                    .scale(
                      begin: const Offset(0.7, 0.7),
                      duration: 700.ms,
                      curve: Curves.elasticOut,
                    )
                    .fadeIn(),
                const SizedBox(height: 40),
                Text(
                  '有一封信給你',
                  style: AppTextStyles.heading1(context),
                ).animate().fadeIn(delay: 600.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── F7 光球彈出家屬 (1:56) ──
class FamilyLetterGlowScreen extends StatelessWidget {
  const FamilyLetterGlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.push('/family/letter/gradient'),
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFFFC5AA),
                        Color(0x00FFC5AA),
                      ],
                      stops: [0, 0.45, 1],
                    ),
                  ),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1.1, 1.1),
                      duration: 1600.ms,
                      curve: Curves.easeInOut,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── F8 漸層彈出,光球維持 (1:67) ──
class FamilyLetterGradientScreen extends StatelessWidget {
  const FamilyLetterGradientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.push('/family/letter/content'),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.2,
              colors: [
                Color(0xFFFFE7D5),
                Color(0xFFFFC5AA),
                Color(0xFFD4C5F9),
              ],
            ),
          ),
          child: Center(
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white, Color(0x00FFFFFF)],
                ),
              ),
            ).animate().fadeIn(duration: 600.ms),
          ),
        ),
      ),
    );
  }
}

// ── F9 信封內容-家屬 (1:58) ──
class FamilyLetterContentScreen extends StatelessWidget {
  const FamilyLetterContentScreen({super.key});

  static const _text = '''親愛的家人,

謝謝你一直陪在我身邊。
有時候我會忘記,有時候我會慌張,
但你始終都在。

我想讓你知道,我很感激你。

— 你的家人
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFAF5),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.go('/family'),
        ),
        title: const Text('來自家人的信',
            style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 16, 28, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.peachLight.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.mail_rounded,
                    size: 36, color: Color(0xFFC97B4B)),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              _text,
              style: AppTextStyles.body(context)
                  .copyWith(height: 2.0, fontSize: 15),
            ).animate().fadeIn(duration: 800.ms),
            const SizedBox(height: 32),
            Center(
              child: GestureDetector(
                onTap: () => context.go('/family/video/list'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.peach,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    '看家人留下的影片',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
