// C10 — 科普影片直式 (Figma node 1:12)
// 聊天室會根據聊天內容傳送科普影片給使用者,左下角有小機器人 (1:39)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class EduVideoScreen extends StatelessWidget {
  const EduVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Placeholder video surface — 實際影片以 video_player 串接
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF1F2A36),
                      const Color(0xFF2A1F2F),
                    ],
                  ),
                ),
              ),
            ),
            const Center(
              child: Icon(Icons.play_circle_fill_rounded,
                  size: 88, color: Colors.white70),
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
              top: 20,
              right: 24,
              child: Text(
                '科普影片',
                style: AppTextStyles.heading2(context)
                    .copyWith(color: Colors.white),
              ),
            ),
            // 左下角小機器人陪著看
            const Positioned(
              left: 20,
              bottom: 30,
              child: CadiSoftBot(size: 78, blurred: false),
            ),
            Positioned(
              right: 24,
              bottom: 40,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Text(
                  '了解失智症日常照護',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
