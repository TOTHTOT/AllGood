import 'package:flutter/material.dart';

/// DESIGN.md 第 2 节色彩 token 的唯一落点（Figma 暖色系换肤版，
/// 色值取自 Figma fileKey 4icGe2Lg2Bb1KdIqIHhlsM 逐帧提取）。
/// 除这里定义的颜色外，页面不允许引入任何其他颜色值。
abstract final class AppColors {
  // 基础色
  static const Color bgPage = Color(0xFFFFFBF4); // 暖米白
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color cardSoft = Color(0xD9FFFFFF); // 白 85%（权限卡片）
  static const Color textPrimary = Color(0xFF33261F); // 深棕黑
  static const Color textSecondary = Color(0xFF737880);
  static const Color textTertiary = Color(0xFF8C8C8C);
  static const Color divider = Color(0xFFE0E3E8); // hairline / 未选描边

  // 品牌强调色：灰玫瑰
  static const Color accent = Color(0xFFC56873);
  static const Color accentSoft = Color(0xFFF3D9CD); // 桃粉（选中底/浅底）

  // 暖粉系辅助色
  static const Color pink = Color(0xFFD2A6B3); // 主 CTA / 用药大卡
  static const Color mauve = Color(0xFFD1A6B2); // 开关轨道 / 装饰圆
  static const Color iconSoftBg = Color(0xFFE5D1D9); // 权限图标底
  static const Color checkboxRose = Color(0xFFD28491); // 勾选框

  // 石板蓝系（次要文字 / 手风琴 / 描边）
  static const Color slate = Color(0xFF58809F);
  static const Color softBlue = Color(0xFFD5E5F0); // 浅蓝灰按钮底
  static const Color blueMid = Color(0xFF7BA9CD);
  static const Color blueLight = Color(0xFF95C6EF);
  static const Color blueSheet = Color(0xFF8FBFEB); // 血糖面板
  static const Color deepBlue = Color(0xFF1F6B8A); // 保存设置 / 数值
  static const Color outlineBlue = Color(0xFFA5C5DE); // 表单描边
  static const Color strokeGray = Color(0xFFB8C4D1); // 添加卡描边
  static const Color placeholderGray = Color(0xFFD9D9D9); // 占位块
  static const Color bluetoothInner = Color(0xFFD3ECFF); // 蓝牙配对内圈
  static final Color inputFill = const Color(
    0xFFEBF5FF,
  ); // 输入框底
  static final Color inputStroke = deepBlue.withValues(alpha: 0.3);

  // 健康语义色（唯一的多色例外，沿用 Apple system colors）
  static const Color ok = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9F0A);
  static const Color danger = Color(0xFFFF3B30);

  // 语义色浅底
  static final Color okSoft = ok.withValues(alpha: 0.10);
  static final Color warningSoft = warning.withValues(alpha: 0.12);
  static final Color dangerSoft = danger.withValues(alpha: 0.10);

  // iOS 细节质感
  static const Color grabber = Color(0xFFD1D1D6); // 弹层顶部把手
  static const Color toastBg = Color(0xD9000000); // toast 胶囊 rgba(0,0,0,0.85)

  /// 装饰圆（mauve 8% 透明度），引导页背景点缀
  static final Color decorative = mauve.withValues(alpha: 0.08);
}
