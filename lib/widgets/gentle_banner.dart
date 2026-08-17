import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

/// DESIGN.md 第 6 节「提醒与反馈」：顶部柔和横幅，warning 浅底 + 深色文字。
class GentleBanner extends StatelessWidget {
  const GentleBanner(
      {super.key, required this.text, this.icon = CupertinoIcons.heart_fill});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.warningSoft,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimens.radiusInput),
        ),
      ),
      padding: const EdgeInsets.all(AppDimens.spaceSm),
      child: Row(
        children: [
          Icon(icon, color: AppColors.warning, size: AppDimens.iconLarge),
          const SizedBox(width: AppDimens.spaceSm),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
