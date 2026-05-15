// C4 — 狀態圖庫 (Figma node 1:11)
// 馬賽克拼圖完成後進入此收藏庫,圖片上方顯示自己打的狀態
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/storage/app_storage.dart';
import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class StatusGalleryScreen extends StatelessWidget {
  const StatusGalleryScreen({super.key});

  static const _items = [
    _GalleryItem('向上爬升', Color(0xFF6E6256), Color(0xFFBDB3A2)),
    _GalleryItem('想靜一靜', Color(0xFF7891A0), Color(0xFFD7C7AE)),
    _GalleryItem('正向', Color(0xFF33B7FF), Color(0xFFE8E8EA)),
    _GalleryItem('溫柔', Color(0xFFD6A7CB), Color(0xFFFCE9F1)),
  ];

  @override
  Widget build(BuildContext context) {
    final userImage = AppStorage.onboardingImage;
    final userTag = AppStorage.onboardingTag;
    final userText = AppStorage.onboardingText;
    return Scaffold(
      body: ClientGradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(
                  onTap: () => context.go('/client/onboarding'),
                ),
              ),
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '狀態圖庫',
                    style: AppTextStyles.heading1(context),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 80, 24, 120),
                child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: _items.length + (userImage != null ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (userImage != null && index == 0) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.memory(userImage, fit: BoxFit.cover),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Color(0x99000000),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 12,
                              right: 12,
                              bottom: 14,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    userTag ?? '我的狀態',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      shadows: [
                                        Shadow(
                                          color: Color(0x66000000),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (userText.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      userText,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    final item = _items[userImage != null ? index - 1 : index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [item.a, item.b],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 12,
                            right: 12,
                            bottom: 14,
                            child: Text(
                              item.label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                shadows: [
                                  Shadow(
                                    color: Color(0x66000000),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 36,
                child: Center(
                  child: CadiPrimaryPill(
                    label: '進入主畫面',
                    onTap: () => context.go('/client/splash'),
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

class _GalleryItem {
  final String label;
  final Color a;
  final Color b;
  const _GalleryItem(this.label, this.a, this.b);
}
