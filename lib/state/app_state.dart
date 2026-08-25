import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../l10n/app_localizations.dart';

/// 五个每日打卡项。
enum CheckInType { medication, bloodPressure, bloodSugar, diet, exercise }

/// 单次打卡记录（demo：仅内存态，当天有效）。
/// 用户填的数值摘要存到 [userSummary]；界面上未填时的占位文案
/// （如"早餐后 1 次"）由 `AppLocalizations` 在 widget 端解析。
class CheckInRecord {
  CheckInRecord({required this.type});

  final CheckInType type;

  bool done = false;

  /// 用户填的实际数值摘要，例如「120/78 mmHg」、「Breakfast · Low sugar」。
  /// 为空时，widget 用 AppLocalizations 里的占位文案兜底显示。
  String userSummary = '';

  /// 记录数值是否超出正常范围（卡片顶部显示 danger 细条 + 文字说明）。
  bool abnormal = false;
}

/// 一天的健康读数（用于趋势图 demo 数据）。
class DayReading {
  const DayReading({required this.label, required this.value});

  final String label;
  final double value;
}

/// 用药条目（引导流程录入，内存态）。
class Medication {
  Medication({required this.name, required this.timesPerDay, required this.pillsEach});

  String name;
  int timesPerDay;
  int pillsEach;
}

/// 血糖测量方式。
enum GlucoseMethod { cgm, manual }

/// 血糖目标标准。
enum GlucoseTarget { standard, diabetic, custom }

/// 纯前端内存态 App 状态。无后端、无持久化。
class AppState extends ChangeNotifier {
  AppState() {
    // demo：初始已完成 2 项（用药、饮食），方便首页展示 2/5 进度。
    // 占位文案由 widget 从 AppLocalizations 解析，state 不持有本地化字符串。
    _records[CheckInType.medication]!.done = true;
    _records[CheckInType.diet]!.done = true;
  }

  /// Current UI locale. Defaults to the first entry of
  /// `AppLocalizations.supportedLocales` (English in this build); toggle
  /// cycles through the supported list.
  Locale locale = const Locale('en');

  /// Advance to the next supported locale, then notify so the UI rebuilds.
  /// Adding a new language to `AppLocalizations.supportedLocales` is
  /// automatically picked up here — no need to edit this method.
  void toggleLocale() {
    final supported = AppLocalizations.supportedLocales;
    final idx = supported.indexWhere(
      (l) => l.languageCode == locale.languageCode,
    );
    final next = supported[(idx + 1) % supported.length];
    locale = next;
    notifyListeners();
  }

  final Map<CheckInType, CheckInRecord> _records = {
    CheckInType.medication: CheckInRecord(type: CheckInType.medication),
    CheckInType.bloodPressure: CheckInRecord(type: CheckInType.bloodPressure),
    CheckInType.bloodSugar: CheckInRecord(type: CheckInType.bloodSugar),
    CheckInType.diet: CheckInRecord(type: CheckInType.diet),
    CheckInType.exercise: CheckInRecord(type: CheckInType.exercise),
  };

  final Random _random = Random();

  /// 今日步数（demo 起始值）。
  int steps = 3260;

  // ---------- 引导流程录入的数据（内存态） ----------

  /// 个人资料。
  String profileName = '';
  String profileAge = '';
  String profileGender = '';

  /// 是否由家人代为设置。
  bool setupByHelper = false;

  /// 用药列表。
  final List<Medication> medications = [];

  /// 血压提醒阈值。
  int bpAlertSystolic = 140;
  int bpAlertDiastolic = 90;

  /// 血糖设置。
  GlucoseMethod glucoseMethod = GlucoseMethod.manual;
  final Set<String> glucoseTimings = {'空腹'};
  GlucoseTarget glucoseTarget = GlucoseTarget.standard;
  double glucoseFastingMin = 3.9;
  double glucoseFastingMax = 6.1;
  double glucosePostMin = 3.9;
  double glucosePostMax = 7.8;

  /// 每日步数目标。
  int stepGoal = 6000;

  /// 权限开关（demo，默认全开）。
  final Map<String, bool> permissions = {
    '通知': true,
    '相机': true,
    '健康数据': true,
    '蓝牙': true,
  };

  /// 问候用称呼：引导填了姓名用姓名，否则默认「王奶奶」。
  String get displayName =>
      profileName.isEmpty ? '王奶奶' : profileName;

  void saveProfile({
    required String name,
    required String age,
    required String gender,
    required bool byHelper,
  }) {
    profileName = name;
    profileAge = age;
    profileGender = gender;
    setupByHelper = byHelper;
    notifyListeners();
  }

  void addMedication(Medication med) {
    medications.add(med);
    notifyListeners();
  }

  void setBpAlert(int systolic, int diastolic) {
    bpAlertSystolic = systolic;
    bpAlertDiastolic = diastolic;
    notifyListeners();
  }

  void togglePermission(String key) {
    permissions[key] = !(permissions[key] ?? false);
    notifyListeners();
  }

  void setGlucoseMethod(GlucoseMethod method) {
    glucoseMethod = method;
    notifyListeners();
  }

  void toggleGlucoseTiming(String name) {
    glucoseTimings.contains(name)
        ? glucoseTimings.remove(name)
        : glucoseTimings.add(name);
    notifyListeners();
  }

  void setGlucoseTarget(GlucoseTarget target) {
    glucoseTarget = target;
    notifyListeners();
  }

  List<CheckInRecord> get records => _records.values.toList();

  CheckInRecord recordOf(CheckInType type) => _records[type]!;

  int get doneCount => records.where((r) => r.done).length;

  int get totalCount => records.length;

  /// 完成打卡并记录摘要，[abnormal] 标记数值是否超范围。
  void complete(CheckInType type, String summary, {bool abnormal = false}) {
    final record = _records[type]!;
    record
      ..done = true
      ..userSummary = summary
      ..abnormal = abnormal;
    notifyListeners();
  }

  /// 同步步数：demo 随机增加一段步数并完成运动打卡。
  void syncSteps() {
    steps += 400 + _random.nextInt(1200);
    complete(CheckInType.exercise, '今天走了 $steps 步');
  }

  // ---------- 趋势图 demo 数据（写死的最近 7 天） ----------

  static const double systolicMin = 90;
  static const double systolicMax = 140;
  static const double glucoseMin = 3.9;
  static const double glucoseMax = 7.8;

  /// 最近 7 天高压（mmHg），第 3 天略偏高用于演示 danger 柱子。
  static const List<DayReading> systolicWeek = [
    DayReading(label: '一', value: 124),
    DayReading(label: '二', value: 132),
    DayReading(label: '三', value: 146),
    DayReading(label: '四', value: 128),
    DayReading(label: '五', value: 118),
    DayReading(label: '六', value: 135),
    DayReading(label: '日', value: 122),
  ];

  /// 最近 7 天血糖（mmol/L），第 5 天略偏高。
  static const List<DayReading> glucoseWeek = [
    DayReading(label: '一', value: 5.4),
    DayReading(label: '二', value: 6.0),
    DayReading(label: '三', value: 6.6),
    DayReading(label: '四', value: 5.8),
    DayReading(label: '五', value: 8.2),
    DayReading(label: '六', value: 5.9),
    DayReading(label: '日', value: 6.1),
  ];

  static bool isSystolicAbnormal(double v) => v < systolicMin || v > systolicMax;

  static bool isDiastolicAbnormal(double v) => v < 60 || v > 90;

  static bool isGlucoseAbnormal(double v) => v < glucoseMin || v > glucoseMax;
}
