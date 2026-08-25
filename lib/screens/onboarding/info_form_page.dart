import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
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
  late List<String> _genders;
  late String _gender;

  @override
  void initState() {
    super.initState();
    // 默认选项的初值在 didChangeDependencies 里跟随 locale 重算。
    _genders = const [];
    _gender = '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l = AppLocalizations.of(context);
    _genders = [l.infoGenderFemale, l.infoGenderMale];
    if (!_genders.contains(_gender)) _gender = _genders.first;
  }

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
    final l = AppLocalizations.of(context);
    return OnboardingScaffold(
      title: widget.byHelper ? l.infoFormTitleHelper : l.infoFormTitleSelf,
      bottom: WarmCtaButton(label: l.continueButton, onTap: _next),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceLg),
          _OutlineField(
            controller: _nameController,
            hint: l.infoNameHint,
          ),
          const SizedBox(height: AppDimens.spaceSm),
          _OutlineField(
            controller: _ageController,
            hint: l.infoAgeHint,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppDimens.spaceSm),
          _GenderPicker(
            options: _genders,
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
  const _GenderPicker({
    required this.options,
    required this.value,
    required this.onChanged,
  });

  final List<String> options;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (options.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(options[i]),
              child: Container(
                constraints:
                    const BoxConstraints(minHeight: AppDimens.buttonHeight),
                decoration: BoxDecoration(
                  color: options[i] == value
                      ? AppColors.accentSoft
                      : AppColors.bgCard,
                  border: Border.all(color: AppColors.outlineBlue, width: 2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppDimens.radiusTag),
                  ),
                ),
                child: Center(
                  child: Text(
                    options[i],
                    style: textTheme.titleMedium?.copyWith(
                      color: options[i] == value
                          ? AppColors.accent
                          : AppColors.slate,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (i != options.length - 1) const SizedBox(width: AppDimens.spaceSm),
        ],
      ],
    );
  }
}