import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                        '这次数值有点高，留意一下',
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
                          record.done ? record.summary : record.statusText,
                          style: record.done
                              ? textTheme.bodyMedium
                              : textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppDimens.spaceSm),
                  record.done
                      ? _buildDone(textTheme)
                      : AppleButton(
                          label: '打卡',
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

  Widget _buildDone(TextTheme textTheme) {
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
          '已打卡',
          style: textTheme.bodyMedium?.copyWith(color: AppColors.accent),
        ),
      ],
    );
  }
}
