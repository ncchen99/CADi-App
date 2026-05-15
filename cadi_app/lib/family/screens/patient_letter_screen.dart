// Figma: 1:1020 (來自患者的信)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../shared/theme/app_theme.dart';
import '../widgets/family_chrome.dart';

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

                                      永遠愛你的患者''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FamilySoftBackground(
        warm: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            child: Column(
              children: [
                FamilyTopBar(onBack: () => context.pop()),
                const SizedBox(height: 18),
                Expanded(
                  child: FamilyPanel(
                    padding: const EdgeInsets.fromLTRB(28, 34, 28, 30),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              '來自患者的信',
                              style: AppTextStyles.heading1(context),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            _letterText,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 2.0,
                              color: AppColors.primaryText,
                            ),
                          ).animate().fadeIn(delay: 220.ms, duration: 700.ms),
                          const SizedBox(height: 34),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
