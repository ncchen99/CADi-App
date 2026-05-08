import 'package:flutter/material.dart';

import '../../client/widgets/client_chrome.dart';

enum AppMode { client, family }

class CadiBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final AppMode mode;

  const CadiBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.mode = AppMode.client,
  });

  @override
  Widget build(BuildContext context) {
    final icons = mode == AppMode.client ? _clientIcons : _familyIcons;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Center(
          heightFactor: 1,
          child: CadiFloatingNav(
            currentIndex: currentIndex,
            icons: icons,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}

const _clientIcons = [
  Icons.calendar_today_outlined,
  Icons.folder_open_rounded,
  Icons.sentiment_satisfied_alt_rounded,
];

const _familyIcons = [
  Icons.home_rounded,
  Icons.photo_library_outlined,
  Icons.chat_bubble_outline_rounded,
];
