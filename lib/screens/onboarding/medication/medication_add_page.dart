/// 用药添加页（45:273）：已添加药品列表 + 粉底相机卡「点击添加」+「+」手动添加卡。
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../state/app_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_dimens.dart';
import '../../../widgets/apple_button.dart';
import '../../../widgets/ios_toast.dart';
import '../onboarding_widgets.dart';
import '../record_wants_page.dart';
import 'medication_detail_page.dart';

/// 45:273 用药添加：粉底相机卡「点击添加」+ 下方「+」添加卡。
class MedicationAddPage extends StatelessWidget {
  const MedicationAddPage({super.key, required this.state});

  final AppState state;

  Future<void> _addMedication(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MedicationDetailPage(state: state),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return OnboardingScaffold(
      title: l.medicationStatusTitle,
      titleColor: AppColors.purple,
      bottom: WarmCtaButton(
        label: l.continueButton,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => RecordWantsPage(state: state),
          ),
        ),
      ),
      child: ListenableBuilder(
        listenable: state,
        builder: (context, _) {
          final textTheme = Theme.of(context).textTheme;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppDimens.spaceLg),
              for (final med in state.medications) ...[
                _MedicationCard(med: med),
                const SizedBox(height: AppDimens.spaceSm),
              ],
              // 浅紫底相机卡（45:273 换肤：紫色系）
              // 拍照识别暂未实现，点击仅提示，手动添加走下方「+」卡。
              Pressable(
                onTap: () => showIosToast(
                  context,
                  l.medicationPhotoUnavailable,
                ),
                child: Container(
                  height: 192,
                  decoration: const BoxDecoration(
                    color: AppColors.purpleSoft,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimens.radiusCard),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.spaceLg,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.camera_fill,
                        size: 88,
                        color: AppColors.lavenderIcon,
                      ),
                      const SizedBox(width: AppDimens.spaceLg),
                      Text(
                        l.medicationTapToAdd,
                        style: textTheme.headlineMedium?.copyWith(
                          color: AppColors.bgPage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.spaceSm),
              // 「+」手动添加卡
              Pressable(
                onTap: () => _addMedication(context),
                child: Container(
                  constraints:
                      const BoxConstraints(minHeight: AppDimens.touchMin),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.purpleStroke,
                      width: 3,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppDimens.radiusCard),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.add,
                      size: 48,
                      color: AppColors.purplePale,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MedicationCard extends StatelessWidget {
  const _MedicationCard({required this.med});

  final Medication med;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppDimens.spaceSm),
      decoration: const BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.radiusCard)),
      ),
      child: Row(
        children: [
          const Icon(CupertinoIcons.staroflife_fill,
              color: AppColors.accent, size: AppDimens.iconLarge),
          const SizedBox(width: AppDimens.spaceSm),
          Expanded(
            child: Text(
              l.medicationCardSummary(med.name, med.timesPerDay, med.pillsEach),
              style: textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
