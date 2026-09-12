/*
 * @Author: TOTHTOT 37585883+TOTHTOT@users.noreply.github.com
 * @Date: 2026-08-25 19:59:38
 * @LastEditors: TOTHTOT 37585883+TOTHTOT@users.noreply.github.com
 * @LastEditTime: 2026-08-25 22:07:31
 * @FilePath: \AllGood\lib\main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'l10n/app_localizations.dart';
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
    return ListenableBuilder(
      listenable: state,
      builder: (_, _) => MaterialApp(
        title: 'All Good',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        locale: state.locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: InitialPage(state: state),
      ),
    );
  }
}


/// Widget Preview
@Preview(
  name: 'All Good',
  group: 'App',
  size: Size(390, 844),
)
Widget allGoodPreview() {
  return AllGoodApp(
    state: AppState(),
  );
}