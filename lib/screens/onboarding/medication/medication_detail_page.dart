/// 用药详情页（Figma 206:131）：浅紫大卡内录入药名（+ 深紫勾选图标）、
/// 左侧白色相机图标、右侧「一日 □ 次 / 一次 □ 粒」奶油小方框，
/// 下方每次服药的紫色时间块（大时间 + 勾选 + 删除），卡底「+」加时间。
/// 底部描边「确定」大卡进入餐前/餐后页。
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
import 'medication_meal_page.dart';

/// 206:131 用药详情：药名 + 一日/一次数值框 + 服药时间块列表。
class MedicationDetailPage extends StatefulWidget {
  const MedicationDetailPage({super.key, required this.state});

  final AppState state;

  @override
  State<MedicationDetailPage> createState() => _MedicationDetailPageState();
}

class _MedicationDetailPageState extends State<MedicationDetailPage> {
  /// 新增服药时间时按序补位的默认时间。
  static const List<String> _defaultTimes = [
    '08:00',
    '12:00',
    '18:00',
    '21:00',
    '07:00',
    '22:00',
  ];

  final _nameController = TextEditingController();
  String _pillsText = '1';
  List<String> _doseTimes = ['08:00'];

  int get _pillsEach => int.tryParse(_pillsText) ?? 1;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addDose() => setState(() {
    if (_doseTimes.length < _defaultTimes.length) {
      _doseTimes = [..._doseTimes, _defaultTimes[_doseTimes.length]];
    }
  });

  void _removeDose(int index) => setState(() {
    if (_doseTimes.length > 1) _doseTimes.removeAt(index);
  });

  Future<void> _pickDoseTime(int index) async {
    final l = AppLocalizations.of(context);
    final parts = _doseTimes[index].split(':');
    var picked = DateTime(2024, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 216,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: picked,
                  use24hFormat: true,
                  onDateTimeChanged: (value) => picked = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDimens.spaceSm),
                child: SizedBox(
                  width: double.infinity,
                  height: AppDimens.touchMin,
                  child: CupertinoButton(
                    color: AppColors.purple,
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(sheetContext).pop(),
                    child: Text(l.medicationConfirmLabel),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (!mounted) return;
    setState(() {
      _doseTimes[index] =
          '${picked.hour.toString().padLeft(2, '0')}:'
          '${picked.minute.toString().padLeft(2, '0')}';
    });
  }

  void _confirm() {
    final l = AppLocalizations.of(context);
    final name = _nameController.text.trim().isEmpty
        ? l.medicationDefaultName
        : _nameController.text.trim();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MedicationMealPage(
          state: widget.state,
          name: name,
          timesPerDay: _doseTimes.length,
          pillsEach: _pillsEach,
          doseTimes: _doseTimes,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    final cream = textTheme.titleLarge?.copyWith(color: AppColors.bgPage);
    return OnboardingScaffold(
      title: null,
      showBack: false,
      scroll: false,
      bottom: MedicationConfirmCard(
        label: l.medicationConfirmLabel,
        onTap: _confirm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceSm),
          PurpleTopBar(title: l.medicationStatusTitle),
          const SizedBox(height: AppDimens.spaceMd),
          // Figma 原稿大卡纵向撑满（y:120→706），内容超高时卡内滚动。
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.purpleSoft,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimens.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                // 药名行：无边框输入 + 右侧深紫勾选图标（206:131 卡内顶部）
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        style: cream,
                        decoration: InputDecoration(
                          hintText: l.medicationNameHint,
                          hintStyle: cream,
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.spaceSm),
                    const Icon(
                      CupertinoIcons.checkmark_square_fill,
                      color: AppColors.purpleDeep,
                      size: AppDimens.iconLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.spaceMd),
                // 左：白色大相机图标（拍照识别未开放）；右：一日□次 / 一次□粒
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Pressable(
                      onTap: () => showIosToast(
                        context,
                        l.medicationPhotoUnavailable,
                      ),
                      child: const Icon(
                        CupertinoIcons.camera_fill,
                        size: 88,
                        color: AppColors.bgCard,
                      ),
                    ),
                    const SizedBox(width: AppDimens.spaceMd),
                    Expanded(
                      child: Column(
                        children: [
                          _NumberRow(
                            label: l.medicationPerDay,
                            value: '${_doseTimes.length}',
                            unit: l.medicationTimesUnit,
                          ),
                          const SizedBox(height: AppDimens.spaceSm),
                          _NumberRow(
                            label: l.medicationPerTime,
                            value: _pillsText,
                            unit: l.medicationPillsUnit,
                            onChanged: (v) => setState(() => _pillsText = v),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.spaceMd),
                // 服药时间块（206:131 大紫块：大时间 + 勾选 + 第n次n粒 + 删除）
                for (var i = 0; i < _doseTimes.length; i++) ...[
                  _DoseTimeBlock(
                    index: i,
                    pills: _pillsEach,
                    time: _doseTimes[i],
                    onPickTime: () => _pickDoseTime(i),
                    onDelete: () => _removeDose(i),
                  ),
                  if (i < _doseTimes.length - 1)
                    const SizedBox(height: AppDimens.spaceSm),
                ],
                const SizedBox(height: AppDimens.spaceSm),
                // 卡底：紫色「+」加时间块 + 白色删除（删最后一条）
                Row(
                  children: [
                    Expanded(
                      child: Pressable(
                        onTap: _addDose,
                        child: Container(
                          height: AppDimens.touchMin,
                          decoration: const BoxDecoration(
                            color: AppColors.purple,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: const Icon(
                            CupertinoIcons.add,
                            size: 40,
                            color: AppColors.purplePale,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.spaceSm),
                    Pressable(
                      onTap: () => _removeDose(_doseTimes.length - 1),
                      child: const Padding(
                        padding: EdgeInsets.all(AppDimens.spaceXs),
                        child: Icon(
                          CupertinoIcons.delete,
                          size: 32,
                          color: AppColors.bgCard,
                        ),
                      ),
                    ),
                  ],
                ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 「一日 □ 次」数值行：斜体奶油标签 + 奶油小方框数字 + 单位（Figma 206:131）。
/// onChanged 为 null 时数字框只读。
class _NumberRow extends StatelessWidget {
  const _NumberRow({
    required this.label,
    required this.value,
    required this.unit,
    this.onChanged,
  });

  final String label;
  final String value;
  final String unit;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.titleLarge?.copyWith(color: AppColors.bgPage);
    final valueStyle = textTheme.titleLarge?.copyWith(color: AppColors.purple);
    return Row(
      children: [
        Text(label, style: labelStyle),
        const Spacer(),
        Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
            color: AppColors.bgPage,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: onChanged == null
              ? Center(child: Text(value, style: valueStyle))
              : TextFormField(
                  initialValue: value,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: onChanged,
                  style: valueStyle,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
        ),
        const SizedBox(width: AppDimens.spaceXs),
        Text(unit, style: labelStyle),
      ],
    );
  }
}

/// 服药时间块（Figma 206:131 紫块）：左侧大时间（点击改时间）+ 右上粉勾选，
/// 下方「第 □ 次 □ 粒」（数字带奶油小方框）+ 右侧白色删除。
class _DoseTimeBlock extends StatelessWidget {
  const _DoseTimeBlock({
    required this.index,
    required this.pills,
    required this.time,
    required this.onPickTime,
    required this.onDelete,
  });

  final int index;
  final int pills;
  final String time;
  final VoidCallback onPickTime;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    final labelStyle = textTheme.titleMedium?.copyWith(color: AppColors.bgPage);
    return Container(
      padding: const EdgeInsets.all(AppDimens.spaceSm),
      decoration: const BoxDecoration(
        color: AppColors.purple,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Pressable(
                  onTap: onPickTime,
                  child: Text(
                    time,
                    style: textTheme.displayMedium?.copyWith(
                      fontSize: 44,
                      color: AppColors.bgPage,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              const Icon(
                CupertinoIcons.checkmark_square_fill,
                color: AppColors.accentSoft,
                size: AppDimens.iconLarge,
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spaceXs),
          Row(
            children: [
              Text(l.medicationDosePrefix, style: labelStyle),
              const SizedBox(width: AppDimens.spaceXs),
              _MiniBox(text: '${index + 1}'),
              const SizedBox(width: AppDimens.spaceXs),
              Text(l.medicationTimesUnit, style: labelStyle),
              const SizedBox(width: AppDimens.spaceSm),
              _MiniBox(text: '$pills'),
              const SizedBox(width: AppDimens.spaceXs),
              Text(l.medicationPillsUnit, style: labelStyle),
              const Spacer(),
              Pressable(
                onTap: onDelete,
                child: const Padding(
                  padding: EdgeInsets.all(AppDimens.spaceXs),
                  child: Icon(
                    CupertinoIcons.delete,
                    size: 24,
                    color: AppColors.bgCard,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 时间块内数字的奶油小方框（Figma 206:131「第 □ 次 □ 粒」）。
class _MiniBox extends StatelessWidget {
  const _MiniBox({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: AppColors.bgPage,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColors.purple),
        ),
      ),
    );
  }
}
