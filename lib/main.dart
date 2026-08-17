import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/family_screen.dart';
import 'screens/today_screen.dart';
import 'screens/trends_screen.dart';
import 'state/app_state.dart';
import 'theme/app_colors.dart';
import 'theme/app_dimens.dart';
import 'theme/app_theme.dart';
import 'widgets/apple_button.dart';

void main() {
  runApp(AllGoodApp(state: AppState()));
}

/// All Good 入口：纯前端 demo，内存态数据，无后端。
class AllGoodApp extends StatelessWidget {
  const AllGoodApp({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Good',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: HomeShell(state: state),
    );
  }
}

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
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          TodayScreen(state: widget.state),
          const TrendsScreen(),
          FamilyScreen(state: widget.state),
        ],
      ),
      bottomNavigationBar: _CupertinoTabBar(
        index: _index,
        onChanged: (index) => setState(() => _index = index),
      ),
    );
  }
}

/// Cupertino 风格 tab bar：白底、顶部 0.5px hairline 分隔线、
/// 选中 accent 蓝图标 + 文字、未选中灰色，无任何背景指示块。
class _CupertinoTabBar extends StatelessWidget {
  const _CupertinoTabBar({required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  static const List<(IconData, String)> _tabs = [
    (CupertinoIcons.calendar_today, '今天'),
    (CupertinoIcons.chart_bar_fill, '趋势'),
    (CupertinoIcons.person_2_fill, '家人'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
              for (var i = 0; i < _tabs.length; i++)
                Expanded(
                  child: Pressable(
                    onTap: () => onChanged(i),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _tabs[i].$1,
                          size: AppDimens.tabIconSize,
                          color: i == index
                              ? AppColors.accent
                              : AppColors.textSecondary,
                        ),
                        Text(
                          _tabs[i].$2,
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
