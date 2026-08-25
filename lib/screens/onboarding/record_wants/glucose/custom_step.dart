/// 血糖向导自定义目标步：空腹/餐后两组「最低/最高」数值输入与保存。
library;

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../state/app_state.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_dimens.dart';
import '../../../../widgets/apple_button.dart';
import '../../../../widgets/ios_toast.dart';
import 'glucose_wizard.dart';

/// 72:40 自定义目标步（卡内嵌版）：空腹/餐后两组「最低/最高」+ 深蓝「保存设置」。
/// 保存后返回目标步。（原稿两框之间的「低压🔁」字样明显是从血压卡复制错了，略去。）
class GlucoseCustomStep extends StatefulWidget {
  const GlucoseCustomStep({super.key, required this.state, required this.onStep});

  final AppState state;
  final ValueChanged<String> onStep;

  @override
  State<GlucoseCustomStep> createState() => _GlucoseCustomStepState();
}

class _GlucoseCustomStepState extends State<GlucoseCustomStep> {
  late final List<TextEditingController> _controllers = [
    TextEditingController(
      text: widget.state.glucoseFastingMin.toStringAsFixed(1),
    ),
    TextEditingController(
      text: widget.state.glucoseFastingMax.toStringAsFixed(1),
    ),
    TextEditingController(text: widget.state.glucosePostMin.toStringAsFixed(1)),
    TextEditingController(text: widget.state.glucosePostMax.toStringAsFixed(1)),
  ];

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    final l = AppLocalizations.of(context);
    final s = widget.state;
    s.glucoseFastingMin =
        double.tryParse(_controllers[0].text) ?? s.glucoseFastingMin;
    s.glucoseFastingMax =
        double.tryParse(_controllers[1].text) ?? s.glucoseFastingMax;
    s.glucosePostMin =
        double.tryParse(_controllers[2].text) ?? s.glucosePostMin;
    s.glucosePostMax =
        double.tryParse(_controllers[3].text) ?? s.glucosePostMax;
    showIosToast(context, l.sugarCustomSavedToast);
    widget.onStep('target');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StepHeader(l.sugarCustomTitle, l.sugarCustomHint),
        const SizedBox(height: AppDimens.spaceSm),
        _CustomGroup(
          label: l.sugarCustomFasting,
          note: l.sugarCustomFastingNote,
          minLabel: l.sugarCustomMinLabel,
          maxLabel: l.sugarCustomMaxLabel,
          minController: _controllers[0],
          maxController: _controllers[1],
        ),
        const SizedBox(height: AppDimens.spaceSm),
        _CustomGroup(
          label: l.sugarCustomPost,
          note: l.sugarCustomPostNote,
          minLabel: l.sugarCustomMinLabel,
          maxLabel: l.sugarCustomMaxLabel,
          minController: _controllers[2],
          maxController: _controllers[3],
        ),
        const SizedBox(height: AppDimens.spaceMd),
        Pressable(
          onTap: _save,
          child: Container(
            constraints: const BoxConstraints(minHeight: AppDimens.touchMin),
            decoration: const BoxDecoration(
              color: AppColors.deepBlue,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimens.radiusPill),
              ),
            ),
            child: Center(
              child: Text(
                l.sugarCustomSave,
                style: textTheme.titleLarge?.copyWith(color: AppColors.bgCard),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 72:40 白卡片：左上名称 + 右上说明，下面「最低□ 最高□」两个数值框。
class _CustomGroup extends StatelessWidget {
  const _CustomGroup({
    required this.label,
    required this.note,
    required this.minLabel,
    required this.maxLabel,
    required this.minController,
    required this.maxController,
  });

  final String label;
  final String note;
  final String minLabel;
  final String maxLabel;
  final TextEditingController minController;
  final TextEditingController maxController;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(AppDimens.spaceSm),
      decoration: const BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.radiusInput)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.deepBlue,
                ),
              ),
              const SizedBox(width: AppDimens.spaceSm),
              Expanded(
                child: Text(
                  note,
                  textAlign: TextAlign.right,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spaceXs),
          Row(
            children: [
              Expanded(
                child: _CustomInput(label: minLabel, controller: minController),
              ),
              const SizedBox(width: AppDimens.spaceSm),
              Expanded(
                child: _CustomInput(label: maxLabel, controller: maxController),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 72:40 数值框：#EBF5FF 底 + deepBlue 30% 描边，左上小标签 + 深蓝大字 + mmol/L。
class _CustomInput extends StatelessWidget {
  const _CustomInput({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        border: Border.all(color: AppColors.inputStroke),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimens.radiusInput - 4),
        ),
      ),
      padding: const EdgeInsets.all(AppDimens.spaceXs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.bodySmall),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium?.copyWith(
                    color: AppColors.deepBlue,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Text('mmol/L', style: textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}