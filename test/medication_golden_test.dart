import 'package:all_good/l10n/app_localizations.dart';
import 'package:all_good/screens/onboarding/medication/medication_detail_page.dart';
import 'package:all_good/screens/onboarding/medication/medication_meal_page.dart';
import 'package:all_good/state/app_state.dart';
import 'package:all_good/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget home) {
  return MaterialApp(
    theme: AppTheme.light(),
    locale: const Locale('zh'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
}

void main() {
  testWidgets('medication detail page golden', (tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_wrap(MedicationDetailPage(state: AppState())));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MedicationDetailPage),
      matchesGoldenFile('goldens/medication_detail.png'),
    );
  });

  testWidgets('medication meal page golden', (tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      _wrap(
        MedicationMealPage(
          state: AppState(),
          name: '降压药',
          timesPerDay: 1,
          pillsEach: 1,
          doseTimes: const ['08:00'],
        ),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MedicationMealPage),
      matchesGoldenFile('goldens/medication_meal.png'),
    );
  });
}
