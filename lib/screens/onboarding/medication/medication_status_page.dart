/// 用药状况页（44:181）：两个紫色描边大按钮，选择「不需要用药」或「需要用药」。
library;

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../state/app_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_dimens.dart';
import '../../../widgets/apple_button.dart';
import '../onboarding_widgets.dart';
import '../record_wants_page.dart';
import 'medication_add_page.dart';

/// 44:181 用药状况：两个紫色描边大按钮。
class MedicationStatusPage extends StatelessWidget {
  const MedicationStatusPage({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return OnboardingScaffold(
      title: l.medicationStatusTitle,
      titleColor: AppColors.purple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceLg * 2),
          _PurpleOutlineButton(
            label: l.medicationNone,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => RecordWantsPage(state: state),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceMd),
          _PurpleOutlineButton(
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

/// 紫色描边按钮（44:181：宽 245、高 69、3px 紫描边、24px 紫字）。
class _PurpleOutlineButton extends StatelessWidget {
  const _PurpleOutlineButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Pressable(
        onTap: onTap,
        child: Container(
          width: 245,
          height: 69,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.purple, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 24,
                color: AppColors.purple,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
