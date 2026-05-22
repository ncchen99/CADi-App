import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/storage/app_storage.dart';
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
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    _textController.text = AppStorage.onboardingText;
    _image = AppStorage.onboardingImage;
  }

  void _goNext() {
    if (_page < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
      );
    } else {
      AppStorage.setOnboardingDone(true);
      context.go('/client/onboarding/gallery');
    }
  }

  void _goBack() {
    if (_page == 0) {
      context.go('/client/onboarding/intro');
    } else if (_page == 3) {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 340),
        curve: Curves.easeOutCubic,
      );
    } else {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 340),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    await AppStorage.setOnboardingImage(bytes);
    if (!mounted) return;
    setState(() => _image = bytes);
    // Bypasses explain step and goes directly to the "總數 3" emotion/card grid list page
    _pageController.animateToPage(
      3,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _submitText() async {
    await AppStorage.setOnboardingText(_textController.text.trim());
    _goNext();
  }

  Future<void> _pickTag(String tag) async {
    await AppStorage.setOnboardingTag(tag);
    await AppStorage.setOnboardingDone(true);
    if (!mounted) return;
    context.push('/client/onboarding/preview');
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
          _UploadStep(onTap: _pickImage, preview: _image),
          _ExplainStep(controller: _textController, onSend: _submitText),
          _EmotionTagsStep(onBack: _goBack, onPick: _pickTag),
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
            '想一下\n什麼東西最能代表你現在的狀態',
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
  final Uint8List? preview;

  const _UploadStep({required this.onTap, this.preview});

  @override
  Widget build(BuildContext context) {
    return ClientGradientBackground(
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '上傳符合這個想像的圖片',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading1(
                        context,
                      ).copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    if (preview != null) ...[
                      const SizedBox(height: 28),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.memory(
                          preview!,
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 118,
              child: Center(
                child: CadiPrimaryPill(
                  label: preview == null ? '上傳' : '重新上傳',
                  onTap: onTap,
                ),
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
  final ValueChanged<String> onPick;

  const _EmotionTagsStep({required this.onBack, required this.onPick});

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
                    .map((tag) => _ImageTag(
                          tag: tag,
                          onTap: () => onPick(tag.label),
                        ))
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
