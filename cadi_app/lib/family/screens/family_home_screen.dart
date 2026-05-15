// Figma: 158:650 (家屬首頁)
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/cadi_bottom_nav.dart';

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
      body: IndexedStack(
        index: _tabIndex,
        children: const [
          _HomeTab(),
          _PhotosTab(),
          _ChatTabStub(),
        ],
      ),
      bottomNavigationBar: CadiBottomNav(
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
    );
  }
}

// ── Tab 0: Home (Figma 1:61 — 家屬主頁面) ──
// 情緒、位置、幾分鐘前偵測 (1:71);按鈕是滑動的 (1:72) — 上滑進指北針
class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  double _dragOffset = 0;

  void _handleDragUpdate(DragUpdateDetails d) {
    setState(() {
      _dragOffset = (_dragOffset + d.delta.dy).clamp(-160.0, 0.0);
    });
  }

  void _handleDragEnd(DragEndDetails _) {
    if (_dragOffset < -80) {
      context.push('/family/compass');
    }
    setState(() => _dragOffset = 0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: _FamilyBgPainter())),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Hi',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryText,
                  ),
                ).animate().fadeIn(duration: 500.ms),
                const SizedBox(height: 4),
                Text('今天的家人狀態',
                        style: AppTextStyles.heading2(context))
                    .animate()
                    .fadeIn(delay: 150.ms),
                const SizedBox(height: 20),
                _PatientInfoRow(
                  emotion: '平靜',
                  location: '客廳',
                  detectedMinutesAgo: 3,
                ).animate().fadeIn(delay: 250.ms),
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: size.width * 0.5,
                    height: size.width * 0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.glowBlue.withValues(alpha: 0.25),
                    ),
                    child: const Icon(
                      Icons.smart_toy_rounded,
                      size: 80,
                      color: AppColors.glowBlue,
                    ),
                  ).animate().scale(
                        begin: const Offset(0.85, 0.85),
                        duration: 700.ms,
                        curve: Curves.elasticOut,
                      ),
                ),
                const SizedBox(height: 18),
                _QuickActionCard(
                  title: '查看家人狀態',
                  subtitle: '情緒、位置、最後更新時間',
                  icon: Icons.monitor_heart_rounded,
                  color: AppColors.glowBlue,
                  onTap: () => context.go('/family/status'),
                ).animate().fadeIn(delay: 300.ms),
                const SizedBox(height: 12),
                _QuickActionCard(
                  title: '閱讀家人的信',
                  subtitle: '家人留給你的私人信件',
                  icon: Icons.mail_rounded,
                  color: AppColors.glowPeach,
                  onTap: () => context.go('/family/letter/notify'),
                ).animate().fadeIn(delay: 400.ms),
              ],
            ),
          ),
        ),
        // 滑動式底部按鈕 — 上滑進指北針
        Positioned(
          left: 0,
          right: 0,
          bottom: 24,
          child: Center(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                transform:
                    Matrix4.translationValues(0, _dragOffset, 0),
                child: Container(
                  width: 160,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1F000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.keyboard_arrow_up_rounded,
                          color: AppColors.glowBlue),
                      const SizedBox(width: 6),
                      Text('上滑進指北針',
                          style: AppTextStyles.body(context)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PatientInfoRow extends StatelessWidget {
  final String emotion;
  final String location;
  final int detectedMinutesAgo;
  const _PatientInfoRow({
    required this.emotion,
    required this.location,
    required this.detectedMinutesAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _InfoItem(
              icon: Icons.mood_rounded, label: '情緒', value: emotion),
          _InfoDivider(),
          _InfoItem(
              icon: Icons.place_outlined, label: '位置', value: location),
          _InfoDivider(),
          _InfoItem(
              icon: Icons.schedule_rounded,
              label: '偵測',
              value: '$detectedMinutesAgo 分前'),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoItem(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 18, color: AppColors.glowBlue),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.caption(context)),
          Text(value,
              style: AppTextStyles.body(context)
                  .copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _InfoDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 32, color: AppColors.divider);
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: AppColors.primaryText),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText)),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.secondaryText)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: AppColors.secondaryText),
          ],
        ),
      ),
    );
  }
}

class _FamilyBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.fill;
    p.color = const Color(0xFFC5E8F9).withOpacity(0.3);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.1), size.width * 0.5, p);
    p.color = const Color(0xFFD4C5F9).withOpacity(0.2);
    canvas.drawCircle(Offset(0, size.height * 0.55), size.width * 0.4, p);
    p.color = const Color(0xFFF9DCC5).withOpacity(0.2);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.9), size.width * 0.35, p);
  }

  @override
  bool shouldRepaint(_) => false;
}

// ── Tab 1: Photos stub (Figma 1:698) ──
class _PhotosTab extends StatelessWidget {
  const _PhotosTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('典藏相片',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: 6,
        itemBuilder: (ctx, i) => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: AppColors.surface,
            child: const Icon(Icons.image_rounded,
                size: 48, color: AppColors.divider),
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
