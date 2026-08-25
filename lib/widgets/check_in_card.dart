import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import 'apple_button.dart';

/// DESIGN.md 第 6 节「打卡卡片」：今日页主体组件。
/// 未完成 → 右侧 iOS 胶囊「打卡」按钮；已完成 → ok 色对勾 + 「已打卡」。
class CheckInCard extends StatelessWidget {
  const CheckInCard({
    super.key,
    required this.icon,
    required this.title,
    required this.record,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final CheckInRecord record;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Pressable(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (record.abnormal)
              Container(
                color: AppColors.dangerSoft,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.cardPadding,
                  vertical: AppDimens.spaceXs,
                ),
                child: Row(
                  children: [
                    Container(
                      width: AppDimens.dangerBarHeight * 2,
                      height: AppDimens.spaceMd,
                      decoration: const BoxDecoration(
                        color: AppColors.danger,
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppDimens.radiusTag),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.spaceXs),
                    Expanded(
                      child: Text(
                        l.abnormalWarning,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.danger),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.cardPadding),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: AppDimens.iconLarge,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: AppDimens.spaceSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: textTheme.titleLarge),
                        const SizedBox(height: AppDimens.spaceXs),
                        Text(
                          _subtitle(l),
                          style: record.done
                              ? textTheme.bodyMedium
                              : textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppDimens.spaceSm),
                  record.done
                      ? _buildDone(textTheme, l)
                      : AppleButton(
                          label: l.recordButton,
                          compact: true,
                          onPressed: onTap,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 未打卡 → 占位文案（按当前语言解析）；已打卡 → 用户填的实际摘要，
  /// 若为空则用本地化的"默认完成文案"兜底。
  String _subtitle(AppLocalizations l) {
    if (!record.done) {
      switch (record.type) {
        case CheckInType.medication:
          return l.checkInMedicationStatus;
        case CheckInType.bloodPressure:
          return l.checkInBloodPressureStatus;
        case CheckInType.bloodSugar:
          return l.checkInBloodSugarStatus;
        case CheckInType.diet:
          return l.checkInDietStatus;
        case CheckInType.exercise:
          return l.checkInExerciseStatus;
      }
    }
    if (record.userSummary.isNotEmpty) return record.userSummary;
    // 已完成但没填具体数值时，按类型给出兜底文案。
    switch (record.type) {
      case CheckInType.medication:
        return l.checkInMedicationSummary;
      case CheckInType.bloodPressure:
      case CheckInType.bloodSugar:
      case CheckInType.exercise:
        return '';
      case CheckInType.diet:
        return l.dietSummary(l.dietSugarLow);
    }
  }

  Widget _buildDone(TextTheme textTheme, AppLocalizations l) {
    return Column(
      children: [
        Container(
          width: AppDimens.iconLarge,
          height: AppDimens.iconLarge,
          decoration: const BoxDecoration(
            color: AppColors.accentSoft,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            CupertinoIcons.checkmark,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: AppDimens.spaceXs),
        Text(
          l.checkedIn,
          style: textTheme.bodyMedium?.copyWith(color: AppColors.accent),
        ),
      ],
    );
  }
}
