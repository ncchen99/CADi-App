import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  final _textController = TextEditingController();
  int _page = 0;

  void _goNext() {
    if (_page < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
      );
    } else {
      context.go('/client');
    }
  }

  void _goBack() {
    if (_page == 0) {
      context.go('/mode-select');
    } else {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 340),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) => setState(() => _page = page),
        children: [
          _QuestionStep(onTap: _goNext),
          _UploadStep(onTap: _goNext),
          _ExplainStep(controller: _textController, onSend: _goNext),
          _EmotionTagsStep(onBack: _goBack, onDone: _goNext),
        ],
      ),
    );
  }
}

class _QuestionStep extends StatelessWidget {
  final VoidCallback onTap;

  const _QuestionStep({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ClientGradientBackground(
        child: Center(
          child: Text(
            '想一下，\n什麼東西能夠代表你現在的狀態',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1(
              context,
            ).copyWith(fontSize: 16, height: 1.7, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

class _UploadStep extends StatelessWidget {
  final VoidCallback onTap;

  const _UploadStep({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClientGradientBackground(
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  '上傳符合這個想像的圖片',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading1(
                    context,
                  ).copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 118,
              child: Center(
                child: CadiPrimaryPill(label: '上傳', onTap: onTap),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExplainStep extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _ExplainStep({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return ClientGradientBackground(
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 38),
                child: Text(
                  '為這個圖片增加一些解釋',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading1(
                    context,
                  ).copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Positioned(
              left: 30,
              right: 30,
              bottom: 78,
              child: CadiInputPill(
                controller: controller,
                onSend: onSend,
                hintText: '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmotionTagsStep extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onDone;

  const _EmotionTagsStep({required this.onBack, required this.onDone});

  static const _tags = [
    _TagData('向上爬升', [
      Color(0xFF323739),
      Color(0xFFA7A396),
    ], Icons.stairs_rounded),
    _TagData('想靜一靜', [
      Color(0xFF7891A0),
      Color(0xFFD7C7AE),
    ], Icons.pets_rounded),
    _TagData('正向', [
      Color(0xFF33B7FF),
      Color(0xFFE8E8EA),
    ], Icons.favorite_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 12,
              left: 8,
              child: ClientBackButton(onTap: onBack),
            ),
            Positioned(
              top: 72,
              right: 52,
              child: Text(
                '總數：3',
                style: AppTextStyles.caption(
                  context,
                ).copyWith(color: AppColors.primaryText, fontSize: 12),
              ),
            ),
            Positioned(
              top: 148,
              left: 36,
              right: 36,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _tags
                    .map((tag) => _ImageTag(tag: tag, onTap: onDone))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageTag extends StatelessWidget {
  final _TagData tag;
  final VoidCallback onTap;

  const _ImageTag({required this.tag, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 92,
        height: 106,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: tag.colors,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x18000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                tag.icon,
                color: Colors.white.withValues(alpha: 0.9),
                size: 38,
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 40,
              child: Text(
                tag.label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  shadows: [Shadow(color: Color(0x55000000), blurRadius: 8)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagData {
  final String label;
  final List<Color> colors;
  final IconData icon;

  const _TagData(this.label, this.colors, this.icon);
}
