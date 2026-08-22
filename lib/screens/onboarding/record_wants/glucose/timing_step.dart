/// 血糖向导步骤二：测量时段多选（空腹/三餐后/睡前）。
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../state/app_state.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_dimens.dart';
import '../../../../widgets/apple_button.dart';
import 'glucose_wizard.dart';

/// 56:12 步骤二：测量时段多选 + 右侧时间，底部桃色「下一步」。
class GlucoseTimingStep extends StatelessWidget {
  const GlucoseTimingStep({super.key, required this.state, required this.onStep});

  final AppState state;
  final ValueChanged<String> onStep;

  static const List<(String, String, String)> _timings = [
    ('空腹', '早起没吃饭前', '07:00'),
    ('早餐后', '吃完早餐 2 小时', '09:00'),
    ('午餐后', '吃完午餐 2 小时', '14:00'),
    ('晚餐后', '吃完晚餐 2 小时', '20:00'),
    ('睡前', '准备睡觉前', '21:30'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const StepHeader('测量时段', '您通常什么时候测血糖？多选'),
        const SizedBox(height: AppDimens.spaceSm),
        for (final (name, note, time) in _timings)
          _TimingCard(
            name: name,
            note: note,
            time: time,
            selected: state.glucoseTimings.contains(name),
            onTap: () => state.toggleGlucoseTiming(name),
          ),
        const SizedBox(height: AppDimens.spaceXs),
        Pressable(
          onTap: state.glucoseTimings.isEmpty ? () {} : () => onStep('target'),
          child: Container(
            constraints: const BoxConstraints(minHeight: AppDimens.touchMin),
            decoration: const BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimens.radiusTag),
              ),
            ),
            child: Center(
              child: Text(
                '下一步',
                style: textTheme.titleLarge?.copyWith(color: AppColors.slate),
              ),
            ),
          ),
        ),
        // 底部留白，避免按钮紧贴下一张卡的标题条。
        const SizedBox(height: AppDimens.spaceMd),
      ],
    );
  }
}

/// 56:12 时段行：勾选框 + 名称/说明 + 选中时右侧时间牌。
class _TimingCard extends StatelessWidget {
  const _TimingCard({
    required this.name,
    required this.note,
    required this.time,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final String note;
  final String time;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.spaceXs),
      child: Pressable(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: AppDimens.touchMin),
          decoration: BoxDecoration(
            color: selected ? AppColors.accentSoft : AppColors.bgCard,
            borderRadius: const BorderRadius.all(
              Radius.circular(AppDimens.radiusInput),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.spaceSm,
            vertical: AppDimens.spaceXs,
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: selected ? AppColors.checkboxRose : AppColors.bgCard,
                  border: selected
                      ? null
                      : Border.all(color: AppColors.divider, width: 2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppDimens.radiusTag / 2),
                  ),
                ),
                child: selected
                    ? const Icon(
                        CupertinoIcons.checkmark,
                        size: 18,
                        color: AppColors.bgCard,
                      )
                    : null,
              ),
              const SizedBox(width: AppDimens.spaceSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: textTheme.titleMedium?.copyWith(
                        color: selected ? AppColors.accent : AppColors.deepBlue,
                      ),
                    ),
                    Text(
                      '— $note',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Container(
                  width: 72,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimens.radiusTag),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      time,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
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
