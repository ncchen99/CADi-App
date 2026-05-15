import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  double _dragOffset = 0;

  void _onDragUpdate(DragUpdateDetails d) {
    setState(() {
      _dragOffset = (_dragOffset + d.delta.dy).clamp(-160.0, 0.0);
    });
  }

  void _onDragEnd(DragEndDetails _) {
    if (_dragOffset < -80) {
      context.push('/client/mosaic');
    }
    setState(() => _dragOffset = 0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.go('/client/mood'),
      onVerticalDragUpdate: _onDragUpdate,
      onVerticalDragEnd: _onDragEnd,
      child: ClientGradientBackground(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: size.height * 0.438,
              child: Center(
                child: SizedBox(
                  width: 112,
                  height: 72,
                  child: CustomPaint(painter: _HiMarkPainter()),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -68,
              child: Center(
                child: Container(
                  width: size.width * 0.6,
                  height: size.width * 0.43,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(999)),
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFFFFC19E),
                        Color(0xFFFFAE87),
                        Color(0xFFFFE9C8),
                        Color(0x00FFE9C8),
                      ],
                      stops: [0, 0.48, 0.72, 1],
                    ),
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

class _HiMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final markPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.029
      ..strokeCap = StrokeCap.round
      ..color = AppColors.peach;

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Hı',
        style: GoogleFonts.lexend(
          color: AppColors.primaryText.withValues(alpha: 0.95),
          fontSize: size.height * 1.03,
          fontWeight: FontWeight.w800,
          height: 0.96,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas, Offset.zero);

    final dotCenter = Offset(size.width * 0.645, size.height * 0.018);
    canvas.drawCircle(dotCenter, size.width * 0.092, markPaint);
    canvas.drawCircle(dotCenter, size.width * 0.039, markPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
