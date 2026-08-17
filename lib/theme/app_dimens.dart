/// DESIGN.md 第 4、5 节间距 / 圆角 / 触控 token 的唯一落点。
abstract final class AppDimens {
  // 8pt 网格间距
  static const double spaceXs = 8;
  static const double spaceSm = 16;
  static const double spaceMd = 24;
  static const double spaceLg = 32;

  // 页面与卡片
  static const double pagePadding = 20;
  static const double cardPadding = 24;
  static const double cardGap = 16;

  // 圆角
  static const double radiusCard = 20;
  static const double radiusInput = 14;
  static const double radiusTag = 8;
  static const double radiusSheet = 16; // iOS sheet 顶部圆角
  static const double radiusPill = 999;

  // 触控目标（适老硬规则）
  static const double touchMin = 56;
  static const double buttonHeight = 64;
  static const double checkButtonHeight = 56;

  // 组件尺寸
  static const double iconLarge = 40;
  static const double progressRing = 96;
  static const double progressRingWidth = 10;
  static const double sheetHeightFactor = 0.75;
  static const double sheetHandleWidth = 36;
  static const double sheetHandleHeight = 5;
  static const double tabBarHeight = 64;
  static const double tabIconSize = 28;
  static const double chartHeight = 160;
  static const double dangerBarHeight = 4;
}
