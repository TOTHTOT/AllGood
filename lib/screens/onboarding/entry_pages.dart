import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../widgets/apple_button.dart';
import '../../widgets/ios_toast.dart';
import 'info_form_page.dart';
import 'onboarding_widgets.dart';

/// 22:14 初始页：米色底 + 玫瑰大标题 + 浅蓝灰「都好！」按钮。
/// 右上角是语言切换入口（EN ↔ 中），登录流程全程生效。
class InitialPage extends StatelessWidget {
  const InitialPage({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顶部右上角：语言切换入口。
              Align(
                alignment: Alignment.topRight,
                child: _LanguageToggle(
                  label: l.languageToggleLabel,
                  onTap: state.toggleLocale,
                ),
              ),
              const SizedBox(height: AppDimens.spaceLg),
              Center(
                child: Text(
                  l.entryGreeting,
                  style: textTheme.displayMedium
                      ?.copyWith(color: AppColors.accent),
                ),
              ),
              const Spacer(),
              Center(
                child: SoftBlueButton(
                  label: l.entryCta,
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

/// 右上角语言切换：iOS 风格胶囊按钮，点击在 EN ↔ 中 之间切换。
class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spaceSm,
          vertical: AppDimens.spaceXs,
        ),
        decoration: BoxDecoration(
          color: AppColors.accentSoft,
          borderRadius: BorderRadius.circular(AppDimens.radiusTag),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
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
    final l = AppLocalizations.of(context);
    return OnboardingScaffold(
      showBack: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceLg * 4),
          SoftBlueButton(
            label: l.loginNoAccount,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => RegisterPage(state: state),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceMd),
          SoftBlueButton(
            label: l.loginCta,
            onTap: () => showIosToast(context, l.loginDemoOnly),
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
    final l = AppLocalizations.of(context);
    return OnboardingScaffold(
      title: l.registerTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimens.spaceLg * 2),
          _RegisterOption(
            label: l.registerHelper,
            textTheme: textTheme,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => QrSetupPage(state: state),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceMd),
          _RegisterOption(
            label: l.registerSelf,
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
    final l = AppLocalizations.of(context);
    return OnboardingScaffold(
      title: l.qrTitle,
      bottom: WarmCtaButton(
        label: l.qrScannedCta,
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
            l.qrCaption1,
            style: textTheme.bodyLarge?.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: AppDimens.spaceXs),
          Text(
            l.qrCaption2,
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}