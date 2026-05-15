// F10–F12 被照顧者影片回放
// F10 1:66 影片清單, F11 1:57 直式, F12 1:68 橫式
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';

// ── F10 被照顧者的影片 (1:66) ──
class FamilyVideoListScreen extends StatelessWidget {
  const FamilyVideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFAF5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.go('/family'),
        ),
        title: const Text('家人的影片',
            style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemCount: 6,
        itemBuilder: (context, i) {
          final horizontal = i.isEven;
          return GestureDetector(
            onTap: () => context.push(horizontal
                ? '/family/video/horizontal'
                : '/family/video/vertical'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.lerp(AppColors.peach, Colors.white,
                              (i % 3) / 3)!,
                          AppColors.peachLight,
                        ],
                      ),
                    ),
                  ),
                  const Center(
                    child: Icon(Icons.play_circle_fill_rounded,
                        color: Colors.white70, size: 48),
                  ),
                  // 相機風日期 (1:83)
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '2025.05.${(i + 1).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            letterSpacing: 1.2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── F11 直式影片-家屬 (1:57) ──
class FamilyVerticalVideoScreen extends StatelessWidget {
  const FamilyVerticalVideoScreen({super.key});

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
                    colors: [Color(0xFF1F1F1F), Color(0xFF000000)],
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
              child: IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '2025.05.14',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
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

// ── F12 橫式影片-家屬 (1:68) ──
class FamilyHorizontalVideoScreen extends StatefulWidget {
  const FamilyHorizontalVideoScreen({super.key});

  @override
  State<FamilyHorizontalVideoScreen> createState() =>
      _FamilyHorizontalVideoScreenState();
}

class _FamilyHorizontalVideoScreenState
    extends State<FamilyHorizontalVideoScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1F1F1F), Color(0xFF000000)],
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
            child: IconButton(
              icon: const Icon(Icons.close_rounded, color: Colors.white),
              onPressed: () => context.pop(),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                '2025.05.14',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    letterSpacing: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
