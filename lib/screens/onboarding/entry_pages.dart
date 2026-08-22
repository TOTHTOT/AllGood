import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../widgets/ios_toast.dart';
import 'info_form_page.dart';
import 'onboarding_widgets.dart';

/// 22:14 初始页：米色底 + 玫瑰大标题 + 浅蓝灰「都好！」按钮。
class InitialPage extends StatelessWidget {
  const InitialPage({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimens.spaceLg * 2),
              Center(
                child: Text(
                  '今天过得怎么样？',
                  style: textTheme.displayMedium
                      ?.copyWith(color: AppColors.accent),
                ),
              ),
              const Spacer(),
              Center(
                child: SoftBlueButton(
                  label: '都好！',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => LoginChoicePage(state: state),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

/// 45:213 登录选择：「我没有账号」/「登陆」两个大按钮。
class LoginChoicePage extends StatelessWidget {
  const LoginChoicePage({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      showBack: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceLg * 4),
          SoftBlueButton(
            label: '我没有账号',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => RegisterPage(state: state),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceMd),
          SoftBlueButton(
            label: '登陆',
            onTap: () => showIosToast(context, '演示版本请走注册流程'),
          ),
        ],
      ),
    );
  }
}

/// 42:143 注册：「让他人设置」/「自己设置」。
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return OnboardingScaffold(
      title: '注册',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceLg * 2),
          _RegisterOption(
            label: '让他人设置',
            textTheme: textTheme,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => QrSetupPage(state: state),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceMd),
          _RegisterOption(
            label: '自己设置',
            textTheme: textTheme,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => InfoFormPage(state: state, byHelper: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterOption extends StatelessWidget {
  const _RegisterOption({
    required this.label,
    required this.textTheme,
    required this.onTap,
  });

  final String label;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppDimens.buttonHeight),
        alignment: Alignment.center,
        child: Text(
          label,
          style: textTheme.titleLarge?.copyWith(color: AppColors.accent),
        ),
      ),
    );
  }
}

/// 44:191 让他人设置：二维码占位 + 说明文字（对应 README 二维码辅助登录）。
class QrSetupPage extends StatelessWidget {
  const QrSetupPage({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return OnboardingScaffold(
      title: '让他人设置',
      bottom: WarmCtaButton(
        label: '家人已扫码，继续',
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => InfoFormPage(state: state, byHelper: true),
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppDimens.spaceLg),
          Container(
            width: 240,
            height: 240,
            decoration: const BoxDecoration(
              color: AppColors.placeholderGray,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimens.radiusInput),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceSm),
          Text(
            'Scan and help to set it up',
            style: textTheme.bodyLarge?.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: AppDimens.spaceXs),
          Text(
            '让家人用手机扫一扫，帮你完成设置',
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
