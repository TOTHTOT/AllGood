/// 餐前/餐后 + 备注页（Figma 207:190「吃药」）：用药详情页「确定」后进入，
/// 选择餐前/餐后、填写备注，确认后组装 `Medication` 入库并返回用药添加页。
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../state/app_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_dimens.dart';
import '../../../widgets/apple_button.dart';
import '../onboarding_widgets.dart';

/// 207:190 餐前/餐后 + 备注。
class MedicationMealPage extends StatefulWidget {
  const MedicationMealPage({
    super.key,
    required this.state,
    required this.name,
    required this.timesPerDay,
    required this.pillsEach,
    required this.doseTimes,
  });

  final AppState state;
  final String name;
  final int timesPerDay;
  final int pillsEach;
  final List<String> doseTimes;

  @override
  State<MedicationMealPage> createState() => _MedicationMealPageState();
}

class _MedicationMealPageState extends State<MedicationMealPage> {
  final _noteController = TextEditingController();

  /// 'before' / 'after'，默认餐前。
  String _mealTiming = 'before';

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _confirm() {
    widget.state.addMedication(
      Medication(
        name: widget.name,
        timesPerDay: widget.timesPerDay,
        pillsEach: widget.pillsEach,
        doseTimes: widget.doseTimes,
        mealTiming: _mealTiming,
        note: _noteController.text.trim(),
      ),
    );
    // 弹掉本页与用药详情页，回到用药添加页。
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return OnboardingScaffold(
      title: null,
      showBack: false,
      scroll: false,
      bottom: MedicationConfirmCard(
        label: l.medicationConfirmLabel,
        onTap: _confirm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceSm),
          PurpleTopBar(title: l.medicationStatusTitle),
          const SizedBox(height: AppDimens.spaceMd),
          // Figma 原稿大卡纵向撑满（y:120→706）。
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppDimens.cardPadding),
              decoration: const BoxDecoration(
                color: AppColors.purpleSoft,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                // 药名（只读）+ 右侧深紫勾选图标（207:190 卡内顶部）
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.name,
                        style: textTheme.titleLarge?.copyWith(
                          color: AppColors.bgPage,
                        ),
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.checkmark_square_fill,
                      color: AppColors.purpleDeep,
                      size: AppDimens.iconLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.spaceMd),
                // 餐前 / 餐后切换
                Row(
                  children: [
                    Expanded(
                      child: _MealTimingButton(
                        label: l.medicationMealBefore,
                        selected: _mealTiming == 'before',
                        onTap: () => setState(() => _mealTiming = 'before'),
                      ),
                    ),
                    const SizedBox(width: AppDimens.spaceSm),
                    Expanded(
                      child: _MealTimingButton(
                        label: l.medicationMealAfter,
                        selected: _mealTiming == 'after',
                        onTap: () => setState(() => _mealTiming = 'after'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.spaceMd),
                // 备注输入区（207:190 紫色大块，hint 居中）
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(AppDimens.spaceSm),
                    decoration: const BoxDecoration(
                      color: AppColors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextField(
                      controller: _noteController,
                      maxLines: null,
                      expands: true,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.bgPage,
                      ),
                      decoration: InputDecoration(
                        hintText: l.medicationNoteHint,
                        hintStyle: textTheme.titleMedium?.copyWith(
                          color: AppColors.bgPage,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimens.spaceSm),
                // 卡内右下白色垃圾桶（207:190）：清空备注
                Align(
                  alignment: Alignment.centerRight,
                  child: Pressable(
                    onTap: () => setState(_noteController.clear),
                    child: const Padding(
                      padding: EdgeInsets.all(AppDimens.spaceXs),
                      child: Icon(
                        CupertinoIcons.delete,
                        size: 32,
                        color: AppColors.bgCard,
                      ),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 餐前/餐后切换按钮（207:190）：均为紫底奶油字，选中的加奶油色描边。
class _MealTimingButton extends StatelessWidget {
  const _MealTimingButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.purple,
          border: selected
              ? Border.all(color: AppColors.bgPage, width: 3)
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.bgPage),
          ),
        ),
      ),
    );
  }
}

/// 用药流程底部「确定」描边大卡（Figma 206:131 / 207:190，374×101）：
/// 高 96、`AppColors.purpleStroke` 4px 描边、圆角 10、浅紫 48px 文字。
class MedicationConfirmCard extends StatelessWidget {
  const MedicationConfirmCard({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        height: 96,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.purpleStroke, width: 4),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 48,
              color: AppColors.purplePale,
            ),
          ),
        ),
      ),
    );
  }
}
