/// 「我想要记录」页的堆叠式卡片容器（含标题栏、面包屑与返回箭头）。
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_dimens.dart';
import '../../../widgets/apple_button.dart';

/// 堆叠式卡片列表：卡片之间负间距叠放（下层卡压住上层卡底边），
/// 收起时只露标题条；点击后卡片滑上去盖住上方内容、自身撑开，
/// 位置与高度均带 350ms 动画，其余卡保持标题可见。
class CardStack extends StatelessWidget {
  const CardStack({
    super.key,
    required this.expanded,
    required this.collapsedHeight,
    required this.overlap,
    required this.onToggle,
    required this.children,
    required this.colors,
    this.breadcrumbs = const {},
    this.backActions = const {},
    this.scrollKeys = const {},
  });

  final String expanded;
  final double collapsedHeight;
  final double overlap;
  final ValueChanged<String> onToggle;
  final Map<String, Widget> children;
  final Map<String, Color> colors;

  /// 标题栏内卡片名右侧的面包屑小字（血糖向导用）。
  final Map<String, String?> breadcrumbs;

  /// 标题栏右侧圆圈返回箭头的点击行为（血糖向导用）。
  final Map<String, VoidCallback> backActions;

  /// 卡内容滚动区的 key：值变化时重建滚动区、滚动位置归零（向导切步用）。
  final Map<String, Object?> scrollKeys;

  static const _duration = Duration(milliseconds: 350);
  static const _curve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context) {
    final keys = children.keys.toList();
    return LayoutBuilder(
      builder: (context, constraints) {
        // 展开卡高度 = 可用高度 - 其余两条收起卡露出的高度。
        final expandedHeight =
            constraints.maxHeight - (collapsedHeight - overlap) * 2;
        final heights = [
          for (final k in keys)
            expanded == k ? expandedHeight : collapsedHeight,
        ];
        double topOf(int i) {
          var t = 0.0;
          for (var j = 0; j < i; j++) {
            t += heights[j] - overlap;
          }
          return t;
        }

        return Stack(
          children: [
            for (var i = 0; i < keys.length; i++)
              AnimatedPositioned(
                duration: _duration,
                curve: _curve,
                top: topOf(i),
                left: 0,
                right: 0,
                height: heights[i],
                child: _SwitchCard(
                  title: keys[i],
                  // Figma 45:237/44:199：展开后变浅蓝；血糖面板用 #8FBFEB。
                  color: expanded == keys[i]
                      ? (keys[i] == '血糖'
                            ? AppColors.blueSheet
                            : AppColors.blueLight)
                      : colors[keys[i]]!,
                  expanded: expanded == keys[i],
                  titleBarHeight: collapsedHeight,
                  onTap: () => onToggle(keys[i]),
                  breadcrumb: breadcrumbs[keys[i]],
                  onBack: backActions[keys[i]],
                  scrollKey: scrollKeys[keys[i]],
                  child: children[keys[i]]!,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _SwitchCard extends StatelessWidget {
  const _SwitchCard({
    required this.title,
    required this.color,
    required this.expanded,
    required this.titleBarHeight,
    required this.onTap,
    required this.child,
    this.breadcrumb,
    this.onBack,
    this.scrollKey,
  });

  final String title;
  final Color color;
  final bool expanded;
  final double titleBarHeight;
  final VoidCallback onTap;
  final Widget child;

  /// 卡片名右侧的面包屑小字（血糖向导已完成步骤）。
  final String? breadcrumb;

  /// 标题栏右侧圆圈返回箭头（null 则不显示）。
  final VoidCallback? onBack;

  /// 内容滚动区的 key：变化时滚动位置归零。
  final Object? scrollKey;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AnimatedContainer(
      duration: CardStack._duration,
      curve: CardStack._curve,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color,
        // Figma 原稿圆角为 "25px 25px 1px 0px"：只圆顶部两角。
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: const [
          // 轻微上投影，强化"这张卡压在上面"的层叠感
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Pressable(
            onTap: onTap,
            child: Container(
              height: titleBarHeight,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.cardPadding,
              ),
              child: Row(
                children: [
                  Text(
                    title,
                    style: textTheme.headlineMedium?.copyWith(
                      color: AppColors.bgCard,
                    ),
                  ),
                  if (expanded && breadcrumb != null) ...[
                    const SizedBox(width: AppDimens.spaceSm),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        breadcrumb!,
                        style: textTheme.titleSmall?.copyWith(
                          color: AppColors.softBlue,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  if (expanded && onBack != null)
                    Pressable(
                      onTap: onBack!,
                      child: Container(
                        width: AppDimens.iconLarge,
                        height: AppDimens.iconLarge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.bgCard,
                          border: Border.all(color: AppColors.slate, width: 3),
                        ),
                        child: const Icon(
                          CupertinoIcons.arrow_left,
                          color: AppColors.slate,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (expanded)
            Expanded(
              child: SingleChildScrollView(
                key: ValueKey(scrollKey),
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.cardPadding,
                  0,
                  AppDimens.cardPadding,
                  AppDimens.cardPadding,
                ),
                child: child,
              ),
            ),
        ],
      ),
    );
  }
}
