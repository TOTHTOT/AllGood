import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

/// 按压时以透明度变化（0.6）反馈，替代 Material 水波纹。
class Pressable extends StatefulWidget {
  const Pressable({
    super.key,
    required this.onTap,
    required this.child,
    this.borderRadius,
  });

  final VoidCallback onTap;
  final Widget child;
  final BorderRadius? borderRadius;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _pressed = false;

  void _setPressed(bool value) => setState(() => _pressed = value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedOpacity(
        opacity: _pressed ? 0.6 : 1,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}

/// iOS 胶囊按钮：accent 蓝实色填充、白色文字、全圆角、无阴影。
/// [compact] 用于卡片内「打卡」（高 56、横向 padding 28）；
/// 默认是页面/弹层主按钮（高 64、通栏）。
class AppleButton extends StatelessWidget {
  const AppleButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.compact = false,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final bool compact;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(color: AppColors.bgCard);
    return Pressable(
      onTap: onPressed,
      child: Container(
        constraints: BoxConstraints(
          minHeight:
              compact ? AppDimens.checkButtonHeight : AppDimens.buttonHeight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spaceLg - 4, // 胶囊横向 padding 28
        ),
        decoration: const BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.radiusPill),
          ),
        ),
        child: Row(
          mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColors.bgCard),
              const SizedBox(width: AppDimens.spaceXs),
            ],
            Text(label, style: textStyle),
          ],
        ),
      ),
    );
  }
}

/// iOS tinted 次级按钮：accentSoft 浅底 + accent 文字（拍照、导出等）。
class AppleTintedButton extends StatelessWidget {
  const AppleTintedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(color: AppColors.accent);
    return Pressable(
      onTap: onPressed,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppDimens.buttonHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spaceLg - 4,
        ),
        decoration: const BoxDecoration(
          color: AppColors.accentSoft,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.radiusPill),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColors.accent),
              const SizedBox(width: AppDimens.spaceXs),
            ],
            Text(label, style: textStyle),
          ],
        ),
      ),
    );
  }
}
