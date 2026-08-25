/// 血压卡片内容：提醒值「高于 高压□ 低压□」+ 桃色「添加」按钮。
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../state/app_state.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_dimens.dart';
import '../../../widgets/apple_button.dart';
import '../../../widgets/ios_toast.dart';

/// 45:237 血压展开：提醒值「高于 高压□ 低压□」+ 桃色「添加」按钮。
class BloodPressureCard extends StatefulWidget {
  const BloodPressureCard({super.key, required this.state});

  final AppState state;

  @override
  State<BloodPressureCard> createState() => _BloodPressureCardState();
}

class _BloodPressureCardState extends State<BloodPressureCard> {
  late final TextEditingController _systolic = TextEditingController(
    text: '${widget.state.bpAlertSystolic}',
  );
  late final TextEditingController _diastolic = TextEditingController(
    text: '${widget.state.bpAlertDiastolic}',
  );

  @override
  void dispose() {
    _systolic.dispose();
    _diastolic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    final labelStyle = textTheme.headlineMedium?.copyWith(
      color: AppColors.bgCard,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l.bpCardTitle,
          style: textTheme.titleLarge?.copyWith(color: AppColors.bgCard),
        ),
        const SizedBox(height: AppDimens.spaceXs),
        // 「高于🔁」居中，点击切换 高于/低于。
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l.bpCardAbove,
              style: textTheme.bodyLarge?.copyWith(color: AppColors.bgCard),
            ),
            const SizedBox(width: AppDimens.spaceXs),
            const Icon(
              CupertinoIcons.repeat,
              color: AppColors.bgCard,
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: AppDimens.spaceXs),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l.bpCardSystolic, style: labelStyle),
            const SizedBox(width: AppDimens.spaceMd),
            _WhiteInput(controller: _systolic),
          ],
        ),
        const SizedBox(height: AppDimens.spaceSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l.bpCardDiastolic, style: labelStyle),
            const SizedBox(width: AppDimens.spaceMd),
            _WhiteInput(controller: _diastolic),
          ],
        ),
        const SizedBox(height: AppDimens.spaceSm),
        // Figma 49:21：桃色按钮宽约卡片的 68%，居中。
        FractionallySizedBox(
          widthFactor: 0.68,
          child: Pressable(
            onTap: () {
              widget.state.setBpAlert(
                int.tryParse(_systolic.text) ?? 140,
                int.tryParse(_diastolic.text) ?? 90,
              );
              showIosToast(context, l.bpCardAddedToast);
            },
            child: Container(
              constraints: const BoxConstraints(minHeight: AppDimens.touchMin),
              decoration: const BoxDecoration(
                color: AppColors.accentSoft,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimens.radiusTag),
                ),
              ),
              child: Center(
                child: Text(
                  l.bpCardAdd,
                  style: textTheme.titleLarge?.copyWith(color: AppColors.slate),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 45:237 白色数值输入框（95x45 圆角 8 → 适老放大到 56 高、110 宽）。
class _WhiteInput extends StatelessWidget {
  const _WhiteInput({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 110,
      height: AppDimens.touchMin,
      decoration: const BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.radiusTag)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spaceXs),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: textTheme.titleLarge?.copyWith(color: AppColors.slate),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}