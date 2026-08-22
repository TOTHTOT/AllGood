import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import 'medication_pages.dart';
import 'onboarding_widgets.dart';

/// 42:149 信息表单：「帮他人设置/自己设置」+ 姓名/年龄/性别描边输入项。
class InfoFormPage extends StatefulWidget {
  const InfoFormPage({super.key, required this.state, required this.byHelper});

  final AppState state;
  final bool byHelper;

  @override
  State<InfoFormPage> createState() => _InfoFormPageState();
}

class _InfoFormPageState extends State<InfoFormPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String _gender = '女';

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _next() {
    widget.state.saveProfile(
      name: _nameController.text.trim(),
      age: _ageController.text.trim(),
      gender: _gender,
      byHelper: widget.byHelper,
    );
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MedicationStatusPage(state: widget.state),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      title: widget.byHelper ? '帮他人设置' : '自己设置',
      bottom: WarmCtaButton(label: '继续', onTap: _next),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceLg),
          _OutlineField(
            controller: _nameController,
            hint: '姓名',
          ),
          const SizedBox(height: AppDimens.spaceSm),
          _OutlineField(
            controller: _ageController,
            hint: '年龄',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppDimens.spaceSm),
          _GenderPicker(
            value: _gender,
            onChanged: (value) => setState(() => _gender = value),
          ),
        ],
      ),
    );
  }
}

/// Figma 描边输入框：#A5C5DE 描边，圆角按 token 下限。
class _OutlineField extends StatelessWidget {
  const _OutlineField({
    required this.controller,
    required this.hint,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      constraints: const BoxConstraints(minHeight: AppDimens.buttonHeight),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.outlineBlue, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimens.radiusTag),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spaceSm),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: textTheme.titleMedium?.copyWith(color: AppColors.slate),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: textTheme.titleMedium?.copyWith(color: AppColors.slate),
        ),
      ),
    );
  }
}

/// 性别选择：两个大号选项（适老，避免小键盘）。
class _GenderPicker extends StatelessWidget {
  const _GenderPicker({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        for (final gender in ['女', '男']) ...[
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(gender),
              child: Container(
                constraints:
                    const BoxConstraints(minHeight: AppDimens.buttonHeight),
                decoration: BoxDecoration(
                  color: gender == value
                      ? AppColors.accentSoft
                      : AppColors.bgCard,
                  border: Border.all(color: AppColors.outlineBlue, width: 2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppDimens.radiusTag),
                  ),
                ),
                child: Center(
                  child: Text(
                    gender,
                    style: textTheme.titleMedium?.copyWith(
                      color: gender == value
                          ? AppColors.accent
                          : AppColors.slate,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (gender != '男') const SizedBox(width: AppDimens.spaceSm),
        ],
      ],
    );
  }
}
