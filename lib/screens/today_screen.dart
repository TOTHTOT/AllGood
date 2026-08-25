import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../widgets/check_in_card.dart';
import '../widgets/ios_toast.dart';
import '../widgets/record_sheet.dart';

/// Tab 1「今天」：老年用户首页。iOS Large Title + 今日进度 + 5 张打卡卡片。
/// 语言切换入口统一在登录初始页（InitialPage）右上角。
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key, required this.state});

  final AppState state;

  static const Map<CheckInType, IconData> _icons = {
    CheckInType.medication: CupertinoIcons.staroflife_fill,
    CheckInType.bloodPressure: CupertinoIcons.heart_fill,
    CheckInType.bloodSugar: CupertinoIcons.drop_fill,
    CheckInType.diet: Icons.restaurant,
    CheckInType.exercise: CupertinoIcons.flame_fill,
  };

  String _titleOf(AppLocalizations l, CheckInType type) {
    switch (type) {
      case CheckInType.medication:
        return l.checkInMedication;
      case CheckInType.bloodPressure:
        return l.checkInBloodPressure;
      case CheckInType.bloodSugar:
        return l.checkInBloodSugar;
      case CheckInType.diet:
        return l.checkInDiet;
      case CheckInType.exercise:
        return l.checkInExercise;
    }
  }

  String _greeting(AppLocalizations l) {
    final hour = DateTime.now().hour;
    if (hour < 11) return l.greetingMorning;
    if (hour < 14) return l.greetingNoon;
    if (hour < 18) return l.greetingAfternoon;
    return l.greetingEvening;
  }

  String _dateText(AppLocalizations l) {
    final now = DateTime.now();
    // DateTime.weekday is 1=Mon..7=Sun.
    final weekday = switch (now.weekday) {
      DateTime.monday => l.weekdayMon,
      DateTime.tuesday => l.weekdayTue,
      DateTime.wednesday => l.weekdayWed,
      DateTime.thursday => l.weekdayThu,
      DateTime.friday => l.weekdayFri,
      DateTime.saturday => l.weekdaySat,
      _ => l.weekdaySun,
    };
    return l.dateLabel(now.month, now.day, weekday);
  }

  Future<void> _openRecord(BuildContext context, CheckInRecord record) async {
    if (record.done) {
      showIosToast(context, AppLocalizations.of(context).toastAlreadyDone);
      return;
    }
    final done = await showRecordSheet(context, state, record.type);
    if (done == true && context.mounted) {
      showIosToast(context, AppLocalizations.of(context).toastRecorded);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final textTheme = Theme.of(context).textTheme;
        final l = AppLocalizations.of(context);
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppDimens.pagePadding),
            children: [
              // iOS Large Title：34pt 粗体左对齐大标题。
              Text(l.tabToday, style: textTheme.displayMedium),
              const SizedBox(height: AppDimens.spaceXs),
              Text(
                '${_greeting(l)}，${state.displayName} · ${_dateText(l)}',
                style: textTheme.bodyLarge
                    ?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppDimens.spaceMd),
              _buildProgress(context, l),
              const SizedBox(height: AppDimens.spaceMd),
              for (final record in state.records) ...[
                CheckInCard(
                  icon: _icons[record.type]!,
                  title: _titleOf(l, record.type),
                  record: record,
                  onTap: () => _openRecord(context, record),
                ),
                const SizedBox(height: AppDimens.cardGap),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgress(BuildContext context, AppLocalizations l) {
    final textTheme = Theme.of(context).textTheme;
    final done = state.doneCount;
    final total = state.totalCount;
    final allDone = done == total;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.cardPadding),
        child: Row(
          children: [
            SizedBox(
              width: AppDimens.progressRing,
              height: AppDimens.progressRing,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: done / total,
                    strokeWidth: AppDimens.progressRingWidth,
                    color: allDone ? AppColors.ok : AppColors.accent,
                    backgroundColor: AppColors.accentSoft,
                  ),
                  Text('$done/$total', style: textTheme.titleLarge),
                ],
              ),
            ),
            const SizedBox(width: AppDimens.spaceMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.todayProgress, style: textTheme.titleMedium),
                  const SizedBox(height: AppDimens.spaceXs),
                  Text(
                    allDone
                        ? l.todayAllDone
                        : l.todayProgressRemaining(done, total - done),
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}