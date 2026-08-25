import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import 'apple_button.dart';
import 'number_stepper.dart';

/// 数据录入弹层：iOS sheet 观感——顶部居中 grabber、白底、
/// 顶部圆角 16、高约屏 75%、底部固定 64 高 accent 胶囊主按钮。
///
/// 返回 true 表示本次完成了打卡，调用方据此给出正向反馈。
Future<bool?> showRecordSheet(
  BuildContext context,
  AppState state,
  CheckInType type,
) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    builder: (sheetContext) {
      final height = MediaQuery.of(sheetContext).size.height *
          AppDimens.sheetHeightFactor;
      return SizedBox(
        height: height,
        child: Padding(
          padding: EdgeInsets.only(
            left: AppDimens.cardPadding,
            right: AppDimens.cardPadding,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom +
                AppDimens.spaceMd,
          ),
          child: switch (type) {
            CheckInType.medication => _MedicationForm(state: state),
            CheckInType.bloodPressure => _BloodPressureForm(state: state),
            CheckInType.bloodSugar => _BloodSugarForm(state: state),
            CheckInType.diet => _DietForm(state: state),
            CheckInType.exercise => _ExerciseForm(state: state),
          },
        ),
      );
    },
  );
}

/// 弹层骨架：grabber + 标题（22pt 粗体左对齐）+ 可滚动内容 + 底部固定主按钮。
class _SheetScaffold extends StatelessWidget {
  const _SheetScaffold({
    required this.title,
    required this.content,
    required this.buttonLabel,
    required this.onSubmit,
  });

  final String title;
  final Widget content;
  final String buttonLabel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimens.spaceSm),
        Container(
          width: AppDimens.sheetHandleWidth,
          height: AppDimens.sheetHandleHeight,
          decoration: const BoxDecoration(
            color: AppColors.grabber,
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimens.radiusPill),
            ),
          ),
        ),
        const SizedBox(height: AppDimens.spaceMd),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: AppDimens.spaceMd),
        Expanded(child: SingleChildScrollView(child: content)),
        const SizedBox(height: AppDimens.spaceSm),
        AppleButton(label: buttonLabel, onPressed: onSubmit),
      ],
    );
  }
}

/// 用药：一句话确认 + 大按钮「已吃药」。
class _MedicationForm extends StatelessWidget {
  const _MedicationForm({required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return _SheetScaffold(
      title: l.medicationSheetTitle,
      buttonLabel: l.medicationConfirm,
      onSubmit: () {
        state.complete(CheckInType.medication, l.medicationSummary);
        Navigator.of(context).pop(true);
      },
      content: Column(
        children: [
          const SizedBox(height: AppDimens.spaceMd),
          const Icon(
            CupertinoIcons.staroflife_fill,
            size: AppDimens.iconLarge * 2,
            color: AppColors.accent,
          ),
          const SizedBox(height: AppDimens.spaceMd),
          Text(
            l.medicationSheetHint,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spaceLg),
        ],
      ),
    );
  }
}

/// 血压：高压 / 低压两个大数字步进器，超范围时温和提示。
class _BloodPressureForm extends StatefulWidget {
  const _BloodPressureForm({required this.state});

  final AppState state;

  @override
  State<_BloodPressureForm> createState() => _BloodPressureFormState();
}

class _BloodPressureFormState extends State<_BloodPressureForm> {
  int _systolic = 120;
  int _diastolic = 80;

  bool get _abnormal =>
      AppState.isSystolicAbnormal(_systolic.toDouble()) ||
      AppState.isDiastolicAbnormal(_diastolic.toDouble());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return _SheetScaffold(
      title: l.bpSheetTitle,
      buttonLabel: l.bpSheetSubmit,
      onSubmit: () {
        widget.state.complete(
          CheckInType.bloodPressure,
          l.bpSummary(_systolic, _diastolic),
          abnormal: _abnormal,
        );
        Navigator.of(context).pop(true);
      },
      content: Column(
        children: [
          NumberStepper(
            label: l.bpSystolicLabel,
            valueText: '$_systolic',
            unit: 'mmHg',
            onDecrease: () => setState(() {
              if (_systolic > 60) _systolic--;
            }),
            onIncrease: () => setState(() {
              if (_systolic < 220) _systolic++;
            }),
          ),
          const SizedBox(height: AppDimens.spaceMd),
          NumberStepper(
            label: l.bpDiastolicLabel,
            valueText: '$_diastolic',
            unit: 'mmHg',
            onDecrease: () => setState(() {
              if (_diastolic > 40) _diastolic--;
            }),
            onIncrease: () => setState(() {
              if (_diastolic < 130) _diastolic++;
            }),
          ),
          if (_abnormal) ...[
            const SizedBox(height: AppDimens.spaceMd),
            Row(
              children: [
                const Icon(CupertinoIcons.heart_fill,
                    color: AppColors.warning),
                const SizedBox(width: AppDimens.spaceXs),
                Expanded(
                  child: Text(
                    l.bpAbnormalHint,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppDimens.spaceMd),
        ],
      ),
    );
  }
}

/// 血糖：先选餐次，再用步进器录数值（步进 0.1）。
class _BloodSugarForm extends StatefulWidget {
  const _BloodSugarForm({required this.state});

  final AppState state;

  @override
  State<_BloodSugarForm> createState() => _BloodSugarFormState();
}

class _BloodSugarFormState extends State<_BloodSugarForm> {
  late List<String> _meals;
  late String _meal;
  double _value = 5.6;

  bool get _abnormal => AppState.isGlucoseAbnormal(_value);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l = AppLocalizations.of(context);
    // Snapshot localized options when the locale changes; we still default
    // the selection to "after breakfast" / index 1.
    _meals = [
      l.sugarMealFasting,
      l.sugarMealAfterBreakfast,
      l.sugarMealAfterLunch,
      l.sugarMealAfterDinner,
    ];
    _meal = _meals.length > 1 ? _meals[1] : _meals.first;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return _SheetScaffold(
      title: l.sugarSheetTitle,
      buttonLabel: l.bpSheetSubmit,
      onSubmit: () {
        widget.state.complete(
          CheckInType.bloodSugar,
          l.sugarSummary(_meal, _value.toStringAsFixed(1)),
          abnormal: _abnormal,
        );
        Navigator.of(context).pop(true);
      },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.sugarMealQuestion, style: textTheme.titleMedium),
          const SizedBox(height: AppDimens.spaceSm),
          Wrap(
            spacing: AppDimens.spaceXs,
            runSpacing: AppDimens.spaceXs,
            children: [
              for (final meal in _meals)
                _SelectPill(
                  label: meal,
                  selected: meal == _meal,
                  onTap: () => setState(() => _meal = meal),
                ),
            ],
          ),
          const SizedBox(height: AppDimens.spaceMd),
          NumberStepper(
            label: l.sugarValueLabel,
            valueText: _value.toStringAsFixed(1),
            unit: 'mmol/L',
            onDecrease: () => setState(() {
              if (_value > 2.0) _value -= 0.1;
            }),
            onIncrease: () => setState(() {
              if (_value < 15.0) _value += 0.1;
            }),
          ),
          if (_abnormal) ...[
            const SizedBox(height: AppDimens.spaceMd),
            Text(
              l.sugarAbnormalHint,
              style: textTheme.bodyMedium
                  ?.copyWith(color: AppColors.textPrimary),
            ),
          ],
          const SizedBox(height: AppDimens.spaceMd),
        ],
      ),
    );
  }
}

/// iOS segmented 风格选择 pill（触控 ≥56）：
/// 未选中浅灰底深字，选中 accent 蓝底白字，全圆角。
class _SelectPill extends StatelessWidget {
  const _SelectPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Pressable(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppDimens.touchMin),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spaceMd,
          vertical: AppDimens.spaceXs,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.divider,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimens.radiusPill),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: textTheme.titleMedium?.copyWith(
              color: selected ? AppColors.bgCard : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

/// 饮食：拍照占位 + 糖分三选一。
class _DietForm extends StatefulWidget {
  const _DietForm({required this.state});

  final AppState state;

  @override
  State<_DietForm> createState() => _DietFormState();
}

class _DietFormState extends State<_DietForm> {
  late List<String> _sugarLevels;
  late String _sugar;
  bool _photoAdded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l = AppLocalizations.of(context);
    _sugarLevels = [
      l.dietSugarLow,
      l.dietSugarMedium,
      l.dietSugarHigh,
    ];
    _sugar = _sugarLevels.first;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return _SheetScaffold(
      title: l.dietSheetTitle,
      buttonLabel: l.dietSheetSubmit,
      onSubmit: () {
        widget.state.complete(CheckInType.diet, l.dietSummary(_sugar));
        Navigator.of(context).pop(true);
      },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _photoAdded
              ? Container(
                  constraints:
                      const BoxConstraints(minHeight: AppDimens.buttonHeight),
                  decoration: const BoxDecoration(
                    color: AppColors.bgPage,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimens.radiusInput),
                    ),
                  ),
                  padding: const EdgeInsets.all(AppDimens.spaceSm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.checkmark_circle_fill,
                          color: AppColors.ok),
                      const SizedBox(width: AppDimens.spaceXs),
                      Text(l.dietPhotoAdded, style: textTheme.titleMedium),
                    ],
                  ),
                )
              : AppleTintedButton(
                  label: l.dietTakePhoto,
                  icon: CupertinoIcons.camera_fill,
                  onPressed: () => setState(() => _photoAdded = true),
                ),
          const SizedBox(height: AppDimens.spaceMd),
          Text(l.dietSugarQuestion, style: textTheme.titleMedium),
          const SizedBox(height: AppDimens.spaceSm),
          Row(
            children: [
              for (final level in _sugarLevels) ...[
                Expanded(
                  child: _SelectPill(
                    label: level,
                    selected: level == _sugar,
                    onTap: () => setState(() => _sugar = level),
                  ),
                ),
                if (level != _sugarLevels.last)
                  const SizedBox(width: AppDimens.spaceXs),
              ],
            ],
          ),
          const SizedBox(height: AppDimens.spaceMd),
        ],
      ),
    );
  }
}

/// 运动：展示今日步数，点「同步步数」随机增加并完成打卡。
class _ExerciseForm extends StatelessWidget {
  const _ExerciseForm({required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return _SheetScaffold(
      title: l.exerciseSheetTitle,
      buttonLabel: l.exerciseSheetSubmit,
      onSubmit: () {
        state.syncSteps();
        Navigator.of(context).pop(true);
      },
      content: Column(
        children: [
          const SizedBox(height: AppDimens.spaceMd),
          Text(l.exerciseAlreadyWalked, style: textTheme.bodyLarge),
          const SizedBox(height: AppDimens.spaceXs),
          Text(
            '${state.steps}',
            style: textTheme.displayLarge,
          ),
          Text(l.exerciseStepsUnit, style: textTheme.bodySmall),
          const SizedBox(height: AppDimens.spaceMd),
          Text(
            l.exerciseHint,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spaceLg),
        ],
      ),
    );
  }
}