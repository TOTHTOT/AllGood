import 'package:flutter/material.dart';

/// DESIGN.md 第 2 节色彩 token 的唯一落点。
/// 除这里定义的颜色外，页面不允许引入任何其他颜色值。
abstract final class AppColors {
  // 基础色（Apple 体系）
  static const Color bgPage = Color(0xFFF5F5F7);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1D1D1F);
  static const Color textSecondary = Color(0xFF6E6E73);
  static const Color textTertiary = Color(0xFFAEAEB2);
  static const Color divider = Color(0xFFE5E5EA);

  // 唯一品牌强调色
  static const Color accent = Color(0xFF0A7AFF);
  static const Color accentSoft = Color(0xFFE5F0FF);

  // 健康语义色（唯一的多色例外）
  static const Color ok = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9F0A);
  static const Color danger = Color(0xFFFF3B30);

  // 语义色浅底：正常范围色带（ok 10%）、提醒横幅浅底等
  static final Color okSoft = ok.withValues(alpha: 0.10);
  static final Color warningSoft = warning.withValues(alpha: 0.12);
  static final Color dangerSoft = danger.withValues(alpha: 0.10);

  // iOS 细节质感
  static const Color grabber = Color(0xFFD1D1D6); // 弹层顶部把手
  static const Color toastBg = Color(0xD9000000); // toast 胶囊 rgba(0,0,0,0.85)
}
