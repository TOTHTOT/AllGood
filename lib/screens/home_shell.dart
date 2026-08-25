import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../widgets/apple_button.dart';
import 'family_screen.dart';
import 'today_screen.dart';
import 'trends_screen.dart';

/// 底部三 Tab 导航壳。
class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.state});

  final AppState state;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.state,
      builder: (context, _) {
        return Scaffold(
          body: IndexedStack(
            index: _index,
            children: [
              TodayScreen(state: widget.state),
              TrendsScreen(state: widget.state),
              FamilyScreen(state: widget.state),
            ],
          ),
          bottomNavigationBar: _CupertinoTabBar(
            index: _index,
            onChanged: (index) => setState(() => _index = index),
            labels: const [
              (CupertinoIcons.calendar_today, _TabKind.today),
              (CupertinoIcons.chart_bar_fill, _TabKind.trends),
              (CupertinoIcons.person_2_fill, _TabKind.family),
            ],
          ),
        );
      },
    );
  }
}

enum _TabKind { today, trends, family }

extension on AppLocalizations {
  String labelFor(_TabKind kind) {
    switch (kind) {
      case _TabKind.today:
        return tabToday;
      case _TabKind.trends:
        return tabTrends;
      case _TabKind.family:
        return tabFamily;
    }
  }
}

/// Cupertino 风格 tab bar：白底、顶部 0.5px hairline 分隔线、
/// 选中强调色图标 + 文字、未选中灰色，无任何背景指示块。
class _CupertinoTabBar extends StatelessWidget {
  const _CupertinoTabBar({
    required this.index,
    required this.onChanged,
    required this.labels,
  });

  final int index;
  final ValueChanged<int> onChanged;
  final List<(IconData, _TabKind)> labels;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context);
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgCard,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppDimens.tabBarHeight,
          child: Row(
            children: [
              for (var i = 0; i < labels.length; i++)
                Expanded(
                  child: Pressable(
                    onTap: () => onChanged(i),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          labels[i].$1,
                          size: AppDimens.tabIconSize,
                          color: i == index
                              ? AppColors.accent
                              : AppColors.textSecondary,
                        ),
                        Text(
                          loc.labelFor(labels[i].$2),
                          style: textTheme.bodyMedium?.copyWith(
                            color: i == index
                                ? AppColors.accent
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
