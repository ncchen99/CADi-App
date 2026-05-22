import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';
import '../widgets/cadi_robot_eyes.dart';

// ──最左邊的頁面：日期典藏詳細放大 (A5 變體) ──
class CalendarDetailScreen extends StatelessWidget {
  final String date;
  final String imageUrl; // optional

  const CalendarDetailScreen({
    super.key,
    this.date = '16 May, 2025',
    this.imageUrl = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientGradientBackground(
        peachOnly: true,
        child: SafeArea(
          child: Stack(
            children: [
              // 1. Back button
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(
                  onTap: () => context.pop(),
                  color: Colors.black87,
                ),
              ),

              // 2. Page Title
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '回憶細節',
                    style: AppTextStyles.heading1(context).copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // 3. Central Content
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Large Vertical Card
                      Container(
                        width: 280,
                        height: 420,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x33000000),
                              blurRadius: 18,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Abstract Sky/Clouds gradient & overlay texture
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF8EC5FC),
                                      Color(0xFFE0C3FC),
                                      Color(0xFFFDEBEE),
                                    ],
                                  ),
                                ),
                              ),
                              // Visual Cloud effects
                              CustomPaint(
                                painter: _AbstractSkyPainter(),
                              ),
                              // Glassmorphic top bar/inner shadow
                              Positioned(
                                top: 16,
                                right: 16,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.25),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.wb_sunny_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      // Date label
                      Text(
                        date,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText.withValues(alpha: 0.8),
                          letterSpacing: 1.2,
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

// ──最右邊的心情顯示頁面 (A3/A6 變體) ──
class MoodDetailScreen extends StatefulWidget {
  final String moodName;

  const MoodDetailScreen({super.key, this.moodName = '心情'});

  @override
  State<MoodDetailScreen> createState() => _MoodDetailScreenState();
}

class _MoodDetailScreenState extends State<MoodDetailScreen> {
  int _activeMediaIndex = 0;

  // Premium linear gradient combinations representing different moods
  static const List<List<Color>> _moodGradients = [
    [Color(0xFFFFC3A0), Color(0xFFFFAFBD)], // Warm Pink
    [Color(0xFFA1C4FD), Color(0xFFC2E9FB)], // Sky Calm Blue
    [Color(0xFFE2D9F3), Color(0xFFF9D5E5)], // Sweet Violet
    [Color(0xFFFBC2EB), Color(0xFFA6C1EE)], // Grateful Lavender
    [Color(0xFFE0C3FC), Color(0xFF8EC5FC)], // Dreamy Blue/Violet
  ];

  @override
  Widget build(BuildContext context) {
    final colors = _moodGradients[_activeMediaIndex % _moodGradients.length];

    return Scaffold(
      body: ClientGradientBackground(
        peachOnly: false,
        child: SafeArea(
          child: Stack(
            children: [
              // 1. Back button
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(
                  onTap: () => context.pop(),
                  color: Colors.black87,
                ),
              ),

              // 2. Animated Robot Eyes Symbol (i i) at top center
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CadiRobotEyes(size: 40),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.moodName}回憶',
                      style: AppTextStyles.body(context).copyWith(
                        fontSize: 12,
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Main content
              Padding(
                padding: const EdgeInsets.only(top: 86.0),
                child: Column(
                  children: [
                    const Spacer(),
                    // Large Center Card
                    Container(
                      width: 250,
                      height: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x2B000000),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: colors,
                                ),
                              ),
                            ),
                            // Simple abstract art details on active image
                            CustomPaint(
                              painter: _MoodArtPainter(seed: _activeMediaIndex),
                            ),
                            // Play icon Overlay (Glassmorphism look)
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.28),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.4),
                                    width: 1.5,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.play_arrow_rounded,
                                  size: 48,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),

                    // 4. Horizontal Thumbnail Carousel at bottom
                    SizedBox(
                      height: 72,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: _moodGradients.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final isActive = index == _activeMediaIndex;
                          final thumbColors = _moodGradients[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _activeMediaIndex = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 54,
                              height: 72,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isActive
                                      ? AppColors.peach
                                      : Colors.white.withValues(alpha: 0.6),
                                  width: isActive ? 2.5 : 1.5,
                                ),
                                boxShadow: isActive
                                    ? const [
                                        BoxShadow(
                                          color: Color(0x33FFA384),
                                          blurRadius: 8,
                                          offset: Offset(0, 4),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: thumbColors,
                                        ),
                                      ),
                                    ),
                                    if (isActive)
                                      Center(
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            size: 10,
                                            color: AppColors.peach,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Abstract Painters to support visual premium styling ──
class _AbstractSkyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.16)
      ..style = PaintingStyle.fill;

    // Draw some stylized clouds
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.4), 80, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.5), 100, paint);
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.6), 90, paint);

    // Some tiny stars/sparkles
    final starPaint = Paint()..color = Colors.white.withValues(alpha: 0.6);
    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.2), 3, starPaint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.28), 2, starPaint);
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.7), 4, starPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MoodArtPainter extends CustomPainter {
  final int seed;

  _MoodArtPainter({required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final baseHeight = size.height * 0.5;
    // Premium abstract wavy shapes
    final path = Path()
      ..moveTo(0, baseHeight)
      ..quadraticBezierTo(
        size.width * 0.25,
        baseHeight - 30 - (seed * 8 % 20),
        size.width * 0.5,
        baseHeight,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        baseHeight + 30 + (seed * 8 % 20),
        size.width,
        baseHeight,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);

    // Glowing dot
    final glowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.25),
      32,
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _MoodArtPainter oldDelegate) =>
      oldDelegate.seed != seed;
}
