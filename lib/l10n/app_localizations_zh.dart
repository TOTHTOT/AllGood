// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get languageToggleLabel => 'EN';

  @override
  String get tabToday => '今天';

  @override
  String get tabTrends => '趋势';

  @override
  String get tabFamily => '家人';

  @override
  String get todayProgress => '今日进度';

  @override
  String get todayAllDone => '今天全部完成，真棒！';

  @override
  String todayProgressRemaining(int done, int left) {
    return '已完成 $done 项，还差 $left 项';
  }

  @override
  String get greetingMorning => '早上好';

  @override
  String get greetingNoon => '中午好';

  @override
  String get greetingAfternoon => '下午好';

  @override
  String get greetingEvening => '晚上好';

  @override
  String get greetingPlaceholder => '您好';

  @override
  String greeting(String name) {
    return '$name';
  }

  @override
  String dateLabel(int month, int day, String weekday) {
    return '$month月$day日 星期$weekday';
  }

  @override
  String get recordButton => '打卡';

  @override
  String get checkedIn => '已打卡';

  @override
  String get abnormalWarning => '这次数值有点高，留意一下';

  @override
  String get toastAlreadyDone => '今天已经打过卡啦';

  @override
  String get toastRecorded => '已记录，真棒！';

  @override
  String get checkInMedication => '用药';

  @override
  String get checkInBloodPressure => '血压';

  @override
  String get checkInBloodSugar => '血糖';

  @override
  String get checkInDiet => '饮食';

  @override
  String get checkInExercise => '运动';

  @override
  String get trendsSubtitle => '最近 7 天';

  @override
  String get trendsBpTitle => '血压（高压）';

  @override
  String get trendsBpRange => '正常范围 90–140 mmHg';

  @override
  String get trendsBpSummary => '最近 7 天血压大体平稳，周三略偏高，其余都在正常范围。';

  @override
  String get trendsGlucoseTitle => '血糖';

  @override
  String get trendsGlucoseRange => '正常范围 3.9–7.8 mmol/L';

  @override
  String get trendsGlucoseSummary => '血糖大多正常，周五餐后偏高，甜食要少吃一点。';

  @override
  String familyWatching(String name) {
    return '正在关注：$name · 数据由妈妈授权共享';
  }

  @override
  String familyReminder(String name) {
    return '$name今天中午还没打卡，方便时联系一下她';
  }

  @override
  String get exportButton => '导出健康数据';

  @override
  String get exportDemoUnavailable => '演示版本暂未开放';

  @override
  String get familyTodayHeading => '今天的情况';

  @override
  String get statusDone => '已完成';

  @override
  String get statusPending => '待打卡';

  @override
  String get familyWeeklyHeading => '本周简报';

  @override
  String get weeklyAdherence => '本周打卡完成率 86%';

  @override
  String get weeklyBp => '血压大部平稳，周三略偏高';

  @override
  String get weeklyGlucose => '餐后血糖偶尔偏高，注意甜食';

  @override
  String get weekdayMon => '一';

  @override
  String get weekdayTue => '二';

  @override
  String get weekdayWed => '三';

  @override
  String get weekdayThu => '四';

  @override
  String get weekdayFri => '五';

  @override
  String get weekdaySat => '六';

  @override
  String get weekdaySun => '日';

  @override
  String get medicationSheetTitle => '今天吃药了吗？';

  @override
  String get medicationSheetHint => '早餐后 1 次：降压药 1 片，温水送服。';

  @override
  String get medicationSummary => '早餐后 1 次，已按时吃药';

  @override
  String get medicationConfirm => '已吃药';

  @override
  String get medicationDefaultName => '降压药';

  @override
  String get bpSheetTitle => '量血压';

  @override
  String get bpSheetSubmit => '完成记录';

  @override
  String get bpSystolicLabel => '高压（收缩压）';

  @override
  String get bpDiastolicLabel => '低压（舒张压）';

  @override
  String get bpAbnormalHint => '这个数值和平常不太一样，身体不舒服就告诉家人';

  @override
  String bpSummary(int sys, int dia) {
    return '$sys/$dia mmHg';
  }

  @override
  String get sugarSheetTitle => '测血糖';

  @override
  String get sugarMealQuestion => '这是哪一餐前后测的？';

  @override
  String get sugarValueLabel => '血糖值';

  @override
  String get sugarAbnormalHint => '这次血糖有点高，甜食要少吃一点哦';

  @override
  String get sugarMealFasting => '空腹';

  @override
  String get sugarMealAfterBreakfast => '早餐后';

  @override
  String get sugarMealAfterLunch => '午餐后';

  @override
  String get sugarMealAfterDinner => '晚餐后';

  @override
  String sugarSummary(String meal, String value) {
    return '$meal $value mmol/L';
  }

  @override
  String get dietSheetTitle => '今天吃了什么？';

  @override
  String get dietSheetSubmit => '完成记录';

  @override
  String get dietPhotoAdded => '已添加照片';

  @override
  String get dietTakePhoto => '拍张照片';

  @override
  String get dietSugarQuestion => '这餐甜不甜？';

  @override
  String get dietSugarLow => '低糖';

  @override
  String get dietSugarMedium => '中糖';

  @override
  String get dietSugarHigh => '高糖';

  @override
  String dietSummary(String level) {
    return '午餐 · $level';
  }

  @override
  String get exerciseSheetTitle => '今天动一动';

  @override
  String get exerciseSheetSubmit => '同步步数';

  @override
  String get exerciseAlreadyWalked => '今天已经走了';

  @override
  String get exerciseStepsUnit => '步';

  @override
  String get exerciseHint => '点下面按钮，把手机上的步数同步过来';

  @override
  String get entryGreeting => '今天过得怎么样？';

  @override
  String get entryCta => '都好！';

  @override
  String get loginNoAccount => '我没有账号';

  @override
  String get loginCta => '登陆';

  @override
  String get loginDemoOnly => '演示版本请走注册流程';

  @override
  String get registerTitle => '注册';

  @override
  String get registerHelper => '让他人设置';

  @override
  String get registerSelf => '自己设置';

  @override
  String get qrTitle => '让他人设置';

  @override
  String get qrScannedCta => '家人已扫码，继续';

  @override
  String get qrCaption1 => 'Scan and help to set it up';

  @override
  String get qrCaption2 => '让家人用手机扫一扫，帮你完成设置';

  @override
  String get infoFormTitleHelper => '帮他人设置';

  @override
  String get infoFormTitleSelf => '自己设置';

  @override
  String get infoNameHint => '姓名';

  @override
  String get infoAgeHint => '年龄';

  @override
  String get infoGenderFemale => '女';

  @override
  String get infoGenderMale => '男';

  @override
  String get continueButton => '继续';

  @override
  String get saveButton => '保存';

  @override
  String get medicationStatusTitle => '用药状况';

  @override
  String get medicationNone => '我没有用药';

  @override
  String get medicationNeed => '我需要用药';

  @override
  String get medicationTapToAdd => '点击添加';

  @override
  String get medicationPhotoUnavailable => '拍照识别暂未开放，请用 + 添加';

  @override
  String medicationCardSummary(String name, int times, int pills) {
    return '$name · 一日 $times 次 · 一次 $pills 粒';
  }

  @override
  String get medicationDetailTitle => '用药详情';

  @override
  String get medicationNameHint => '点击输入药名';

  @override
  String get medicationTimesLabel => '一日几次';

  @override
  String get medicationPillsLabel => '一次几粒';

  @override
  String get medicationTimesUnit => '次';

  @override
  String get medicationPillsUnit => '粒';

  @override
  String get checkInMedicationStatus => '8:00 早餐后 1 次';

  @override
  String get checkInMedicationSummary => '早餐后 1 次，已按时吃药';

  @override
  String get checkInBloodPressureStatus => '早上量一次血压';

  @override
  String get checkInBloodSugarStatus => '餐后测一次血糖';

  @override
  String get checkInDietStatus => '拍一拍今天吃的饭';

  @override
  String get checkInExerciseStatus => '散散步，活动一下';

  @override
  String get recordWantsTitle => '我想要记录';

  @override
  String get recordWantsBp => '血压';

  @override
  String get recordWantsSugar => '血糖';

  @override
  String get recordWantsExercise => '运动信息';

  @override
  String get recordWantsBreadcrumbBluetooth => '蓝牙配对';

  @override
  String get recordWantsBreadcrumbSugar => '血糖测量';

  @override
  String get recordWantsBreadcrumbSugarTiming => '血糖测量/测量时段';

  @override
  String get bpCardTitle => '提醒值';

  @override
  String get bpCardAbove => '高于';

  @override
  String get bpCardSystolic => '高压';

  @override
  String get bpCardDiastolic => '低压';

  @override
  String get bpCardAdd => '添加';

  @override
  String get bpCardAddedToast => '已添加血压提醒';

  @override
  String get exerciseGoalTitle => '每日步数目标';

  @override
  String exerciseGoalSteps(int n) {
    return '$n 步';
  }

  @override
  String get exerciseGoalAdd => '添加';

  @override
  String get exerciseGoalSaved => '已保存运动目标';

  @override
  String get sugarStepMethod => '血糖测量';

  @override
  String get sugarStepMethodHint => '您平时怎么测血糖？';

  @override
  String get sugarMethodCgm => '实时血糖仪（CGM）';

  @override
  String get sugarMethodCgmSub => '佩戴在手臂上，自动记录';

  @override
  String get sugarMethodManual => '手动测量';

  @override
  String get sugarMethodManualSub => '扎手指或手动记录数值';

  @override
  String get sugarBluetoothTitle => '蓝牙';

  @override
  String get sugarBluetoothHint => '请打开血糖仪蓝牙，点击圆环连接';

  @override
  String get sugarBluetoothUnavailable => '蓝牙连接暂未开放，敬请期待';

  @override
  String get sugarTimingTitle => '测量时段';

  @override
  String get sugarTimingHint => '您通常什么时候测血糖？多选';

  @override
  String get sugarTimingNext => '下一步';

  @override
  String get sugarTimingNameFasting => '空腹';

  @override
  String get sugarTimingNameAfterBreakfast => '早餐后';

  @override
  String get sugarTimingNameAfterLunch => '午餐后';

  @override
  String get sugarTimingNameAfterDinner => '晚餐后';

  @override
  String get sugarTimingNameBedtime => '睡前';

  @override
  String get sugarTimingNoteFasting => '早起没吃饭前';

  @override
  String get sugarTimingNoteAfterBreakfast => '吃完早餐 2 小时';

  @override
  String get sugarTimingNoteAfterLunch => '吃完午餐 2 小时';

  @override
  String get sugarTimingNoteAfterDinner => '吃完晚餐 2 小时';

  @override
  String get sugarTimingNoteBedtime => '准备睡觉前';

  @override
  String get sugarTimingTime1 => '07:00';

  @override
  String get sugarTimingTime2 => '09:00';

  @override
  String get sugarTimingTime3 => '14:00';

  @override
  String get sugarTimingTime4 => '20:00';

  @override
  String get sugarTimingTime5 => '21:30';

  @override
  String get sugarTargetTitle => '血糖目标';

  @override
  String get sugarTargetHint => '一般不用改，直接下一步就好';

  @override
  String get sugarTargetStandard => '一般标准';

  @override
  String get sugarTargetStandardValue => '空腹 < 6.1   餐后 < 7.8';

  @override
  String get sugarTargetStandardNote => '适合血糖偏高、未确诊';

  @override
  String get sugarTargetDiabetic => '糖尿病人标准';

  @override
  String get sugarTargetDiabeticValue => '空腹 < 7.0   餐后 < 10.0';

  @override
  String get sugarTargetDiabeticNote => '已确诊的常用控制目标';

  @override
  String get sugarTargetCustom => '自定义';

  @override
  String get sugarTargetCustomNote => '根据医生建议设置目标范围';

  @override
  String get sugarTargetSavedToast => '血糖设置完成';

  @override
  String get sugarCustomTitle => '自定义目标';

  @override
  String get sugarCustomHint => '根据医生建议设置您的目标范围';

  @override
  String get sugarCustomFasting => '空腹';

  @override
  String get sugarCustomFastingNote => '早起未进食时的血糖值';

  @override
  String get sugarCustomPost => '餐后血糖';

  @override
  String get sugarCustomPostNote => '进餐后 2 小时的血糖值';

  @override
  String get sugarCustomMinLabel => '最低';

  @override
  String get sugarCustomMaxLabel => '最高';

  @override
  String get sugarCustomSave => '保存设置';

  @override
  String get sugarCustomSavedToast => '已保存血糖目标';

  @override
  String get dietIntroTitle => '饮食记录';

  @override
  String get dietIntroBody => '每天拍照记录三餐，帮您和家人了解饮食与血糖的关系。';

  @override
  String get dietIntroCta => '记录';

  @override
  String get permissionsTitle => '需要您允许几项权限';

  @override
  String get permissionsSubtitle => '开启后，才能为您提供完整的健康管理服务';

  @override
  String get permissionsAllCta => '全部允许并继续';

  @override
  String get permissionsFootnote => '之后也可在「设置」中随时更改';

  @override
  String get permissionsNameNotifications => '通知';

  @override
  String get permissionsNoteNotifications => '到时提醒您吃药、量血压';

  @override
  String get permissionsNameCamera => '相机';

  @override
  String get permissionsNoteCamera => '拍照记录饮食';

  @override
  String get permissionsNameHealth => '健康数据';

  @override
  String get permissionsNoteHealth => '自动读取步数';

  @override
  String get permissionsNameBluetooth => '蓝牙';

  @override
  String get permissionsNoteBluetooth => '连接血糖仪';

  @override
  String get setupCompleteTitle => '设置完成！';

  @override
  String get setupCompleteCta => '开始使用';

  @override
  String get setupRemindersHeading => '今日提醒一览';

  @override
  String setupReminderMed(String medName) {
    return '吃 $medName 药 1 片（已设响铃）';
  }

  @override
  String get setupReminderBp => '测量血压（建议静止后测）';

  @override
  String get setupReminderLunch => '午餐拍照记录';

  @override
  String setupReminderSteps(int goal) {
    return '今日目标 $goal 步';
  }

  @override
  String get setupReminderAllDay => '全天';
}
