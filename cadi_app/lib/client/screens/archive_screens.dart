// A1–A6 影片典藏系列 (Figma 1:24, 1:5, 1:16, 1:25, 1:2, 1:23)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

// ── A1 影片日期典藏分類 (1:24) — IG 典藏風日曆 ──
class ArchiveDateScreen extends StatelessWidget {
  const ArchiveDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientGradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(onTap: () => context.go('/client')),
              ),
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: _ArchiveTabs(
                    current: 0,
                    onSelect: (i) {
                      if (i == 1) context.go('/client/archive/content');
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 30),
                child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  itemCount: 21,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () =>
                          context.push('/client/archive/date-detail'),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.peachLight
                                  .withValues(alpha: 0.5)),
                        ),
                        child: Center(
                          child: Text(
                            '${(i % 30) + 1}',
                            style: AppTextStyles.body(context),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── A2 利用影片內容分類 (1:5) — 依心情分類 ──
class ArchiveContentScreen extends StatelessWidget {
  const ArchiveContentScreen({super.key});

  static const _moods = [
    _Mood('開心', Color(0xFFFFD9A3)),
    _Mood('平靜', Color(0xFFC8DFFF)),
    _Mood('懷念', Color(0xFFE8C8FF)),
    _Mood('感激', Color(0xFFFFC8C8)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientGradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(onTap: () => context.go('/client')),
              ),
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: _ArchiveTabs(
                    current: 1,
                    onSelect: (i) {
                      if (i == 0) context.go('/client/archive/date');
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 90, 24, 30),
                child: ListView.separated(
                  itemCount: _moods.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, i) {
                    final m = _moods[i];
                    return GestureDetector(
                      onTap: () => context.push('/client/archive/emotion'),
                      child: Container(
                        height: 86,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: m.color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.visibility_outlined,
                                color: Colors.white, size: 32),
                            const SizedBox(width: 16),
                            Text(m.label,
                                style: AppTextStyles.heading1(context)
                                    .copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Mood {
  final String label;
  final Color color;
  const _Mood(this.label, this.color);
}

// ── A3 根據影片得情緒分類 (1:16) — 心情眼睛符號疊在影片上 ──
class ArchiveEmotionScreen extends StatelessWidget {
  const ArchiveEmotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientGradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(onTap: () => context.pop()),
              ),
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Text('情緒分類',
                      style: AppTextStyles.heading1(context)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 30),
                child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () =>
                        context.push('/client/archive/content-detail'),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.lerp(AppColors.peach, Colors.white,
                                      (i % 3) / 3)!,
                                  AppColors.peachLight,
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            top: 10,
                            right: 10,
                            child: Icon(Icons.remove_red_eye_outlined,
                                color: Colors.white, size: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 24,
                child: Center(
                  child: GestureDetector(
                    onTap: () =>
                        context.push('/client/archive/emotion-list'),
                    child: Text(
                      '查看情緒清單形式',
                      style: AppTextStyles.body(context).copyWith(
                          decoration: TextDecoration.underline,
                          color: AppColors.peach),
                    ),
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

// ── A4 影片情緒分類形式 (1:25) — 給「學長」眼睛符號 ──
class ArchiveEmotionListScreen extends StatelessWidget {
  const ArchiveEmotionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientGradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(onTap: () => context.pop()),
              ),
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Text('情緒分類列表',
                      style: AppTextStyles.heading1(context)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 80, 24, 30),
                child: ListView.separated(
                  itemCount: 5,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) => Container(
                    height: 76,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.remove_red_eye_outlined,
                            size: 26, color: AppColors.peach),
                        const SizedBox(width: 16),
                        Text('影片 ${i + 1}',
                            style: AppTextStyles.body(context)),
                        const Spacer(),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.secondaryText),
                      ],
                    ),
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

// ── A5 日期典藏點進去 (1:2) — 影片下顯示日期 ──
class ArchiveDateDetailScreen extends StatelessWidget {
  const ArchiveDateDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF2A2A2A), Color(0xFF000000)],
                  ),
                ),
              ),
            ),
            const Center(
              child: Icon(Icons.play_arrow_rounded,
                  size: 96, color: Colors.white70),
            ),
            Positioned(
              top: 12,
              left: 8,
              child: ClientBackButton(
                onTap: () => context.pop(),
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '2025 / 05 / 14',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        letterSpacing: 1.5),
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

// ── A6 影片內容點進去 (1:23) — 圓弧滑動切換 ──
class ArchiveContentDetailScreen extends StatefulWidget {
  const ArchiveContentDetailScreen({super.key});

  @override
  State<ArchiveContentDetailScreen> createState() =>
      _ArchiveContentDetailScreenState();
}

class _ArchiveContentDetailScreenState
    extends State<ArchiveContentDetailScreen> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: 4,
              itemBuilder: (context, i) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final page = _controller.hasClients &&
                            _controller.position.haveDimensions
                        ? (_controller.page ?? 0)
                        : 0.0;
                    final delta = (page - i).abs();
                    final scale = (1 - delta * 0.2).clamp(0.7, 1.0);
                    return Center(
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 280,
                          height: 380,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            gradient: LinearGradient(
                              colors: [
                                Color.lerp(
                                    AppColors.peach, Colors.white, i / 4)!,
                                AppColors.peachLight,
                              ],
                            ),
                          ),
                          child: const Icon(Icons.play_circle_fill_rounded,
                              size: 72, color: Colors.white70),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Positioned(
              top: 12,
              left: 8,
              child: ClientBackButton(
                onTap: () => context.pop(),
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Center(
                child: Text(
                  '左右滑動切換',
                  style: AppTextStyles.caption(context)
                      .copyWith(color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 共用 tab
class _ArchiveTabs extends StatelessWidget {
  final int current;
  final ValueChanged<int> onSelect;
  const _ArchiveTabs({required this.current, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    const labels = ['日期', '內容'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(labels.length, (i) {
          final selected = current == i;
          return GestureDetector(
            onTap: () => onSelect(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.peach : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                labels[i],
                style: AppTextStyles.body(context).copyWith(
                  color: selected ? Colors.white : AppColors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
