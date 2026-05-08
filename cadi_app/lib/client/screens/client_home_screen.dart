import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/cadi_bottom_nav.dart';
import '../widgets/client_chrome.dart';
import 'life_story_screen.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _tabIndex = 0;

  void _handleNav(int index) {
    if (index == 2) {
      context.go('/client/chat');
      return;
    }
    setState(() => _tabIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _tabIndex,
        children: const [
          _HomeTab(),
          LifeStoryScreen(showBackButton: false),
          SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: CadiBottomNav(
        currentIndex: _tabIndex,
        mode: AppMode.client,
        onTap: _handleNav,
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.go('/client/mood'),
      child: ClientGradientBackground(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.sizeOf(context).height * 0.44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi',
                    style: TextStyle(
                      color: AppColors.primaryText.withValues(alpha: 0.92),
                      fontSize: 72,
                      fontWeight: FontWeight.w800,
                      height: 0.95,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: CadiTinyMark(size: 26),
                  ),
                ],
              ),
            ),
            Positioned(
              left: -4,
              right: -4,
              bottom: -92,
              child: Container(
                height: 210,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFFFFDCC0),
                      Color(0xFFFFA77F),
                      Color(0x00FFA77F),
                    ],
                    stops: [0.18, 0.58, 1],
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
