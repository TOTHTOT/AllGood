// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get languageToggleLabel => '中';

  @override
  String get tabToday => 'Today';

  @override
  String get tabTrends => 'Trends';

  @override
  String get tabFamily => 'Family';

  @override
  String get todayProgress => 'Today\'s progress';

  @override
  String get todayAllDone => 'All done for today — well done!';

  @override
  String todayProgressRemaining(int done, int left) {
    return '$done done · $left to go';
  }

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingNoon => 'Good afternoon';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get greetingPlaceholder => 'Hello';

  @override
  String greeting(String name) {
    return '$name';
  }

  @override
  String dateLabel(int month, int day, String weekday) {
    return '$weekday, $month/$day';
  }

  @override
  String get recordButton => 'Check in';

  @override
  String get checkedIn => 'Checked in';

  @override
  String get abnormalWarning => 'This reading is high — keep an eye on it';

  @override
  String get toastAlreadyDone => 'Already checked in today';

  @override
  String get toastRecorded => 'Recorded — well done!';

  @override
  String get checkInMedication => 'Medication';

  @override
  String get checkInBloodPressure => 'Blood pressure';

  @override
  String get checkInBloodSugar => 'Blood sugar';

  @override
  String get checkInDiet => 'Diet';

  @override
  String get checkInExercise => 'Exercise';

  @override
  String get trendsSubtitle => 'Last 7 days';

  @override
  String get trendsBpTitle => 'Blood pressure (systolic)';

  @override
  String get trendsBpRange => 'Normal range 90–140 mmHg';

  @override
  String get trendsBpSummary =>
      'Mostly steady over the last 7 days; a slight bump on Wednesday, otherwise within range.';

  @override
  String get trendsGlucoseTitle => 'Blood sugar';

  @override
  String get trendsGlucoseRange => 'Normal range 3.9–7.8 mmol/L';

  @override
  String get trendsGlucoseSummary =>
      'Mostly in range. A post-meal spike on Friday — go easy on sweets.';

  @override
  String familyWatching(String name) {
    return 'Watching: $name · data shared with consent';
  }

  @override
  String familyReminder(String name) {
    return '$name hasn\'t checked in by noon — drop her a line';
  }

  @override
  String get exportButton => 'Export health data';

  @override
  String get exportDemoUnavailable => 'Demo only — not available';

  @override
  String get familyTodayHeading => 'Today\'s status';

  @override
  String get statusDone => 'Done';

  @override
  String get statusPending => 'Pending';

  @override
  String get familyWeeklyHeading => 'Weekly summary';

  @override
  String get weeklyAdherence => 'Weekly check-in rate 86%';

  @override
  String get weeklyBp => 'BP mostly steady; a bump on Wednesday';

  @override
  String get weeklyGlucose => 'Occasional post-meal spikes — watch the sweets';

  @override
  String get weekdayMon => 'Mon';

  @override
  String get weekdayTue => 'Tue';

  @override
  String get weekdayWed => 'Wed';

  @override
  String get weekdayThu => 'Thu';

  @override
  String get weekdayFri => 'Fri';

  @override
  String get weekdaySat => 'Sat';

  @override
  String get weekdaySun => 'Sun';

  @override
  String get medicationSheetTitle => 'Did you take your meds today?';

  @override
  String get medicationSheetHint =>
      'Once after breakfast: 1 blood-pressure pill with warm water.';

  @override
  String get medicationSummary => 'Took 1 after breakfast, on time';

  @override
  String get medicationConfirm => 'Took it';

  @override
  String get medicationDefaultName => 'Blood pressure pill';

  @override
  String get bpSheetTitle => 'Take blood pressure';

  @override
  String get bpSheetSubmit => 'Save reading';

  @override
  String get bpSystolicLabel => 'Systolic (top)';

  @override
  String get bpDiastolicLabel => 'Diastolic (bottom)';

  @override
  String get bpAbnormalHint =>
      'This isn\'t your usual reading — tell family if you feel off';

  @override
  String bpSummary(int sys, int dia) {
    return '$sys/$dia mmHg';
  }

  @override
  String get sugarSheetTitle => 'Check blood sugar';

  @override
  String get sugarMealQuestion => 'Which meal was this around?';

  @override
  String get sugarValueLabel => 'Reading';

  @override
  String get sugarAbnormalHint => 'A bit high — go easy on the sweets';

  @override
  String get sugarMealFasting => 'Fasting';

  @override
  String get sugarMealAfterBreakfast => 'After breakfast';

  @override
  String get sugarMealAfterLunch => 'After lunch';

  @override
  String get sugarMealAfterDinner => 'After dinner';

  @override
  String sugarSummary(String meal, String value) {
    return '$meal $value mmol/L';
  }

  @override
  String get dietSheetTitle => 'What did you eat today?';

  @override
  String get dietSheetSubmit => 'Save meal';

  @override
  String get dietPhotoAdded => 'Photo added';

  @override
  String get dietTakePhoto => 'Take a photo';

  @override
  String get dietSugarQuestion => 'How sweet was it?';

  @override
  String get dietSugarLow => 'Low sugar';

  @override
  String get dietSugarMedium => 'Medium';

  @override
  String get dietSugarHigh => 'High sugar';

  @override
  String dietSummary(String level) {
    return 'Lunch · $level';
  }

  @override
  String get exerciseSheetTitle => 'Get moving today';

  @override
  String get exerciseSheetSubmit => 'Sync steps';

  @override
  String get exerciseAlreadyWalked => 'You\'ve walked';

  @override
  String get exerciseStepsUnit => 'steps';

  @override
  String get exerciseHint => 'Tap below to sync steps from your phone';

  @override
  String get entryGreeting => 'How are you today?';

  @override
  String get entryCta => 'I\'m good!';

  @override
  String get loginNoAccount => 'I have no account';

  @override
  String get loginCta => 'Log in';

  @override
  String get loginDemoOnly => 'Demo only — please sign up';

  @override
  String get registerTitle => 'Sign up';

  @override
  String get registerHelper => 'Have someone help me';

  @override
  String get registerSelf => 'Set it up myself';

  @override
  String get qrTitle => 'Have someone help me';

  @override
  String get qrScannedCta => 'Family scanned it — continue';

  @override
  String get qrCaption1 => 'Scan and help to set it up';

  @override
  String get qrCaption2 => 'Ask a family member to scan and help finish setup';

  @override
  String get infoFormTitleHelper => 'Help set it up';

  @override
  String get infoFormTitleSelf => 'Set it up myself';

  @override
  String get infoNameHint => 'Name';

  @override
  String get infoAgeHint => 'Age';

  @override
  String get infoGenderFemale => 'Female';

  @override
  String get infoGenderMale => 'Male';

  @override
  String get continueButton => 'Continue';

  @override
  String get saveButton => 'Save';

  @override
  String get medicationStatusTitle => 'Medications';

  @override
  String get medicationNone => 'I do not take any';

  @override
  String get medicationNeed => 'I take medication';

  @override
  String get medicationTapToAdd => 'Tap to add';

  @override
  String get medicationPhotoUnavailable =>
      'Photo recognition unavailable — use + to add';

  @override
  String medicationCardSummary(String name, int times, int pills) {
    return '$name · $times times/day · $pills pills each';
  }

  @override
  String get medicationDetailTitle => 'Medication details';

  @override
  String get medicationNameHint => 'Tap to enter name';

  @override
  String get medicationTimesLabel => 'Times per day';

  @override
  String get medicationPillsLabel => 'Pills each time';

  @override
  String get medicationTimesUnit => 'x';

  @override
  String get medicationPillsUnit => 'pills';

  @override
  String get checkInMedicationStatus => '8:00, 1 dose after breakfast';

  @override
  String get checkInMedicationSummary => 'Took 1 after breakfast, on time';

  @override
  String get checkInBloodPressureStatus =>
      'Take your blood pressure once in the morning';

  @override
  String get checkInBloodSugarStatus => 'Check your blood sugar after a meal';

  @override
  String get checkInDietStatus => 'Snap a photo of today\'s meals';

  @override
  String get checkInExerciseStatus => 'Take a short walk and stretch';

  @override
  String get recordWantsTitle => 'What I want to track';

  @override
  String get recordWantsBp => 'Blood pressure';

  @override
  String get recordWantsSugar => 'Blood sugar';

  @override
  String get recordWantsExercise => 'Exercise';

  @override
  String get recordWantsBreadcrumbBluetooth => 'Bluetooth pairing';

  @override
  String get recordWantsBreadcrumbSugar => 'Blood sugar';

  @override
  String get recordWantsBreadcrumbSugarTiming => 'Blood sugar / When';

  @override
  String get bpCardTitle => 'Alert thresholds';

  @override
  String get bpCardAbove => 'Above';

  @override
  String get bpCardSystolic => 'Systolic';

  @override
  String get bpCardDiastolic => 'Diastolic';

  @override
  String get bpCardAdd => 'Add';

  @override
  String get bpCardAddedToast => 'BP alert added';

  @override
  String get exerciseGoalTitle => 'Daily step goal';

  @override
  String exerciseGoalSteps(int n) {
    return '$n steps';
  }

  @override
  String get exerciseGoalAdd => 'Add';

  @override
  String get exerciseGoalSaved => 'Exercise goal saved';

  @override
  String get sugarStepMethod => 'Blood sugar';

  @override
  String get sugarStepMethodHint => 'How do you usually check?';

  @override
  String get sugarMethodCgm => 'Continuous monitor (CGM)';

  @override
  String get sugarMethodCgmSub => 'Worn on the arm, automatic';

  @override
  String get sugarMethodManual => 'Manual reading';

  @override
  String get sugarMethodManualSub => 'Finger-prick or entered by hand';

  @override
  String get sugarBluetoothTitle => 'Bluetooth';

  @override
  String get sugarBluetoothHint =>
      'Turn on your meter\'s Bluetooth, then tap the ring';

  @override
  String get sugarBluetoothUnavailable => 'Bluetooth pairing coming soon';

  @override
  String get sugarTimingTitle => 'When to measure';

  @override
  String get sugarTimingHint => 'Pick any that apply';

  @override
  String get sugarTimingNext => 'Next';

  @override
  String get sugarTimingNameFasting => 'Fasting';

  @override
  String get sugarTimingNameAfterBreakfast => 'After breakfast';

  @override
  String get sugarTimingNameAfterLunch => 'After lunch';

  @override
  String get sugarTimingNameAfterDinner => 'After dinner';

  @override
  String get sugarTimingNameBedtime => 'Bedtime';

  @override
  String get sugarTimingNoteFasting => 'Before eating in the morning';

  @override
  String get sugarTimingNoteAfterBreakfast => '2 hours after breakfast';

  @override
  String get sugarTimingNoteAfterLunch => '2 hours after lunch';

  @override
  String get sugarTimingNoteAfterDinner => '2 hours after dinner';

  @override
  String get sugarTimingNoteBedtime => 'Before sleep';

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
  String get sugarTargetTitle => 'Blood sugar targets';

  @override
  String get sugarTargetHint => 'Defaults are fine — just tap Next';

  @override
  String get sugarTargetStandard => 'Standard';

  @override
  String get sugarTargetStandardValue => 'Fasting < 6.1   Post-meal < 7.8';

  @override
  String get sugarTargetStandardNote => 'For higher readings, not diagnosed';

  @override
  String get sugarTargetDiabetic => 'Diabetic standard';

  @override
  String get sugarTargetDiabeticValue => 'Fasting < 7.0   Post-meal < 10.0';

  @override
  String get sugarTargetDiabeticNote => 'Common control targets if diagnosed';

  @override
  String get sugarTargetCustom => 'Custom';

  @override
  String get sugarTargetCustomNote => 'Set per your doctor\'s advice';

  @override
  String get sugarTargetSavedToast => 'Sugar targets saved';

  @override
  String get sugarCustomTitle => 'Custom targets';

  @override
  String get sugarCustomHint => 'Set per your doctor\'s advice';

  @override
  String get sugarCustomFasting => 'Fasting';

  @override
  String get sugarCustomFastingNote => 'Before eating in the morning';

  @override
  String get sugarCustomPost => 'Post-meal';

  @override
  String get sugarCustomPostNote => '2 hours after a meal';

  @override
  String get sugarCustomMinLabel => 'Min';

  @override
  String get sugarCustomMaxLabel => 'Max';

  @override
  String get sugarCustomSave => 'Save settings';

  @override
  String get sugarCustomSavedToast => 'Sugar targets saved';

  @override
  String get dietIntroTitle => 'Track meals';

  @override
  String get dietIntroBody =>
      'Snap a photo of each meal — helps you and family see the link between food and blood sugar.';

  @override
  String get dietIntroCta => 'Get started';

  @override
  String get permissionsTitle => 'A few permissions needed';

  @override
  String get permissionsSubtitle => 'Turn these on so we can support you fully';

  @override
  String get permissionsAllCta => 'Allow all and continue';

  @override
  String get permissionsFootnote => 'You can change these anytime in Settings';

  @override
  String get permissionsNameNotifications => 'Notifications';

  @override
  String get permissionsNoteNotifications => 'Reminders for meds and BP';

  @override
  String get permissionsNameCamera => 'Camera';

  @override
  String get permissionsNoteCamera => 'Photo logging of meals';

  @override
  String get permissionsNameHealth => 'Health data';

  @override
  String get permissionsNoteHealth => 'Read step count automatically';

  @override
  String get permissionsNameBluetooth => 'Bluetooth';

  @override
  String get permissionsNoteBluetooth => 'Connect to your meter';

  @override
  String get setupCompleteTitle => 'You\'re all set!';

  @override
  String get setupCompleteCta => 'Start using';

  @override
  String get setupRemindersHeading => 'Today\'s reminders';

  @override
  String setupReminderMed(String medName) {
    return 'Take 1 $medName (alarm set)';
  }

  @override
  String get setupReminderBp => 'Measure BP (rest first)';

  @override
  String get setupReminderLunch => 'Snap your lunch';

  @override
  String setupReminderSteps(int goal) {
    return 'Goal today: $goal steps';
  }

  @override
  String get setupReminderAllDay => 'All day';
}
