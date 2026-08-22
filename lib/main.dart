import 'package:flutter/material.dart';

import 'screens/onboarding/entry_pages.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(AllGoodApp(state: AppState()));
}

/// All Good 入口：纯前端 demo，内存态数据，无后端。
/// 启动先进入引导/设置流程（Figma initial page），完成后进入三 Tab 主页。
class AllGoodApp extends StatelessWidget {
  const AllGoodApp({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Good',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: InitialPage(state: state),
    );
  }
}
