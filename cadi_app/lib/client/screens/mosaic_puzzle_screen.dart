// C7 — 馬賽克拼圖頁面 (Figma node 1:17)
// 前面上傳的圖片會在這裡,根據錄的影片多寡,會逐漸從很模糊變清楚 (1:52)
// 完成的圖片點擊可進到 C4 狀態圖庫 (1:55)
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class MosaicPuzzleScreen extends StatelessWidget {
  const MosaicPuzzleScreen({super.key});

  // progress 0..1 — 影片數量越多越清晰
  static const _tiles = <_TileData>[
    _TileData('向上爬升', Color(0xFF6E6256), Color(0xFFBDB3A2), 0.95),
    _TileData('想靜一靜', Color(0xFF7891A0), Color(0xFFD7C7AE), 0.7),
    _TileData('正向', Color(0xFF33B7FF), Color(0xFFE8E8EA), 0.45),
    _TileData('溫柔', Color(0xFFD6A7CB), Color(0xFFFCE9F1), 0.2),
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
                top: 18,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '馬賽克拼圖',
                    style: AppTextStyles.heading1(context),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 76, 24, 32),
                child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: _tiles.length,
                  itemBuilder: (context, i) {
                    final t = _tiles[i];
                    final blurSigma = (1 - t.progress) * 18;
                    return GestureDetector(
                      onTap: () {
                        if (t.progress >= 0.9) {
                          context.go('/client/onboarding/gallery');
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: blurSigma,
                                sigmaY: blurSigma,
                              ),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [t.a, t.b],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 12,
                              bottom: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${(t.progress * 100).round()}%',
                                  style: AppTextStyles.caption(context),
                                ),
                              ),
                            ),
                            if (t.progress >= 0.9)
                              Positioned(
                                left: 12,
                                top: 12,
                                child: Text(
                                  t.label,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                    shadows: [
                                      Shadow(
                                          color: Color(0x88000000),
                                          blurRadius: 8),
                                    ],
                                  ),
                                ),
                              ),
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

class _TileData {
  final String label;
  final Color a;
  final Color b;
  final double progress;
  const _TileData(this.label, this.a, this.b, this.progress);
}
