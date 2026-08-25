import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../widgets/apple_button.dart';
import '../widgets/gentle_banner.dart';
import '../widgets/ios_toast.dart';

/// Tab 3「家人」：子女 / 照护者视角。
class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key, required this.state});

  final AppState state;

  String _nameFor(AppLocalizations l, CheckInType type) {
    switch (type) {
      case CheckInType.medication:
        return l.checkInMedication;
      case CheckInType.bloodPressure:
        return l.checkInBloodPressure;
      case CheckInType.bloodSugar:
        return l.checkInBloodSugar;
      case CheckInType.diet:
        return l.checkInDiet;
      case CheckInType.exercise:
        return l.checkInExercise;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final textTheme = Theme.of(context).textTheme;
        final l = AppLocalizations.of(context);
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppDimens.pagePadding),
            children: [
              Text(l.tabFamily, style: textTheme.displayMedium),
              const SizedBox(height: AppDimens.spaceXs),
              Text(
                l.familyWatching(state.displayName),
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: AppDimens.spaceMd),
              GentleBanner(
                icon: CupertinoIcons.chat_bubble_2_fill,
                text: l.familyReminder(state.displayName),
              ),
              const SizedBox(height: AppDimens.cardGap),
              _buildTodayStatus(context, l),
              const SizedBox(height: AppDimens.cardGap),
              _buildWeeklyReport(context, l),
              const SizedBox(height: AppDimens.spaceMd),
              AppleTintedButton(
                label: l.exportButton,
                icon: CupertinoIcons.square_arrow_up,
                onPressed: () =>
                    showIosToast(context, l.exportDemoUnavailable),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTodayStatus(BuildContext context, AppLocalizations l) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.familyTodayHeading, style: textTheme.headlineMedium),
            const SizedBox(height: AppDimens.spaceSm),
            for (final record in state.records) ...[
              Row(
                children: [
                  Icon(
                    record.done
                        ? CupertinoIcons.checkmark_circle_fill
                        : CupertinoIcons.circle,
                    color:
                        record.done ? AppColors.ok : AppColors.textTertiary,
                  ),
                  const SizedBox(width: AppDimens.spaceSm),
                  Expanded(
                    child: Text(
                      _nameFor(l, record.type),
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    record.done ? l.statusDone : l.statusPending,
                    style: textTheme.bodyMedium?.copyWith(
                      color: record.done
                          ? AppColors.ok
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              if (record != state.records.last)
                const SizedBox(height: AppDimens.spaceSm),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyReport(BuildContext context, AppLocalizations l) {
    final textTheme = Theme.of(context).textTheme;
    final rows = [
      (CupertinoIcons.checkmark_square_fill, l.weeklyAdherence),
      (CupertinoIcons.heart_fill, l.weeklyBp),
      (CupertinoIcons.drop_fill, l.weeklyGlucose),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.familyWeeklyHeading, style: textTheme.headlineMedium),
            const SizedBox(height: AppDimens.spaceSm),
            for (final (icon, text) in rows) ...[
              Row(
                children: [
                  Icon(icon, color: AppColors.accent),
                  const SizedBox(width: AppDimens.spaceSm),
                  Expanded(
                    child: Text(text, style: textTheme.bodyLarge),
                  ),
                ],
              ),
              if ((icon, text) != rows.last)
                const SizedBox(height: AppDimens.spaceSm),
            ],
          ],
        ),
      ),
    );
  }
}
