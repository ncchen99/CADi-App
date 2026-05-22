import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class LifeStoryScreen extends StatefulWidget {
  final bool showBackButton;

  const LifeStoryScreen({super.key, this.showBackButton = true});

  @override
  State<LifeStoryScreen> createState() => _LifeStoryScreenState();
}

class _LifeStoryScreenState extends State<LifeStoryScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView(
                controller: _pageController,
                children: [
                  _CalendarArchiveTab(
                    onDetailPressed: () {
                      context.push('/client/archive/date-detail');
                    },
                  ),
                  const _MainLifeStoryTab(),
                  _MoodArchiveTab(
                    onMoodTap: (moodName) {
                      context.push(
                        '/client/archive/mood-detail?mood=$moodName',
                      );
                    },
                  ),
                ],
              ),
            ),
            if (widget.showBackButton)
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(
                  onTap: () => context.go('/client/mood'),
                ),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Center(
                child: _BulgingFloatingNav(
                  pageController: _pageController,
                  onTap: _onTabTapped,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 1. LEFT TAB: CALENDAR ARCHIVE ──
class _CalendarArchiveTab extends StatelessWidget {
  final VoidCallback onDetailPressed;

  const _CalendarArchiveTab({required this.onDetailPressed});

  static final List<_MonthData> _months = [
    _MonthData('06/2025', 30, 0, const {}),
    _MonthData('07/2025', 31, 2, {
      9: [Color(0xFF374E55), Color(0xFFD3C3A8)],
      13: [Color(0xFF153F3E), Color(0xFFBFC9A5)],
    }),
    _MonthData('08/2025', 30, 5, {
      9: [Color(0xFF5A2E22), Color(0xFFF4A478)],
      13: [Color(0xFF46311F), Color(0xFFD7B68D)],
    }),
    _MonthData('09/2025', 31, 1, {
      9: [Color(0xFF8BA3B0), Color(0xFFE2C653)],
      13: [Color(0xFF1B4657), Color(0xFFB76C4B)],
    }),
    _MonthData('10/2025', 31, 3, {
      9: [Color(0xFF784033), Color(0xFFDFA58E)],
      13: [Color(0xFF2E1F20), Color(0xFFD1B17B)],
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(46, 28, 46, 126),
      child: Column(
        children: [
          for (final month in _months) ...[
            _CalendarMonthCard(month: month, onDetailPressed: onDetailPressed),
            const SizedBox(height: 40),
          ],
        ],
      ),
    );
  }
}

class _MonthData {
  final String title;
  final int dayCount;
  final int startOffset;
  final Map<int, List<Color>> memories;

  _MonthData(this.title, this.dayCount, this.startOffset, this.memories);
}

class _CalendarMonthCard extends StatelessWidget {
  final _MonthData month;
  final VoidCallback onDetailPressed;

  const _CalendarMonthCard({
    required this.month,
    required this.onDetailPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(42),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            month.title,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3E3E3E),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8C8C8C),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 8,
            ),
            itemCount: month.startOffset + month.dayCount,
            itemBuilder: (context, index) {
              if (index < month.startOffset) return const SizedBox.shrink();
              final day = index - month.startOffset + 1;
              final memoryColors = month.memories[day];

              return GestureDetector(
                onTap: memoryColors == null ? null : onDetailPressed,
                child: Center(
                  child: memoryColors == null
                      ? Text(
                          '$day',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            color: const Color(0xFF3F3F3F),
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : _MemoryDateBadge(day: day, colors: memoryColors),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MemoryDateBadge extends StatelessWidget {
  final int day;
  final List<Color> colors;

  const _MemoryDateBadge({required this.day, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$day',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ── 2. MIDDLE TAB: MAIN LIFE STORY CATEGORIES ──
class _MainLifeStoryTab extends StatelessWidget {
  const _MainLifeStoryTab();

  static const _topics = [
    _Topic('童年', [Color(0xFF3A3834), Color(0xFFD7C7B2), Color(0xFF8E3B50)]),
    _Topic('工作經歷', [Color(0xFF0D2A65), Color(0xFF76A7DF), Color(0xFFDFE8F8)]),
    _Topic('給自己的話', [Color(0xFF391E28), Color(0xFFFFD569), Color(0xFF722E25)]),
    _Topic('給家人的話', [Color(0xFFE7D27A), Color(0xFFB8D0C7), Color(0xFF29516B)]),
    _Topic('影響最多的事', [Color(0xFF173E3E), Color(0xFFC2A05D), Color(0xFF8DBBC0)]),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(36, 88, 30, 126),
      itemCount: _topics.length,
      separatorBuilder: (_, __) => const SizedBox(height: 70),
      itemBuilder: (context, index) {
        return _TopicRow(topic: _topics[index], index: index);
      },
    );
  }
}

class _TopicRow extends StatelessWidget {
  final _Topic topic;
  final int index;

  const _TopicRow({required this.topic, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/client/archive/content-detail'),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageWidth = (constraints.maxWidth * 0.58).clamp(176.0, 230.0);
          return Row(
            children: [
              _MemoryCollage(
                colors: topic.colors,
                index: index,
                width: imageWidth,
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Text(
                  topic.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: GoogleFonts.notoSansTc().fontFamily,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF262626),
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MemoryCollage extends StatelessWidget {
  final List<Color> colors;
  final int index;
  final double width;

  const _MemoryCollage({
    required this.colors,
    required this.index,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width * 0.58,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.55,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            itemCount: 9,
            itemBuilder: (context, tile) {
              return Image.asset(
                _lifeStoryPhoto(index * 9 + tile),
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }
}

String _lifeStoryPhoto(int index) {
  return 'assets/images/life_story/photo_${index % 35}.jpg';
}

class _Topic {
  final String title;
  final List<Color> colors;

  const _Topic(this.title, this.colors);
}

// ── 3. RIGHT TAB: MOOD ARCHIVE ──
class _MoodArchiveTab extends StatelessWidget {
  final ValueChanged<String> onMoodTap;

  const _MoodArchiveTab({required this.onMoodTap});

  static const _moods = [
    _Mood('溫暖', [Color(0xFFF6C16B), Color(0xFF7A5435)]),
    _Mood('低落', [Color(0xFF252525), Color(0xFFBCA895)]),
    _Mood('平靜', [Color(0xFFD8CF8C), Color(0xFF54713A)]),
    _Mood('孤單', [Color(0xFF9FC5D9), Color(0xFF335264)]),
    _Mood('焦躁', [Color(0xFFE48A4C), Color(0xFF8B4A35)]),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(28, 88, 28, 126),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _MoodMemoryCard(
                  mood: _moods[0],
                  height: 238,
                  seed: 0,
                  onTap: () => onMoodTap(_moods[0].label),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _MoodMemoryCard(
                  mood: _moods[1],
                  height: 238,
                  seed: 6,
                  onTap: () => onMoodTap(_moods[1].label),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _MoodMemoryCard(
            mood: _moods[2],
            height: 316,
            seed: 12,
            wide: true,
            onTap: () => onMoodTap(_moods[2].label),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _MoodMemoryCard(
                  mood: _moods[3],
                  height: 238,
                  seed: 18,
                  onTap: () => onMoodTap(_moods[3].label),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _MoodMemoryCard(
                  mood: _moods[4],
                  height: 238,
                  seed: 24,
                  onTap: () => onMoodTap(_moods[4].label),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Mood {
  final String label;
  final List<Color> colors;

  const _Mood(this.label, this.colors);
}

class _MoodMemoryCard extends StatelessWidget {
  final _Mood mood;
  final double height;
  final int seed;
  final bool wide;
  final VoidCallback onTap;

  const _MoodMemoryCard({
    required this.mood,
    required this.height,
    required this.seed,
    required this.onTap,
    this.wide = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: List.generate(wide ? 5 : 4, (index) {
                  return Expanded(
                    child: Image.asset(
                      _lifeStoryPhoto(seed + index),
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              ),
              Center(
                child: _EmotionOrb(colors: mood.colors, size: wide ? 104 : 86),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmotionOrb extends StatelessWidget {
  final List<Color> colors;
  final double size;

  const _EmotionOrb({required this.colors, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.25, -0.35),
          colors: [
            Colors.white.withValues(alpha: 0.82),
            colors.first.withValues(alpha: 0.72),
            colors.last.withValues(alpha: 0.86),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x44000000),
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: CustomPaint(painter: _OrbFacePainter()),
    );
  }
}

class _OrbFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width * 0.035
      ..strokeCap = StrokeCap.round;
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawLine(
      Offset(cx - size.width * 0.16, cy - size.height * 0.1),
      Offset(cx - size.width * 0.16, cy + size.height * 0.06),
      paint,
    );
    canvas.drawLine(
      Offset(cx + size.width * 0.16, cy - size.height * 0.1),
      Offset(cx + size.width * 0.16, cy + size.height * 0.06),
      paint,
    );
    canvas.drawLine(
      Offset(cx - size.width * 0.2, cy + size.height * 0.18),
      Offset(cx - size.width * 0.12, cy + size.height * 0.18),
      paint,
    );
    canvas.drawLine(
      Offset(cx + size.width * 0.12, cy + size.height * 0.18),
      Offset(cx + size.width * 0.2, cy + size.height * 0.18),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── 4. CUSTOM BULGING FLOATING NAVIGATION BAR ──
class _BulgingFloatingNav extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int> onTap;

  const _BulgingFloatingNav({
    required this.pageController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.calendar_month_rounded,
      Icons.folder_open_rounded,
      Icons.sentiment_satisfied_alt_rounded,
    ];

    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double page = pageController.hasClients
            ? (pageController.page ?? 1.0)
            : 1.0;
        final totalWidth = 200.0;
        final tabWidth = totalWidth / icons.length;

        // Animate the bulging active white indicator's x position matching the swipe
        final activeX = page * tabWidth;

        return Container(
          width: totalWidth + 24,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1.2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 18,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(6),
          child: Stack(
            children: [
              // Bulging active indicator background ("凹凸的白色")
              Positioned(
                left: activeX,
                top: 0,
                bottom: 0,
                child: Container(
                  width: tabWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1D000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),

              // Nav Buttons
              Positioned.fill(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(icons.length, (index) {
                    final selected = page.round() == index;
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onTap(index),
                      child: SizedBox(
                        width: tabWidth,
                        child: Icon(
                          icons[index],
                          color: selected
                              ? AppColors.peach
                              : AppColors.secondaryText,
                          size: selected ? 26 : 22,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
