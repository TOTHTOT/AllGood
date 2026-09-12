/// 用药详情页（48:2）：药名 + 「一日□次 一次□粒」步进 + 相机图标 + 右下对勾确认。
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../state/app_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_dimens.dart';
import '../../../widgets/apple_button.dart';
import '../../../widgets/number_stepper.dart';
import '../onboarding_widgets.dart';

/// 48:2 用药详情：药名 + 「一日□次 一次□粒」步进 + 相机图标 + 右下对勾确认。
class MedicationDetailPage extends StatefulWidget {
  const MedicationDetailPage({super.key, required this.state});

  final AppState state;

  @override
  State<MedicationDetailPage> createState() => _MedicationDetailPageState();
}

class _MedicationDetailPageState extends State<MedicationDetailPage> {
  final _nameController = TextEditingController();
  int _timesPerDay = 1;
  int _pillsEach = 1;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    final l = AppLocalizations.of(context);
    widget.state.addMedication(
      Medication(
        name: _nameController.text.trim().isEmpty
            ? l.medicationDefaultName
            : _nameController.text.trim(),
        timesPerDay: _timesPerDay,
        pillsEach: _pillsEach,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return OnboardingScaffold(
      title: l.medicationDetailTitle,
      bottom: WarmCtaButton(
        label: l.saveButton,
        color: AppColors.accent,
        onTap: _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceLg),
          Container(
            padding: const EdgeInsets.all(AppDimens.cardPadding),
            decoration: const BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimens.radiusCard),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.camera_fill,
                      size: AppDimens.iconLarge,
                      color: AppColors.pink,
                    ),
                    const SizedBox(width: AppDimens.spaceSm),
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        style: textTheme.titleMedium
                            ?.copyWith(color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          hintText: l.medicationNameHint,
                          hintStyle: textTheme.titleMedium
                              ?.copyWith(color: AppColors.textTertiary),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.spaceSm),
                const Divider(),
                const SizedBox(height: AppDimens.spaceSm),
                NumberStepper(
                  label: l.medicationTimesLabel,
                  valueText: '$_timesPerDay',
                  unit: l.medicationTimesUnit,
                  onDecrease: () => setState(() {
                    if (_timesPerDay > 1) _timesPerDay--;
                  }),
                  onIncrease: () => setState(() {
                    if (_timesPerDay < 6) _timesPerDay++;
                  }),
                ),
                const SizedBox(height: AppDimens.spaceSm),
                NumberStepper(
                  label: l.medicationPillsLabel,
                  valueText: '$_pillsEach',
                  unit: l.medicationPillsUnit,
                  onDecrease: () => setState(() {
                    if (_pillsEach > 1) _pillsEach--;
                  }),
                  onIncrease: () => setState(() {
                    if (_pillsEach < 10) _pillsEach++;
                  }),
                ),
                const SizedBox(height: AppDimens.spaceSm),
                Align(
                  alignment: Alignment.centerRight,
                  child: Pressable(
                    onTap: _save,
                    child: Container(
                      width: AppDimens.touchMin,
                      height: AppDimens.touchMin,
                      decoration: const BoxDecoration(
                        color: AppColors.accentSoft,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.checkmark,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
