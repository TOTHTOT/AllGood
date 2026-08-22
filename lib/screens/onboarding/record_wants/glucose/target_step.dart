/// 血糖向导步骤三：血糖目标单选（一般标准 / 糖尿病人标准 / 自定义）。
library;

import 'package:flutter/material.dart';

import '../../../../state/app_state.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_dimens.dart';
import '../../../../widgets/apple_button.dart';
import '../../../../widgets/ios_toast.dart';
import 'glucose_wizard.dart';

/// 69:193 步骤三：血糖目标单选（选中标准项即完成；自定义进入卡内数值步）。
class GlucoseTargetStep extends StatelessWidget {
  const GlucoseTargetStep({super.key, required this.state, required this.onStep});

  final AppState state;
  final ValueChanged<String> onStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const StepHeader('血糖目标', '一般不用改，直接下一步就好'),
        const SizedBox(height: AppDimens.spaceSm),
        _TargetCard(
          title: '一般标准',
          value: '空腹 < 6.1   餐后 < 7.8',
          note: '适合血糖偏高、未确诊',
          selected: state.glucoseTarget == GlucoseTarget.standard,
          onTap: () {
            state.setGlucoseTarget(GlucoseTarget.standard);
            showIosToast(context, '血糖设置完成');
          },
        ),
        _TargetCard(
          title: '糖尿病人标准',
          value: '空腹 < 7.0   餐后 < 10.0',
          note: '已确诊的常用控制目标',
          selected: state.glucoseTarget == GlucoseTarget.diabetic,
          onTap: () {
            state.setGlucoseTarget(GlucoseTarget.diabetic);
            showIosToast(context, '血糖设置完成');
          },
        ),
        _TargetCard(
          title: '自定义',
          value: null,
          note: '根据医生建议设置目标范围',
          selected: state.glucoseTarget == GlucoseTarget.custom,
          onTap: () {
            state.setGlucoseTarget(GlucoseTarget.custom);
            onStep('custom');
          },
        ),
      ],
    );
  }
}

/// 69:193 目标卡：三行（名称/数值/说明），选中桃粉底 + 白芯蓝环。
class _TargetCard extends StatelessWidget {
  const _TargetCard({
    required this.title,
    required this.value,
    required this.note,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String? value;
  final String note;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.spaceSm),
      child: Pressable(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: AppDimens.buttonHeight),
          decoration: BoxDecoration(
            color: selected ? AppColors.accentSoft : AppColors.bgCard,
            borderRadius: const BorderRadius.all(
              Radius.circular(AppDimens.radiusInput),
            ),
          ),
          padding: const EdgeInsets.all(AppDimens.spaceSm),
          child: Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.bgCard,
                  border: Border.all(
                    color: selected ? AppColors.deepBlue : AppColors.divider,
                    width: selected ? 4 : 2,
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.spaceSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleSmall?.copyWith(
                        color: selected
                            ? AppColors.checkboxRose
                            : AppColors.deepBlue,
                      ),
                    ),
                    if (value != null)
                      Text(
                        value!,
                        style: textTheme.titleMedium?.copyWith(
                          color: selected
                              ? AppColors.accent
                              : AppColors.deepBlue,
                        ),
                      ),
                    Text(
                      note,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
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
