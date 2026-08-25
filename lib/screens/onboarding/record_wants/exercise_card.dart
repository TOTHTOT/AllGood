/// 运动信息卡片内容：每日步数目标的增减与保存。
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../state/app_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_dimens.dart';
import '../../../widgets/apple_button.dart';
import '../../../widgets/ios_toast.dart';

/// 运动信息展开：每日步数目标（Figma 该卡为灰色占位，替换为正式内容）。
class ExerciseCard extends StatefulWidget {
  const ExerciseCard({super.key, required this.state});

  final AppState state;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late int _goal = widget.state.stepGoal;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l.exerciseGoalTitle,
          style: textTheme.titleLarge?.copyWith(color: AppColors.bgCard),
        ),
        const SizedBox(height: AppDimens.spaceSm),
        Row(
          children: [
            _RoundStepButton(
              icon: CupertinoIcons.minus,
              onTap: () => setState(() {
                if (_goal > 1000) _goal -= 500;
              }),
            ),
            Expanded(
              child: Text(
                l.exerciseGoalSteps(_goal),
                textAlign: TextAlign.center,
                style: textTheme.displayMedium?.copyWith(
                  color: AppColors.bgCard,
                ),
              ),
            ),
            _RoundStepButton(
              icon: CupertinoIcons.plus,
              onTap: () => setState(() => _goal += 500),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.spaceMd),
        Pressable(
          onTap: () {
            widget.state.stepGoal = _goal;
            showIosToast(context, l.exerciseGoalSaved);
          },
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
                l.exerciseGoalAdd,
                style: textTheme.titleLarge?.copyWith(color: AppColors.slate),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RoundStepButton extends StatelessWidget {
  const _RoundStepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        width: AppDimens.touchMin,
        height: AppDimens.touchMin,
        decoration: const BoxDecoration(
          color: AppColors.bgCard,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.slate),
      ),
    );
  }
}
