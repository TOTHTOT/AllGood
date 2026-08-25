/// 血糖向导步骤一：测量方式单选（CGM / 手动测量）。
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../state/app_state.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_dimens.dart';
import '../../../../widgets/apple_button.dart';
import 'glucose_wizard.dart';

/// 45:228 步骤一：测量方式单选（选中即进入下一步；CGM 先进蓝牙配对步）。
class GlucoseMethodStep extends StatelessWidget {
  const GlucoseMethodStep({super.key, required this.state, required this.onStep});

  final AppState state;
  final ValueChanged<String> onStep;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StepHeader(l.sugarStepMethod, l.sugarStepMethodHint),
        const SizedBox(height: AppDimens.spaceSm),
        _RadioCard(
          title: l.sugarMethodCgm,
          subtitle: l.sugarMethodCgmSub,
          selected: state.glucoseMethod == GlucoseMethod.cgm,
          onTap: () {
            state.setGlucoseMethod(GlucoseMethod.cgm);
            onStep('bluetooth');
          },
        ),
        _RadioCard(
          title: l.sugarMethodManual,
          subtitle: l.sugarMethodManualSub,
          selected: state.glucoseMethod == GlucoseMethod.manual,
          onTap: () {
            state.setGlucoseMethod(GlucoseMethod.manual);
            onStep('timing');
          },
        ),
      ],
    );
  }
}

/// 单选卡（45:228 / 69:193）：选中桃粉底 + 红圈点，未选白底 + 灰圈。
class _RadioCard extends StatelessWidget {
  const _RadioCard({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
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
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppColors.accent : AppColors.bgCard,
                  border: selected
                      ? null
                      : Border.all(color: AppColors.divider, width: 2),
                ),
                child: selected
                    ? const Center(
                        child: Icon(
                          CupertinoIcons.circle_fill,
                          size: 12,
                          color: AppColors.bgCard,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: AppDimens.spaceSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        color: selected ? AppColors.accent : AppColors.deepBlue,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: selected
                            ? AppColors.checkboxRose
                            : AppColors.blueMid,
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
