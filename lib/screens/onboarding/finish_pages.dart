import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../widgets/apple_button.dart';
import '../home_shell.dart';
import 'onboarding_widgets.dart';

/// 45:206 饮食记录介绍：粉底大卡 + 说明文字 + 深粉「记录」按钮。
class DietIntroPage extends StatelessWidget {
  const DietIntroPage({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return OnboardingScaffold(
      title: l.dietIntroTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceLg),
          Container(
            padding: const EdgeInsets.all(AppDimens.cardPadding),
            decoration: const BoxDecoration(
              color: AppColors.pink,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimens.radiusSheet),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.dietIntroTitle,
                  style: textTheme.displayMedium
                      ?.copyWith(color: AppColors.bgCard),
                ),
                const SizedBox(height: AppDimens.spaceMd),
                Text(
                  l.dietIntroBody,
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColors.bgCard),
                ),
                const SizedBox(height: AppDimens.spaceLg),
                Center(
                  child: WarmCtaButton(
                    label: l.dietIntroCta,
                    color: AppColors.accent,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => PermissionsPage(state: state),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimens.spaceSm),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 51:48 权限页：四行开关 + 粉色通栏 CTA。
class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    final items = <(String, String, IconData)>[
      (
        l.permissionsNameNotifications,
        l.permissionsNoteNotifications,
        CupertinoIcons.bell_fill,
      ),
      (
        l.permissionsNameCamera,
        l.permissionsNoteCamera,
        CupertinoIcons.camera_fill,
      ),
      (
        l.permissionsNameHealth,
        l.permissionsNoteHealth,
        CupertinoIcons.heart_fill,
      ),
      (
        l.permissionsNameBluetooth,
        l.permissionsNoteBluetooth,
        CupertinoIcons.bluetooth,
      ),
    ];
    return OnboardingScaffold(
      title: l.permissionsTitle,
      subtitle: l.permissionsSubtitle,
      bottom: Column(
        children: [
          WarmCtaButton(
            label: l.permissionsAllCta,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => SetupCompletePage(state: state),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceXs),
          Center(
            child: Text(l.permissionsFootnote,
                style: textTheme.bodyMedium),
          ),
        ],
      ),
      child: ListenableBuilder(
        listenable: state,
        builder: (context, _) => Column(
          children: [
            for (final (name, note, icon) in items)
              _PermissionRow(
                name: name,
                note: note,
                icon: icon,
                value: state.permissions[name] ?? false,
                onTap: () => state.togglePermission(name),
              ),
          ],
        ),
      ),
    );
  }
}

class _PermissionRow extends StatelessWidget {
  const _PermissionRow({
    required this.name,
    required this.note,
    required this.icon,
    required this.value,
    required this.onTap,
  });

  final String name;
  final String note;
  final IconData icon;
  final bool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.spaceSm),
      child: Pressable(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: AppDimens.buttonHeight),
          decoration: const BoxDecoration(
            color: AppColors.cardSoft,
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimens.radiusCard),
            ),
          ),
          padding: const EdgeInsets.all(AppDimens.spaceSm),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.iconSoftBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.accent),
              ),
              const SizedBox(width: AppDimens.spaceSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: textTheme.titleMedium),
                    Text(note, style: textTheme.bodyMedium),
                  ],
                ),
              ),
              // iOS 风格开关：mauve 轨道 + 白色圆钮
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 56,
                height: 32,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: value ? AppColors.mauve : AppColors.divider,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppDimens.radiusPill),
                  ),
                ),
                alignment:
                    value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.bgCard,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 56:48 设置完成：桃粉圆底对勾 badge + 大标题 + 今日提醒一览 + CTA。
class SetupCompletePage extends StatelessWidget {
  const SetupCompletePage({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    final medName = state.medications.isEmpty
        ? l.medicationDefaultName
        : state.medications.first.name;
    final reminders = <(String, String)>[
      ('08:00', l.setupReminderMed(medName)),
      ('08:30', l.setupReminderBp),
      ('12:00', l.setupReminderLunch),
      (l.setupReminderAllDay, l.setupReminderSteps(state.stepGoal)),
    ];
    return OnboardingScaffold(
      showBack: false,
      bottom: WarmCtaButton(
        label: l.setupCompleteCta,
        color: AppColors.accent,
        onTap: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (_) => HomeShell(state: state),
          ),
          (route) => false,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceMd),
          Center(
            child: Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: AppColors.accentSoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.checkmark,
                size: AppDimens.iconLarge,
                color: AppColors.accent,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceMd),
          Center(
            child: Text(l.setupCompleteTitle, style: textTheme.displayMedium),
          ),
          const SizedBox(height: AppDimens.spaceLg),
          Text(
            l.setupRemindersHeading,
            style: textTheme.titleMedium?.copyWith(color: AppColors.slate),
          ),
          const SizedBox(height: AppDimens.spaceSm),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimens.radiusCard),
              ),
            ),
            padding: const EdgeInsets.all(AppDimens.spaceSm),
            child: Column(
              children: [
                for (var i = 0; i < reminders.length; i++) ...[
                  Row(
                    children: [
                      SizedBox(
                        width: 72,
                        child: Text(
                          reminders[i].$1,
                          style: textTheme.titleMedium
                              ?.copyWith(color: AppColors.slate),
                        ),
                      ),
                      const SizedBox(width: AppDimens.spaceSm),
                      Expanded(
                        child: Text(
                          reminders[i].$2,
                          style: textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  if (i != reminders.length - 1)
                    const Divider(height: AppDimens.spaceMd),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}