import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../widgets/apple_button.dart';

/// 引导流程共享骨架：暖米白底 + 装饰圆（mauve 8%）+ 可选返回按钮 +
/// 灰玫瑰大标题（34pt，Figma 40px 按适老下限收）+ 内容区。
class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    super.key,
    this.title,
    this.subtitle,
    this.showBack = true,
    required this.child,
    this.bottom,
    this.contentPadding,
    this.scroll = true,
    this.safeBottom = true,
  });

  final String? title;
  final String? subtitle;
  final bool showBack;
  final Widget child;

  /// 底部固定区（CTA 按钮等）。
  final Widget? bottom;

  /// 内容区内边距，默认四周 pagePadding；通栏页面（如记录卡片堆叠）可覆盖。
  final EdgeInsetsGeometry? contentPadding;

  /// false 时内容区不可滚动（child 需自行填充有界高度，如卡片堆叠页）。
  final bool scroll;

  /// false 时 SafeArea 不留底部，内容可延伸到屏幕下边缘。
  final bool safeBottom;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          // 装饰圆（Figma decorative-circle）
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: AppColors.decorative,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            bottom: safeBottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showBack)
                  const Padding(
                    padding: EdgeInsets.only(
                      left: AppDimens.pagePadding,
                      top: AppDimens.spaceXs,
                    ),
                    child: OnboardingBackButton(),
                  ),
                Expanded(
                  child: scroll
                      ? ListView(
                          padding:
                              contentPadding ??
                              const EdgeInsets.all(AppDimens.pagePadding),
                          children: [
                            if (title != null) ...[
                              const SizedBox(height: AppDimens.spaceLg),
                              Text(
                                title!,
                                style: textTheme.displayMedium?.copyWith(
                                  color: AppColors.accent,
                                ),
                              ),
                            ],
                            if (subtitle != null) ...[
                              const SizedBox(height: AppDimens.spaceXs),
                              Text(subtitle!, style: textTheme.bodyMedium),
                            ],
                            const SizedBox(height: AppDimens.spaceMd),
                            child,
                          ],
                        )
                      : Padding(
                          padding:
                              contentPadding ??
                              const EdgeInsets.all(AppDimens.pagePadding),
                          child: child,
                        ),
                ),
                if (bottom != null)
                  Padding(
                    padding: const EdgeInsets.all(AppDimens.pagePadding),
                    child: bottom,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 返回按钮：浅蓝灰圆 + 石板蓝箭头（Figma 42:143 左上角）。
class OnboardingBackButton extends StatelessWidget {
  const OnboardingBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: () => Navigator.of(context).maybePop(),
      child: Container(
        width: AppDimens.touchMin,
        height: AppDimens.touchMin,
        decoration: const BoxDecoration(
          color: AppColors.softBlue,
          shape: BoxShape.circle,
        ),
        child: const Icon(CupertinoIcons.arrow_left, color: AppColors.slate),
      ),
    );
  }
}

/// 浅蓝灰按钮（Figma 初始页/登录选择：#D5E5F0 底 + 石板蓝粗字）。
class SoftBlueButton extends StatelessWidget {
  const SoftBlueButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppDimens.buttonHeight),
        decoration: const BoxDecoration(
          color: AppColors.softBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.radiusInput),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spaceLg,
          vertical: AppDimens.spaceXs,
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.slate),
          ),
        ),
      ),
    );
  }
}

/// 石板蓝描边按钮（Figma 用药状况：#58809F 描边 + 同色系文字）。
class SlateOutlineButton extends StatelessWidget {
  const SlateOutlineButton({
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
        constraints: const BoxConstraints(minHeight: AppDimens.buttonHeight),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.slate, width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimens.radiusTag),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spaceLg,
          vertical: AppDimens.spaceXs,
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.slate),
          ),
        ),
      ),
    );
  }
}

/// 暖粉通栏 CTA（Figma 权限页 #D2A6B3 全圆角胶囊 / 饮食页 #C56873）。
class WarmCtaButton extends StatelessWidget {
  const WarmCtaButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color = AppColors.pink,
  });

  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppDimens.buttonHeight),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimens.radiusPill),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.bgCard),
          ),
        ),
      ),
    );
  }
}
