import 'package:flutter/material.dart';

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
        // Auto-generated delegates / supportedLocales from the ARB files in
        // lib/l10n/ — to add a new language, drop in `app_<code>.arb` and
        // append the Locale to AppLocalizations.supportedLocales.
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: InitialPage(state: state),
      ),
    );
  }
}