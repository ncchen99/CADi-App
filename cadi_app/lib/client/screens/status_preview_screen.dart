import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/storage/app_storage.dart';
import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class StatusPreviewScreen extends StatelessWidget {
  const StatusPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userImage = AppStorage.onboardingImage;
    const dateStr = '21 March, 2026';

    return Scaffold(
      body: ClientGradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(
                  onTap: () => context.pop(),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dateStr,
                        style: GoogleFonts.lexend(
                          color: const Color(0xFF9E958E),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 28),
                      GestureDetector(
                        onTap: () {
                          // Click on the large image goes to the "今天感覺怎麼樣" screen
                          context.go('/client/mood');
                        },
                        child: Container(
                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x2B000000),
                                blurRadius: 24,
                                offset: Offset(0, 12),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: userImage != null
                                ? Image.memory(userImage, fit: BoxFit.cover)
                                : Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFFFD5C2),
                                          Color(0xFFFFB292),
                                        ],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.image_rounded,
                                        color: Colors.white70,
                                        size: 72,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        '輕點圖片進入今天的心情日記',
                        style: AppTextStyles.caption(context).copyWith(
                          fontSize: 13,
                          color: const Color(0xFF9E958E),
                        ),
                      ),
                    ],
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
