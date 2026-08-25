import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// Label on the language toggle button in English mode. Tapping switches to Chinese.
  ///
  /// In en, this message translates to:
  /// **'中'**
  String get languageToggleLabel;

  /// No description provided for @tabToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get tabToday;

  /// No description provided for @tabTrends.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get tabTrends;

  /// No description provided for @tabFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get tabFamily;

  /// No description provided for @todayProgress.
  ///
  /// In en, this message translates to:
  /// **'Today\'s progress'**
  String get todayProgress;

  /// No description provided for @todayAllDone.
  ///
  /// In en, this message translates to:
  /// **'All done for today — well done!'**
  String get todayAllDone;

  /// No description provided for @todayProgressRemaining.
  ///
  /// In en, this message translates to:
  /// **'{done} done · {left} to go'**
  String todayProgressRemaining(int done, int left);

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingNoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingNoon;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @greetingPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get greetingPlaceholder;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'{name}'**
  String greeting(String name);

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'{weekday}, {month}/{day}'**
  String dateLabel(int month, int day, String weekday);

  /// No description provided for @recordButton.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get recordButton;

  /// No description provided for @checkedIn.
  ///
  /// In en, this message translates to:
  /// **'Checked in'**
  String get checkedIn;

  /// No description provided for @abnormalWarning.
  ///
  /// In en, this message translates to:
  /// **'This reading is high — keep an eye on it'**
  String get abnormalWarning;

  /// No description provided for @toastAlreadyDone.
  ///
  /// In en, this message translates to:
  /// **'Already checked in today'**
  String get toastAlreadyDone;

  /// No description provided for @toastRecorded.
  ///
  /// In en, this message translates to:
  /// **'Recorded — well done!'**
  String get toastRecorded;

  /// No description provided for @checkInMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get checkInMedication;

  /// No description provided for @checkInBloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure'**
  String get checkInBloodPressure;

  /// No description provided for @checkInBloodSugar.
  ///
  /// In en, this message translates to:
  /// **'Blood sugar'**
  String get checkInBloodSugar;

  /// No description provided for @checkInDiet.
  ///
  /// In en, this message translates to:
  /// **'Diet'**
  String get checkInDiet;

  /// No description provided for @checkInExercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get checkInExercise;

  /// No description provided for @trendsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get trendsSubtitle;

  /// No description provided for @trendsBpTitle.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure (systolic)'**
  String get trendsBpTitle;

  /// No description provided for @trendsBpRange.
  ///
  /// In en, this message translates to:
  /// **'Normal range 90–140 mmHg'**
  String get trendsBpRange;

  /// No description provided for @trendsBpSummary.
  ///
  /// In en, this message translates to:
  /// **'Mostly steady over the last 7 days; a slight bump on Wednesday, otherwise within range.'**
  String get trendsBpSummary;

  /// No description provided for @trendsGlucoseTitle.
  ///
  /// In en, this message translates to:
  /// **'Blood sugar'**
  String get trendsGlucoseTitle;

  /// No description provided for @trendsGlucoseRange.
  ///
  /// In en, this message translates to:
  /// **'Normal range 3.9–7.8 mmol/L'**
  String get trendsGlucoseRange;

  /// No description provided for @trendsGlucoseSummary.
  ///
  /// In en, this message translates to:
  /// **'Mostly in range. A post-meal spike on Friday — go easy on sweets.'**
  String get trendsGlucoseSummary;

  /// No description provided for @familyWatching.
  ///
  /// In en, this message translates to:
  /// **'Watching: {name} · data shared with consent'**
  String familyWatching(String name);

  /// No description provided for @familyReminder.
  ///
  /// In en, this message translates to:
  /// **'{name} hasn\'t checked in by noon — drop her a line'**
  String familyReminder(String name);

  /// No description provided for @exportButton.
  ///
  /// In en, this message translates to:
  /// **'Export health data'**
  String get exportButton;

  /// No description provided for @exportDemoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Demo only — not available'**
  String get exportDemoUnavailable;

  /// No description provided for @familyTodayHeading.
  ///
  /// In en, this message translates to:
  /// **'Today\'s status'**
  String get familyTodayHeading;

  /// No description provided for @statusDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get statusDone;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @familyWeeklyHeading.
  ///
  /// In en, this message translates to:
  /// **'Weekly summary'**
  String get familyWeeklyHeading;

  /// No description provided for @weeklyAdherence.
  ///
  /// In en, this message translates to:
  /// **'Weekly check-in rate 86%'**
  String get weeklyAdherence;

  /// No description provided for @weeklyBp.
  ///
  /// In en, this message translates to:
  /// **'BP mostly steady; a bump on Wednesday'**
  String get weeklyBp;

  /// No description provided for @weeklyGlucose.
  ///
  /// In en, this message translates to:
  /// **'Occasional post-meal spikes — watch the sweets'**
  String get weeklyGlucose;

  /// No description provided for @weekdayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get weekdayMon;

  /// No description provided for @weekdayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get weekdayTue;

  /// No description provided for @weekdayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get weekdayWed;

  /// No description provided for @weekdayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get weekdayThu;

  /// No description provided for @weekdayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get weekdayFri;

  /// No description provided for @weekdaySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get weekdaySat;

  /// No description provided for @weekdaySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get weekdaySun;

  /// No description provided for @medicationSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Did you take your meds today?'**
  String get medicationSheetTitle;

  /// No description provided for @medicationSheetHint.
  ///
  /// In en, this message translates to:
  /// **'Once after breakfast: 1 blood-pressure pill with warm water.'**
  String get medicationSheetHint;

  /// No description provided for @medicationSummary.
  ///
  /// In en, this message translates to:
  /// **'Took 1 after breakfast, on time'**
  String get medicationSummary;

  /// No description provided for @medicationConfirm.
  ///
  /// In en, this message translates to:
  /// **'Took it'**
  String get medicationConfirm;

  /// No description provided for @medicationDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure pill'**
  String get medicationDefaultName;

  /// No description provided for @bpSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Take blood pressure'**
  String get bpSheetTitle;

  /// No description provided for @bpSheetSubmit.
  ///
  /// In en, this message translates to:
  /// **'Save reading'**
  String get bpSheetSubmit;

  /// No description provided for @bpSystolicLabel.
  ///
  /// In en, this message translates to:
  /// **'Systolic (top)'**
  String get bpSystolicLabel;

  /// No description provided for @bpDiastolicLabel.
  ///
  /// In en, this message translates to:
  /// **'Diastolic (bottom)'**
  String get bpDiastolicLabel;

  /// No description provided for @bpAbnormalHint.
  ///
  /// In en, this message translates to:
  /// **'This isn\'t your usual reading — tell family if you feel off'**
  String get bpAbnormalHint;

  /// No description provided for @bpSummary.
  ///
  /// In en, this message translates to:
  /// **'{sys}/{dia} mmHg'**
  String bpSummary(int sys, int dia);

  /// No description provided for @sugarSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Check blood sugar'**
  String get sugarSheetTitle;

  /// No description provided for @sugarMealQuestion.
  ///
  /// In en, this message translates to:
  /// **'Which meal was this around?'**
  String get sugarMealQuestion;

  /// No description provided for @sugarValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get sugarValueLabel;

  /// No description provided for @sugarAbnormalHint.
  ///
  /// In en, this message translates to:
  /// **'A bit high — go easy on the sweets'**
  String get sugarAbnormalHint;

  /// No description provided for @sugarMealFasting.
  ///
  /// In en, this message translates to:
  /// **'Fasting'**
  String get sugarMealFasting;

  /// No description provided for @sugarMealAfterBreakfast.
  ///
  /// In en, this message translates to:
  /// **'After breakfast'**
  String get sugarMealAfterBreakfast;

  /// No description provided for @sugarMealAfterLunch.
  ///
  /// In en, this message translates to:
  /// **'After lunch'**
  String get sugarMealAfterLunch;

  /// No description provided for @sugarMealAfterDinner.
  ///
  /// In en, this message translates to:
  /// **'After dinner'**
  String get sugarMealAfterDinner;

  /// No description provided for @sugarSummary.
  ///
  /// In en, this message translates to:
  /// **'{meal} {value} mmol/L'**
  String sugarSummary(String meal, String value);

  /// No description provided for @dietSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'What did you eat today?'**
  String get dietSheetTitle;

  /// No description provided for @dietSheetSubmit.
  ///
  /// In en, this message translates to:
  /// **'Save meal'**
  String get dietSheetSubmit;

  /// No description provided for @dietPhotoAdded.
  ///
  /// In en, this message translates to:
  /// **'Photo added'**
  String get dietPhotoAdded;

  /// No description provided for @dietTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get dietTakePhoto;

  /// No description provided for @dietSugarQuestion.
  ///
  /// In en, this message translates to:
  /// **'How sweet was it?'**
  String get dietSugarQuestion;

  /// No description provided for @dietSugarLow.
  ///
  /// In en, this message translates to:
  /// **'Low sugar'**
  String get dietSugarLow;

  /// No description provided for @dietSugarMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get dietSugarMedium;

  /// No description provided for @dietSugarHigh.
  ///
  /// In en, this message translates to:
  /// **'High sugar'**
  String get dietSugarHigh;

  /// No description provided for @dietSummary.
  ///
  /// In en, this message translates to:
  /// **'Lunch · {level}'**
  String dietSummary(String level);

  /// No description provided for @exerciseSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Get moving today'**
  String get exerciseSheetTitle;

  /// No description provided for @exerciseSheetSubmit.
  ///
  /// In en, this message translates to:
  /// **'Sync steps'**
  String get exerciseSheetSubmit;

  /// No description provided for @exerciseAlreadyWalked.
  ///
  /// In en, this message translates to:
  /// **'You\'ve walked'**
  String get exerciseAlreadyWalked;

  /// No description provided for @exerciseStepsUnit.
  ///
  /// In en, this message translates to:
  /// **'steps'**
  String get exerciseStepsUnit;

  /// No description provided for @exerciseHint.
  ///
  /// In en, this message translates to:
  /// **'Tap below to sync steps from your phone'**
  String get exerciseHint;

  /// No description provided for @entryGreeting.
  ///
  /// In en, this message translates to:
  /// **'How are you today?'**
  String get entryGreeting;

  /// No description provided for @entryCta.
  ///
  /// In en, this message translates to:
  /// **'I\'m good!'**
  String get entryCta;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'I have no account'**
  String get loginNoAccount;

  /// No description provided for @loginCta.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginCta;

  /// No description provided for @loginDemoOnly.
  ///
  /// In en, this message translates to:
  /// **'Demo only — please sign up'**
  String get loginDemoOnly;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get registerTitle;

  /// No description provided for @registerHelper.
  ///
  /// In en, this message translates to:
  /// **'Have someone help me'**
  String get registerHelper;

  /// No description provided for @registerSelf.
  ///
  /// In en, this message translates to:
  /// **'Set it up myself'**
  String get registerSelf;

  /// No description provided for @qrTitle.
  ///
  /// In en, this message translates to:
  /// **'Have someone help me'**
  String get qrTitle;

  /// No description provided for @qrScannedCta.
  ///
  /// In en, this message translates to:
  /// **'Family scanned it — continue'**
  String get qrScannedCta;

  /// No description provided for @qrCaption1.
  ///
  /// In en, this message translates to:
  /// **'Scan and help to set it up'**
  String get qrCaption1;

  /// No description provided for @qrCaption2.
  ///
  /// In en, this message translates to:
  /// **'Ask a family member to scan and help finish setup'**
  String get qrCaption2;

  /// No description provided for @infoFormTitleHelper.
  ///
  /// In en, this message translates to:
  /// **'Help set it up'**
  String get infoFormTitleHelper;

  /// No description provided for @infoFormTitleSelf.
  ///
  /// In en, this message translates to:
  /// **'Set it up myself'**
  String get infoFormTitleSelf;

  /// No description provided for @infoNameHint.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get infoNameHint;

  /// No description provided for @infoAgeHint.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get infoAgeHint;

  /// No description provided for @infoGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get infoGenderFemale;

  /// No description provided for @infoGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get infoGenderMale;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @medicationStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get medicationStatusTitle;

  /// No description provided for @medicationNone.
  ///
  /// In en, this message translates to:
  /// **'I do not take any'**
  String get medicationNone;

  /// No description provided for @medicationNeed.
  ///
  /// In en, this message translates to:
  /// **'I take medication'**
  String get medicationNeed;

  /// No description provided for @medicationTapToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap to add'**
  String get medicationTapToAdd;

  /// No description provided for @medicationPhotoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Photo recognition unavailable — use + to add'**
  String get medicationPhotoUnavailable;

  /// No description provided for @medicationCardSummary.
  ///
  /// In en, this message translates to:
  /// **'{name} · {times} times/day · {pills} pills each'**
  String medicationCardSummary(String name, int times, int pills);

  /// No description provided for @medicationDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Medication details'**
  String get medicationDetailTitle;

  /// No description provided for @medicationNameHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to enter name'**
  String get medicationNameHint;

  /// No description provided for @medicationTimesLabel.
  ///
  /// In en, this message translates to:
  /// **'Times per day'**
  String get medicationTimesLabel;

  /// No description provided for @medicationPillsLabel.
  ///
  /// In en, this message translates to:
  /// **'Pills each time'**
  String get medicationPillsLabel;

  /// No description provided for @medicationTimesUnit.
  ///
  /// In en, this message translates to:
  /// **'x'**
  String get medicationTimesUnit;

  /// No description provided for @medicationPillsUnit.
  ///
  /// In en, this message translates to:
  /// **'pills'**
  String get medicationPillsUnit;

  /// No description provided for @checkInMedicationStatus.
  ///
  /// In en, this message translates to:
  /// **'8:00, 1 dose after breakfast'**
  String get checkInMedicationStatus;

  /// No description provided for @checkInMedicationSummary.
  ///
  /// In en, this message translates to:
  /// **'Took 1 after breakfast, on time'**
  String get checkInMedicationSummary;

  /// No description provided for @checkInBloodPressureStatus.
  ///
  /// In en, this message translates to:
  /// **'Take your blood pressure once in the morning'**
  String get checkInBloodPressureStatus;

  /// No description provided for @checkInBloodSugarStatus.
  ///
  /// In en, this message translates to:
  /// **'Check your blood sugar after a meal'**
  String get checkInBloodSugarStatus;

  /// No description provided for @checkInDietStatus.
  ///
  /// In en, this message translates to:
  /// **'Snap a photo of today\'s meals'**
  String get checkInDietStatus;

  /// No description provided for @checkInExerciseStatus.
  ///
  /// In en, this message translates to:
  /// **'Take a short walk and stretch'**
  String get checkInExerciseStatus;

  /// No description provided for @recordWantsTitle.
  ///
  /// In en, this message translates to:
  /// **'What I want to track'**
  String get recordWantsTitle;

  /// No description provided for @recordWantsBp.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure'**
  String get recordWantsBp;

  /// No description provided for @recordWantsSugar.
  ///
  /// In en, this message translates to:
  /// **'Blood sugar'**
  String get recordWantsSugar;

  /// No description provided for @recordWantsExercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get recordWantsExercise;

  /// No description provided for @recordWantsBreadcrumbBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth pairing'**
  String get recordWantsBreadcrumbBluetooth;

  /// No description provided for @recordWantsBreadcrumbSugar.
  ///
  /// In en, this message translates to:
  /// **'Blood sugar'**
  String get recordWantsBreadcrumbSugar;

  /// No description provided for @recordWantsBreadcrumbSugarTiming.
  ///
  /// In en, this message translates to:
  /// **'Blood sugar / When'**
  String get recordWantsBreadcrumbSugarTiming;

  /// No description provided for @bpCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Alert thresholds'**
  String get bpCardTitle;

  /// No description provided for @bpCardAbove.
  ///
  /// In en, this message translates to:
  /// **'Above'**
  String get bpCardAbove;

  /// No description provided for @bpCardSystolic.
  ///
  /// In en, this message translates to:
  /// **'Systolic'**
  String get bpCardSystolic;

  /// No description provided for @bpCardDiastolic.
  ///
  /// In en, this message translates to:
  /// **'Diastolic'**
  String get bpCardDiastolic;

  /// No description provided for @bpCardAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get bpCardAdd;

  /// No description provided for @bpCardAddedToast.
  ///
  /// In en, this message translates to:
  /// **'BP alert added'**
  String get bpCardAddedToast;

  /// No description provided for @exerciseGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily step goal'**
  String get exerciseGoalTitle;

  /// No description provided for @exerciseGoalSteps.
  ///
  /// In en, this message translates to:
  /// **'{n} steps'**
  String exerciseGoalSteps(int n);

  /// No description provided for @exerciseGoalAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get exerciseGoalAdd;

  /// No description provided for @exerciseGoalSaved.
  ///
  /// In en, this message translates to:
  /// **'Exercise goal saved'**
  String get exerciseGoalSaved;

  /// No description provided for @sugarStepMethod.
  ///
  /// In en, this message translates to:
  /// **'Blood sugar'**
  String get sugarStepMethod;

  /// No description provided for @sugarStepMethodHint.
  ///
  /// In en, this message translates to:
  /// **'How do you usually check?'**
  String get sugarStepMethodHint;

  /// No description provided for @sugarMethodCgm.
  ///
  /// In en, this message translates to:
  /// **'Continuous monitor (CGM)'**
  String get sugarMethodCgm;

  /// No description provided for @sugarMethodCgmSub.
  ///
  /// In en, this message translates to:
  /// **'Worn on the arm, automatic'**
  String get sugarMethodCgmSub;

  /// No description provided for @sugarMethodManual.
  ///
  /// In en, this message translates to:
  /// **'Manual reading'**
  String get sugarMethodManual;

  /// No description provided for @sugarMethodManualSub.
  ///
  /// In en, this message translates to:
  /// **'Finger-prick or entered by hand'**
  String get sugarMethodManualSub;

  /// No description provided for @sugarBluetoothTitle.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get sugarBluetoothTitle;

  /// No description provided for @sugarBluetoothHint.
  ///
  /// In en, this message translates to:
  /// **'Turn on your meter\'s Bluetooth, then tap the ring'**
  String get sugarBluetoothHint;

  /// No description provided for @sugarBluetoothUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth pairing coming soon'**
  String get sugarBluetoothUnavailable;

  /// No description provided for @sugarTimingTitle.
  ///
  /// In en, this message translates to:
  /// **'When to measure'**
  String get sugarTimingTitle;

  /// No description provided for @sugarTimingHint.
  ///
  /// In en, this message translates to:
  /// **'Pick any that apply'**
  String get sugarTimingHint;

  /// No description provided for @sugarTimingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get sugarTimingNext;

  /// No description provided for @sugarTimingNameFasting.
  ///
  /// In en, this message translates to:
  /// **'Fasting'**
  String get sugarTimingNameFasting;

  /// No description provided for @sugarTimingNameAfterBreakfast.
  ///
  /// In en, this message translates to:
  /// **'After breakfast'**
  String get sugarTimingNameAfterBreakfast;

  /// No description provided for @sugarTimingNameAfterLunch.
  ///
  /// In en, this message translates to:
  /// **'After lunch'**
  String get sugarTimingNameAfterLunch;

  /// No description provided for @sugarTimingNameAfterDinner.
  ///
  /// In en, this message translates to:
  /// **'After dinner'**
  String get sugarTimingNameAfterDinner;

  /// No description provided for @sugarTimingNameBedtime.
  ///
  /// In en, this message translates to:
  /// **'Bedtime'**
  String get sugarTimingNameBedtime;

  /// No description provided for @sugarTimingNoteFasting.
  ///
  /// In en, this message translates to:
  /// **'Before eating in the morning'**
  String get sugarTimingNoteFasting;

  /// No description provided for @sugarTimingNoteAfterBreakfast.
  ///
  /// In en, this message translates to:
  /// **'2 hours after breakfast'**
  String get sugarTimingNoteAfterBreakfast;

  /// No description provided for @sugarTimingNoteAfterLunch.
  ///
  /// In en, this message translates to:
  /// **'2 hours after lunch'**
  String get sugarTimingNoteAfterLunch;

  /// No description provided for @sugarTimingNoteAfterDinner.
  ///
  /// In en, this message translates to:
  /// **'2 hours after dinner'**
  String get sugarTimingNoteAfterDinner;

  /// No description provided for @sugarTimingNoteBedtime.
  ///
  /// In en, this message translates to:
  /// **'Before sleep'**
  String get sugarTimingNoteBedtime;

  /// No description provided for @sugarTimingTime1.
  ///
  /// In en, this message translates to:
  /// **'07:00'**
  String get sugarTimingTime1;

  /// No description provided for @sugarTimingTime2.
  ///
  /// In en, this message translates to:
  /// **'09:00'**
  String get sugarTimingTime2;

  /// No description provided for @sugarTimingTime3.
  ///
  /// In en, this message translates to:
  /// **'14:00'**
  String get sugarTimingTime3;

  /// No description provided for @sugarTimingTime4.
  ///
  /// In en, this message translates to:
  /// **'20:00'**
  String get sugarTimingTime4;

  /// No description provided for @sugarTimingTime5.
  ///
  /// In en, this message translates to:
  /// **'21:30'**
  String get sugarTimingTime5;

  /// No description provided for @sugarTargetTitle.
  ///
  /// In en, this message translates to:
  /// **'Blood sugar targets'**
  String get sugarTargetTitle;

  /// No description provided for @sugarTargetHint.
  ///
  /// In en, this message translates to:
  /// **'Defaults are fine — just tap Next'**
  String get sugarTargetHint;

  /// No description provided for @sugarTargetStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get sugarTargetStandard;

  /// No description provided for @sugarTargetStandardValue.
  ///
  /// In en, this message translates to:
  /// **'Fasting < 6.1   Post-meal < 7.8'**
  String get sugarTargetStandardValue;

  /// No description provided for @sugarTargetStandardNote.
  ///
  /// In en, this message translates to:
  /// **'For higher readings, not diagnosed'**
  String get sugarTargetStandardNote;

  /// No description provided for @sugarTargetDiabetic.
  ///
  /// In en, this message translates to:
  /// **'Diabetic standard'**
  String get sugarTargetDiabetic;

  /// No description provided for @sugarTargetDiabeticValue.
  ///
  /// In en, this message translates to:
  /// **'Fasting < 7.0   Post-meal < 10.0'**
  String get sugarTargetDiabeticValue;

  /// No description provided for @sugarTargetDiabeticNote.
  ///
  /// In en, this message translates to:
  /// **'Common control targets if diagnosed'**
  String get sugarTargetDiabeticNote;

  /// No description provided for @sugarTargetCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get sugarTargetCustom;

  /// No description provided for @sugarTargetCustomNote.
  ///
  /// In en, this message translates to:
  /// **'Set per your doctor\'s advice'**
  String get sugarTargetCustomNote;

  /// No description provided for @sugarTargetSavedToast.
  ///
  /// In en, this message translates to:
  /// **'Sugar targets saved'**
  String get sugarTargetSavedToast;

  /// No description provided for @sugarCustomTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom targets'**
  String get sugarCustomTitle;

  /// No description provided for @sugarCustomHint.
  ///
  /// In en, this message translates to:
  /// **'Set per your doctor\'s advice'**
  String get sugarCustomHint;

  /// No description provided for @sugarCustomFasting.
  ///
  /// In en, this message translates to:
  /// **'Fasting'**
  String get sugarCustomFasting;

  /// No description provided for @sugarCustomFastingNote.
  ///
  /// In en, this message translates to:
  /// **'Before eating in the morning'**
  String get sugarCustomFastingNote;

  /// No description provided for @sugarCustomPost.
  ///
  /// In en, this message translates to:
  /// **'Post-meal'**
  String get sugarCustomPost;

  /// No description provided for @sugarCustomPostNote.
  ///
  /// In en, this message translates to:
  /// **'2 hours after a meal'**
  String get sugarCustomPostNote;

  /// No description provided for @sugarCustomMinLabel.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get sugarCustomMinLabel;

  /// No description provided for @sugarCustomMaxLabel.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get sugarCustomMaxLabel;

  /// No description provided for @sugarCustomSave.
  ///
  /// In en, this message translates to:
  /// **'Save settings'**
  String get sugarCustomSave;

  /// No description provided for @sugarCustomSavedToast.
  ///
  /// In en, this message translates to:
  /// **'Sugar targets saved'**
  String get sugarCustomSavedToast;

  /// No description provided for @dietIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Track meals'**
  String get dietIntroTitle;

  /// No description provided for @dietIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Snap a photo of each meal — helps you and family see the link between food and blood sugar.'**
  String get dietIntroBody;

  /// No description provided for @dietIntroCta.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get dietIntroCta;

  /// No description provided for @permissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'A few permissions needed'**
  String get permissionsTitle;

  /// No description provided for @permissionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Turn these on so we can support you fully'**
  String get permissionsSubtitle;

  /// No description provided for @permissionsAllCta.
  ///
  /// In en, this message translates to:
  /// **'Allow all and continue'**
  String get permissionsAllCta;

  /// No description provided for @permissionsFootnote.
  ///
  /// In en, this message translates to:
  /// **'You can change these anytime in Settings'**
  String get permissionsFootnote;

  /// No description provided for @permissionsNameNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get permissionsNameNotifications;

  /// No description provided for @permissionsNoteNotifications.
  ///
  /// In en, this message translates to:
  /// **'Reminders for meds and BP'**
  String get permissionsNoteNotifications;

  /// No description provided for @permissionsNameCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get permissionsNameCamera;

  /// No description provided for @permissionsNoteCamera.
  ///
  /// In en, this message translates to:
  /// **'Photo logging of meals'**
  String get permissionsNoteCamera;

  /// No description provided for @permissionsNameHealth.
  ///
  /// In en, this message translates to:
  /// **'Health data'**
  String get permissionsNameHealth;

  /// No description provided for @permissionsNoteHealth.
  ///
  /// In en, this message translates to:
  /// **'Read step count automatically'**
  String get permissionsNoteHealth;

  /// No description provided for @permissionsNameBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get permissionsNameBluetooth;

  /// No description provided for @permissionsNoteBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Connect to your meter'**
  String get permissionsNoteBluetooth;

  /// No description provided for @setupCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re all set!'**
  String get setupCompleteTitle;

  /// No description provided for @setupCompleteCta.
  ///
  /// In en, this message translates to:
  /// **'Start using'**
  String get setupCompleteCta;

  /// No description provided for @setupRemindersHeading.
  ///
  /// In en, this message translates to:
  /// **'Today\'s reminders'**
  String get setupRemindersHeading;

  /// No description provided for @setupReminderMed.
  ///
  /// In en, this message translates to:
  /// **'Take 1 {medName} (alarm set)'**
  String setupReminderMed(String medName);

  /// No description provided for @setupReminderBp.
  ///
  /// In en, this message translates to:
  /// **'Measure BP (rest first)'**
  String get setupReminderBp;

  /// No description provided for @setupReminderLunch.
  ///
  /// In en, this message translates to:
  /// **'Snap your lunch'**
  String get setupReminderLunch;

  /// No description provided for @setupReminderSteps.
  ///
  /// In en, this message translates to:
  /// **'Goal today: {goal} steps'**
  String setupReminderSteps(int goal);

  /// No description provided for @setupReminderAllDay.
  ///
  /// In en, this message translates to:
  /// **'All day'**
  String get setupReminderAllDay;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
