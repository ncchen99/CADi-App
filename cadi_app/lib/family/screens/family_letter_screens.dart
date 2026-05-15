// F5-F9 家屬安慰/信封序列
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/family_chrome.dart';

class FamilyLetterNotifyScreen extends StatelessWidget {
  const FamilyLetterNotifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FamilySoftBackground(
        warm: true,
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.push('/family/letter/envelope'),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 34),
              child: Column(
                children: [
                  FamilyTopBar(onBack: () => context.go('/family')),
                  const Spacer(),
                  FamilyPanel(
                    padding: const EdgeInsets.fromLTRB(28, 34, 28, 32),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.favorite_rounded,
                          color: Color(0xFF6EA6C9),
                          size: 38,
                        ),
                        const SizedBox(height: 18),
                        Text('患者想念你', style: AppTextStyles.heading1(context)),
                        const SizedBox(height: 8),
                        Text(
                          '患者今天的心情有些低落，留了一段話想給你。',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body(
                            context,
                          ).copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 420.ms).slideY(begin: -0.08),
                  const Spacer(),
                  Text('輕點任意處繼續', style: AppTextStyles.caption(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FamilyEnvelopeScreen extends StatelessWidget {
  const FamilyEnvelopeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FamilySoftBackground(
        warm: true,
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.push('/family/letter/glow'),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 190,
                    height: 132,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x18000000),
                          blurRadius: 22,
                          offset: Offset(0, 9),
                        ),
                      ],
                    ),
                    child: CustomPaint(painter: _EnvelopePainter()),
                  ).animate().fadeIn().scale(
                    begin: const Offset(0.82, 0.82),
                    curve: Curves.easeOutBack,
                    duration: 650.ms,
                  ),
                  const SizedBox(height: 34),
                  Text(
                    '有一封信給你',
                    style: AppTextStyles.heading1(context),
                  ).animate().fadeIn(delay: 360.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FamilyLetterGlowScreen extends StatelessWidget {
  const FamilyLetterGlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.push('/family/letter/gradient'),
        child: Center(
          child:
              Container(
                    width: 220,
                    height: 220,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFFFC5AA),
                          Color(0x00FFC5AA),
                        ],
                        stops: [0, 0.46, 1],
                      ),
                    ),
                  )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1.08, 1.08),
                    duration: 1500.ms,
                  ),
        ),
      ),
    );
  }
}

class FamilyLetterGradientScreen extends StatelessWidget {
  const FamilyLetterGradientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.push('/family/letter/content'),
        child: const FamilySoftBackground(
          warm: true,
          child: Center(
            child: SizedBox(
              width: 168,
              height: 168,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.white, Color(0x00FFFFFF)],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FamilyLetterContentScreen extends StatelessWidget {
  const FamilyLetterContentScreen({super.key});

  static const _text = '''親愛的家屬，

謝謝你一直陪在我身邊。
有時候我會忘記，有時候我會慌張，
但你始終都在。

我想讓你知道，我很感激你。

— 你的患者
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FamilySoftBackground(
        warm: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            child: Column(
              children: [
                FamilyTopBar(onBack: () => context.go('/family')),
                const SizedBox(height: 18),
                Expanded(
                  child: FamilyPanel(
                    padding: const EdgeInsets.fromLTRB(28, 34, 28, 30),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              '來自患者的信',
                              style: AppTextStyles.heading1(context),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            _text,
                            style: AppTextStyles.body(
                              context,
                            ).copyWith(height: 2.05, fontSize: 15),
                          ).animate().fadeIn(duration: 700.ms),
                          const SizedBox(height: 28),
                          Center(
                            child: TextButton.icon(
                              onPressed: () => context.go('/family/video/list'),
                              icon: const Icon(
                                Icons.play_circle_outline_rounded,
                              ),
                              label: const Text('看患者留下的影片'),
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF6EA6C9),
                              ),
                            ),
                          ),
                        ],
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

class _EnvelopePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final border = Paint()
      ..color = const Color(0xFF6EA6C9).withValues(alpha: 0.34)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    final flap = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height * 0.56)
      ..lineTo(size.width, 0);
    final lower = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.42, size.height * 0.46)
      ..moveTo(size.width, size.height)
      ..lineTo(size.width * 0.58, size.height * 0.46);
    canvas.drawPath(flap, border);
    canvas.drawPath(lower, border);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
