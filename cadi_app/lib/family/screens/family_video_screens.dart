// F10-F12 患者影片回放
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/family_chrome.dart';

class FamilyVideoListScreen extends StatelessWidget {
  const FamilyVideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FamilySoftBackground(
        warm: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FamilyTopBar(onBack: () => context.go('/family')),
                const SizedBox(height: 14),
                Text('患者的影片', style: AppTextStyles.heading1(context)),
                const SizedBox(height: 18),
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final horizontal = index.isEven;
                      return GestureDetector(
                        onTap: () => context.push(
                          horizontal
                              ? '/family/video/horizontal'
                              : '/family/video/vertical',
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              FamilyVideoStill(horizontal: horizontal),
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: _DateStamp(
                                  text:
                                      '2026.05.${(index + 9).toString().padLeft(2, '0')}',
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
      ),
    );
  }
}

class FamilyVerticalVideoScreen extends StatelessWidget {
  const FamilyVerticalVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: FamilyVideoStill(dark: true)),
            Positioned(
              top: 8,
              left: 8,
              child: IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 38,
              child: Center(child: _DateStamp(text: '2026.05.15')),
            ),
          ],
        ),
      ),
    );
  }
}

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(
            child: FamilyVideoStill(horizontal: true, dark: true),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.close_rounded, color: Colors.white),
              onPressed: () => context.pop(),
            ),
          ),
          const Positioned(
            right: 16,
            bottom: 16,
            child: _DateStamp(text: '2026.05.15'),
          ),
        ],
      ),
    );
  }
}

class _DateStamp extends StatelessWidget {
  final String text;

  const _DateStamp({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.48),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}
