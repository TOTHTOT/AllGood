import 'dart:math';

import 'package:flutter/foundation.dart';

/// 五个每日打卡项。
enum CheckInType { medication, bloodPressure, bloodSugar, diet, exercise }

/// 单次打卡记录（demo：仅内存态，当天有效）。
class CheckInRecord {
  CheckInRecord({required this.type, required this.statusText});

  final CheckInType type;

  /// 未完成时显示的状态说明，如「8:00 早餐后 1 次」。
  final String statusText;

  bool done = false;

  /// 完成后的记录摘要，如「120/78 mmHg」。
  String summary = '';

  /// 记录数值是否超出正常范围（卡片顶部显示 danger 细条 + 文字说明）。
  bool abnormal = false;
}

/// 一天的健康读数（用于趋势图 demo 数据）。
class DayReading {
  const DayReading({required this.label, required this.value});

  final String label;
  final double value;
}

/// 纯前端内存态 App 状态。无后端、无持久化。
class AppState extends ChangeNotifier {
  AppState() {
    // demo：初始已完成 2 项（用药、饮食），方便首页展示 2/5 进度。
    _records[CheckInType.medication]!
      ..done = true
      ..summary = '早餐后 1 次，已按时吃药';
    _records[CheckInType.diet]!
      ..done = true
      ..summary = '午餐 · 低糖';
  }

  final Map<CheckInType, CheckInRecord> _records = {
    CheckInType.medication:
        CheckInRecord(type: CheckInType.medication, statusText: '8:00 早餐后 1 次'),
    CheckInType.bloodPressure:
        CheckInRecord(type: CheckInType.bloodPressure, statusText: '早上量一次血压'),
    CheckInType.bloodSugar:
        CheckInRecord(type: CheckInType.bloodSugar, statusText: '餐后测一次血糖'),
    CheckInType.diet:
        CheckInRecord(type: CheckInType.diet, statusText: '拍一拍今天吃的饭'),
    CheckInType.exercise:
        CheckInRecord(type: CheckInType.exercise, statusText: '散散步，活动一下'),
  };

  final Random _random = Random();

  /// 今日步数（demo 起始值）。
  int steps = 3260;

  List<CheckInRecord> get records => _records.values.toList();

  CheckInRecord recordOf(CheckInType type) => _records[type]!;

  int get doneCount => records.where((r) => r.done).length;

  int get totalCount => records.length;

  /// 完成打卡并记录摘要，[abnormal] 标记数值是否超范围。
  void complete(CheckInType type, String summary, {bool abnormal = false}) {
    final record = _records[type]!;
    record
      ..done = true
      ..summary = summary
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
