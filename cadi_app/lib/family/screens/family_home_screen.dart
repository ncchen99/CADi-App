// Figma: 158:650 (家屬首頁)
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../client/widgets/client_chrome.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/cadi_bottom_nav.dart';
import '../widgets/family_chrome.dart';

class FamilyHomeScreen extends StatefulWidget {
  const FamilyHomeScreen({super.key});

  @override
  State<FamilyHomeScreen> createState() => _FamilyHomeScreenState();
}

class _FamilyHomeScreenState extends State<FamilyHomeScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _tabIndex,
        children: const [
          _HomeTab(),
          _PhotosTab(),
          _ChatTabStub(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
        child: CadiBottomNav(
          currentIndex: _tabIndex,
          mode: AppMode.family,
          onTap: (i) {
            if (i == 2) {
              context.go('/family/chat');
            } else {
              setState(() => _tabIndex = i);
            }
          },
        ),
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

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset = (_dragOffset + details.delta.dy).clamp(-156.0, 0.0);
    });
  }

  void _handleDragEnd(DragEndDetails _) {
    if (_dragOffset < -76) context.push('/family/compass');
    setState(() => _dragOffset = 0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return FamilySoftBackground(
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 34, 28, 118),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CadiTinyMark(size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Hi',
                        style: AppTextStyles.displayLarge(context).copyWith(
                          color: const Color(0xFF6EA6C9),
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 450.ms),
                  const SizedBox(height: 8),
                  Text(
                    '今天想怎麼關心患者',
                    style: AppTextStyles.body(context).copyWith(fontSize: 13),
                  ).animate().fadeIn(delay: 100.ms),
                  const SizedBox(height: 24),
                  const FamilyStatusPill(
                    mood: '情緒穩定',
                    location: '客廳',
                    time: '30 分鐘前',
                  ).animate().fadeIn(delay: 180.ms),
                  const Spacer(),
                  const CadiSoftBot(size: 176)
                      .animate()
                      .fadeIn(delay: 180.ms)
                      .scale(
                        begin: const Offset(0.9, 0.9),
                        curve: Curves.easeOutBack,
                        duration: 640.ms,
                      ),
                  const SizedBox(height: 24),
                  _SwipeControl(
                    dragOffset: _dragOffset,
                    onDragUpdate: _handleDragUpdate,
                    onDragEnd: _handleDragEnd,
                  ).animate().fadeIn(delay: 280.ms),
                  SizedBox(height: size.height * 0.05),
                  Row(
                    children: [
                      Expanded(
                        child: _HomeAction(
                          icon: Icons.monitor_heart_rounded,
                          label: '患者狀態',
                          onTap: () => context.go('/family/status'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _HomeAction(
                          icon: Icons.mail_rounded,
                          label: '患者的信',
                          onTap: () => context.go('/family/letter/notify'),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 360.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwipeControl extends StatelessWidget {
  final double dragOffset;
  final GestureDragUpdateCallback onDragUpdate;
  final GestureDragEndCallback onDragEnd;

  const _SwipeControl({
    required this.dragOffset,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragUpdate: onDragUpdate,
      onVerticalDragEnd: onDragEnd,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(0, dragOffset, 0),
        width: 164,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(27),
          border: Border.all(color: const Color(0xFFE7EEF5)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x16000000),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on_outlined, color: Color(0xFF6EA6C9)),
            const SizedBox(width: 30),
            const Icon(Icons.chat_bubble_outline_rounded,
                color: Color(0xFF6EA6C9)),
          ],
        ),
      ),
    );
  }
}

class _HomeAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HomeAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFECEFF4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 19, color: const Color(0xFF6EA6C9)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption(context).copyWith(
                  color: AppColors.primaryText,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotosTab extends StatelessWidget {
  const _PhotosTab();

  @override
  Widget build(BuildContext context) {
    return FamilySoftBackground(
      warm: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 116),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('典藏相片', style: AppTextStyles.heading1(context)),
              const SizedBox(height: 18),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.82,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        border: Border.all(color: const Color(0xFFEFEFEF)),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 42,
                          color: Color(0xFFB7C8D6),
                        ),
                      ),
                    ),
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

class _ChatTabStub extends StatelessWidget {
  const _ChatTabStub();

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
