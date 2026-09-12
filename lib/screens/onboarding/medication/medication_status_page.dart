/// 用药状况页（44:181）：两个描边大按钮，选择「不需要用药」或「需要用药」。
library;

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../state/app_state.dart';
import '../../../theme/app_dimens.dart';
import '../onboarding_widgets.dart';
import '../record_wants_page.dart';
import 'medication_add_page.dart';

/// 44:181 用药状况：两个描边大按钮。
class MedicationStatusPage extends StatelessWidget {
  const MedicationStatusPage({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return OnboardingScaffold(
      title: l.medicationStatusTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceLg * 2),
          SlateOutlineButton(
            label: l.medicationNone,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => RecordWantsPage(state: state),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceMd),
          SlateOutlineButton(
            label: l.medicationNeed,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => MedicationAddPage(state: state),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
