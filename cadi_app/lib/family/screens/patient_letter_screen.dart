// Figma: 1:1020 (來自病人的信)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../shared/theme/app_theme.dart';

class PatientLetterScreen extends StatelessWidget {
  const PatientLetterScreen({super.key});

  // Figma Node 1:1020 — full-page Chinese letter text
  static const _letterText = '''如果你正在讀這段文字，

我想讓你知道，我很愛你。

這些日子以來，你為我做的每一件事，我都看在眼裡，記在心裡。每一次的陪伴，每一個溫柔的眼神，每一杯端來的熱茶，都是我最珍貴的禮物。

我知道，有些時候我可能不記得了，可能說了奇怪的話，可能讓你擔心。但你要相信，在最深的地方，我記得你，記得我們在一起走過的每一段路。

謝謝你沒有放棄我。

謝謝你讓我依然感覺到家的溫暖。

請你也好好照顧自己。你不需要做到完美，只要你在，就已經足夠了。

                                      永遠愛你的家人''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFAF5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('來自家人的信',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 28, 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Decorative envelope icon
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.glowPeach.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mail_rounded,
                      size: 36, color: Color(0xFFC97B4B)),
                ).animate().scale(
                  begin: const Offset(0.7, 0.7),
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                ),
              ),
              const SizedBox(height: 32),
              // Letter text — Figma 1:1020
              Text(
                _letterText,
                style: const TextStyle(
                  fontSize: 16,
                  height: 2.0,
                  color: AppColors.primaryText,
                  letterSpacing: 0.3,
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 800.ms),
              const SizedBox(height: 40),
              // Subtle divider
              Center(
                child: Container(
                  width: 40,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(1),
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
