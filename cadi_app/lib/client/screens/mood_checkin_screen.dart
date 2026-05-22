import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/storage/app_storage.dart';
import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class MoodCheckinScreen extends StatefulWidget {
  const MoodCheckinScreen({super.key});

  @override
  State<MoodCheckinScreen> createState() => _MoodCheckinScreenState();
}

class _MoodCheckinScreenState extends State<MoodCheckinScreen> {
  int _selected = AppStorage.moodIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: () => context.go('/client/chat'),
        onVerticalDragEnd: (details) {
          final velocity = details.primaryVelocity;
          if (velocity != null && velocity > 300) {
            context.push('/client/life-story');
          }
        },
        child: ClientGradientBackground(
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 176,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CadiTinyMark(size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Hi',
                            style: TextStyle(
                              color: AppColors.primaryText.withValues(
                                alpha: 0.92,
                              ),
                              fontSize: 34,
                              height: 1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Text(
                        '今天感覺怎麼樣',
                        style: AppTextStyles.heading1(context).copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 336,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => context.go('/client/chat'),
                      child: const OrganicMoodOrb(size: 210),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 98,
                  child: Center(
                    child: CadiFloatingNav(
                      currentIndex: _selected,
                      icons: const [
                        Icons.chat_bubble_outline_rounded,
                        Icons.horizontal_rule_rounded,
                        Icons.location_on_outlined,
                      ],
                      onTap: (index) {
                        setState(() => _selected = index);
                        AppStorage.setMoodIndex(index);
                        if (index == 0) context.go('/client/chat');
                        if (index == 2) context.go('/client/compass');
                      },
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
