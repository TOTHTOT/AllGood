import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../widgets/apple_button.dart';
import '../../widgets/ios_toast.dart';
import '../../widgets/number_stepper.dart';
import 'onboarding_widgets.dart';
import 'record_wants_page.dart';

/// 44:181 用药状况：两个描边大按钮。
class MedicationStatusPage extends StatelessWidget {
  const MedicationStatusPage({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      title: '用药状况',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceLg * 2),
          SlateOutlineButton(
            label: '我没有用药',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => RecordWantsPage(state: state),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceMd),
          SlateOutlineButton(
            label: '我需要用药',
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
    return OnboardingScaffold(
      title: '用药状况',
      bottom: WarmCtaButton(
        label: '继续',
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
              // 粉底相机卡（45:273：左侧大号玫瑰相机图标 + 右侧米白文字）
              // 拍照识别暂未实现，点击仅提示，手动添加走下方「+」卡。
              Pressable(
                onTap: () => showIosToast(
                  context,
                  '拍照识别暂未开放，请用 + 添加',
                ),
                child: Container(
                  height: 192,
                  decoration: const BoxDecoration(
                    color: AppColors.pink,
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
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: AppDimens.spaceLg),
                      Text(
                        '点击添加',
                        style: textTheme.headlineMedium
                            ?.copyWith(color: AppColors.bgPage),
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
                      color: AppColors.strokeGray,
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
                      color: AppColors.pink,
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
              '${med.name} · 一日 ${med.timesPerDay} 次 · 一次 ${med.pillsEach} 粒',
              style: textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

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
    widget.state.addMedication(
      Medication(
        name: _nameController.text.trim().isEmpty
            ? '降压药'
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
    return OnboardingScaffold(
      title: '用药详情',
      bottom: WarmCtaButton(
        label: '保存',
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
                          hintText: '点击输入药名',
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
                  label: '一日几次',
                  valueText: '$_timesPerDay',
                  unit: '次',
                  onDecrease: () => setState(() {
                    if (_timesPerDay > 1) _timesPerDay--;
                  }),
                  onIncrease: () => setState(() {
                    if (_timesPerDay < 6) _timesPerDay++;
                  }),
                ),
                const SizedBox(height: AppDimens.spaceSm),
                NumberStepper(
                  label: '一次几粒',
                  valueText: '$_pillsEach',
                  unit: '粒',
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
