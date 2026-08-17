import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import 'apple_button.dart';

/// 大号 +/- 数字步进器（DESIGN.md：数值调整用大号按钮，避免唤起小键盘）。
/// iOS 风格：浅灰圆形底、深色图标、无填充色块感。
class NumberStepper extends StatelessWidget {
  const NumberStepper({
    super.key,
    required this.label,
    required this.valueText,
    required this.unit,
    required this.onDecrease,
    required this.onIncrease,
  });

  final String label;
  final String valueText;
  final String unit;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.titleMedium),
        const SizedBox(height: AppDimens.spaceXs),
        Row(
          children: [
            _StepButton(icon: CupertinoIcons.minus, onPressed: onDecrease),
            Expanded(
              child: Column(
                children: [
                  Text(
                    valueText,
                    style: textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(unit, style: textTheme.bodySmall),
                ],
              ),
            ),
            _StepButton(icon: CupertinoIcons.plus, onPressed: onIncrease),
          ],
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onPressed,
      child: Container(
        width: AppDimens.buttonHeight,
        height: AppDimens.buttonHeight,
        decoration: const BoxDecoration(
          color: AppColors.divider,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: AppDimens.iconLarge,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
