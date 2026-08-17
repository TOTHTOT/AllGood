import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimens.dart';

/// DESIGN.md 第 3、4、8 节的 Flutter 主题映射。
/// 字阶映射到 TextTheme 槽位：
/// - displayLarge  = reading(48)  健康读数
/// - displayMedium = display(34)  页面大标题
/// - headlineMedium = title(28)   模块标题
/// - titleLarge    = headline(22) 打卡项名称 / 按钮文字
/// - titleMedium   = bodyStrong(20) 正文强调
/// - bodyLarge     = body(20)     正文基准
/// - bodyMedium    = caption(17)  辅助说明
/// - bodySmall     = readingUnit(17) 读数单位
abstract final class AppTheme {
  static ThemeData light() {
    const colorScheme = ColorScheme.light(
      primary: AppColors.accent,
      onPrimary: AppColors.bgCard,
      surface: AppColors.bgPage,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      error: AppColors.danger,
      outline: AppColors.divider,
      primaryContainer: AppColors.accentSoft,
      onPrimaryContainer: AppColors.accent,
    );

    const textTheme = TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w600,
        height: 1.1,
        letterSpacing: -0.5,
        color: AppColors.textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: AppColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.45,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: AppColors.textSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: 1.3,
        color: AppColors.textSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.bgCard,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bgPage,
      textTheme: textTheme,
      // 全局去掉 Material 水波纹与高亮，按压反馈统一用透明度（AppleButton/Pressable）
      splashFactory: NoSplash.splashFactory,
      highlightColor: const Color(0x00000000),
      hoverColor: const Color(0x00000000),
      cardTheme: const CardThemeData(
        color: AppColors.bgCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.radiusCard),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.bgCard,
          minimumSize: const Size.fromHeight(AppDimens.buttonHeight),
          textStyle: textTheme.labelLarge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimens.radiusPill),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accent,
          minimumSize: const Size.fromHeight(AppDimens.buttonHeight),
          textStyle: textTheme.titleLarge,
          side: const BorderSide(color: AppColors.accent, width: 2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimens.radiusPill),
            ),
          ),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.bgCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimens.radiusSheet),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: textTheme.bodyLarge?.copyWith(
          color: AppColors.bgCard,
        ),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.radiusInput),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
