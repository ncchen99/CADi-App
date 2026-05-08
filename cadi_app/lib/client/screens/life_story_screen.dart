import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class LifeStoryScreen extends StatelessWidget {
  final bool showBackButton;

  const LifeStoryScreen({super.key, this.showBackButton = true});

  static const _topics = [
    _Topic('童年', [Color(0xFF3A3834), Color(0xFFD7C7B2), Color(0xFF8E3B50)]),
    _Topic('工作經歷', [Color(0xFF0D2A65), Color(0xFF76A7DF), Color(0xFFDFE8F8)]),
    _Topic('給自己的話', [Color(0xFF391E28), Color(0xFFFFD569), Color(0xFF722E25)]),
    _Topic('給家人的話', [Color(0xFFE7D27A), Color(0xFFB8D0C7), Color(0xFF29516B)]),
    _Topic('影響最多的事', [Color(0xFF173E3E), Color(0xFFC2A05D), Color(0xFF8DBBC0)]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            if (showBackButton)
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(onTap: () => context.go('/client')),
              ),
            ListView.separated(
              padding: EdgeInsets.fromLTRB(
                20,
                showBackButton ? 86 : 82,
                22,
                128,
              ),
              itemCount: _topics.length,
              separatorBuilder: (_, __) => const SizedBox(height: 60),
              itemBuilder: (context, index) {
                return _TopicRow(topic: _topics[index], index: index);
              },
            ),
          ],
        ),
      ),
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
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${topic.title} 開發中')));
      },
      child: Row(
        children: [
          _MemoryCollage(colors: topic.colors, index: index),
          const Spacer(),
          SizedBox(
            width: 104,
            child: Text(
              topic.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.body(
                context,
              ).copyWith(color: Colors.black, fontSize: 14, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemoryCollage extends StatelessWidget {
  final List<Color> colors;
  final int index;

  const _MemoryCollage({required this.colors, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164,
      height: 104,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: 9,
        itemBuilder: (context, tile) {
          final color = colors[tile % colors.length];
          return DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(color, Colors.white, (tile % 3) * 0.12)!,
                  Color.lerp(color, Colors.black, 0.18 + (index % 2) * 0.1)!,
                ],
              ),
            ),
            child: CustomPaint(
              painter: _PhotoTexturePainter(seed: tile + index * 7),
            ),
          );
        },
      ),
    );
  }
}

class _PhotoTexturePainter extends CustomPainter {
  final int seed;

  _PhotoTexturePainter({required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.16)
      ..strokeWidth = 2;
    final y = (seed % 5 + 1) * size.height / 7;
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y + (seed.isEven ? 12 : -12)),
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * ((seed % 4 + 1) / 5), size.height * 0.5),
      8 + (seed % 3) * 3,
      paint..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant _PhotoTexturePainter oldDelegate) =>
      oldDelegate.seed != seed;
}

class _Topic {
  final String title;
  final List<Color> colors;

  const _Topic(this.title, this.colors);
}
