import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return OnboardingScaffold(
      title: '饮食记录',
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
                  '饮食记录',
                  style: textTheme.displayMedium
                      ?.copyWith(color: AppColors.bgCard),
                ),
                const SizedBox(height: AppDimens.spaceMd),
                Text(
                  '每天拍照记录三餐，帮您和家人了解饮食与血糖的关系。',
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColors.bgCard),
                ),
                const SizedBox(height: AppDimens.spaceLg),
                Center(
                  child: WarmCtaButton(
                    label: '记录',
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

  static const List<(String, String, IconData)> _items = [
    ('通知', '到时提醒您吃药、量血压', CupertinoIcons.bell_fill),
    ('相机', '拍照记录饮食', CupertinoIcons.camera_fill),
    ('健康数据', '自动读取步数', CupertinoIcons.heart_fill),
    ('蓝牙', '连接血糖仪', CupertinoIcons.bluetooth),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return OnboardingScaffold(
      title: '需要您允许几项权限',
      subtitle: '开启后，才能为您提供完整的健康管理服务',
      bottom: Column(
        children: [
          WarmCtaButton(
            label: '全部允许并继续',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => SetupCompletePage(state: state),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceXs),
          Center(
            child: Text('之后也可在「设置」中随时更改',
                style: textTheme.bodyMedium),
          ),
        ],
      ),
      child: ListenableBuilder(
        listenable: state,
        builder: (context, _) => Column(
          children: [
            for (final (name, note, icon) in _items)
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

  static const List<(String, String)> _reminders = [
    ('08:00', '吃 XX 药 1 片（已设响铃）'),
    ('08:30', '测量血压（建议静止后测）'),
    ('12:00', '午餐拍照记录'),
    ('全天', '今日目标 6000 步'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return OnboardingScaffold(
      showBack: false,
      bottom: WarmCtaButton(
        label: '开始使用',
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
            child: Text('设置完成！', style: textTheme.displayMedium),
          ),
          const SizedBox(height: AppDimens.spaceLg),
          Text(
            '今日提醒一览',
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
                for (var i = 0; i < _reminders.length; i++) ...[
                  Row(
                    children: [
                      SizedBox(
                        width: 72,
                        child: Text(
                          _reminders[i].$1,
                          style: textTheme.titleMedium
                              ?.copyWith(color: AppColors.slate),
                        ),
                      ),
                      const SizedBox(width: AppDimens.spaceSm),
                      Expanded(
                        child: Text(
                          _reminders[i].$2,
                          style: textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  if (i != _reminders.length - 1)
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
