import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../widgets/check_in_card.dart';
import '../widgets/ios_toast.dart';
import '../widgets/record_sheet.dart';

/// Tab 1「今天」：老年用户首页。iOS Large Title + 今日进度 + 5 张打卡卡片。
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key, required this.state});

  final AppState state;

  static const Map<CheckInType, (IconData, String)> _meta = {
    CheckInType.medication: (CupertinoIcons.staroflife_fill, '用药'),
    CheckInType.bloodPressure: (CupertinoIcons.heart_fill, '血压'),
    CheckInType.bloodSugar: (CupertinoIcons.drop_fill, '血糖'),
    CheckInType.diet: (Icons.restaurant, '饮食'),
    CheckInType.exercise: (CupertinoIcons.flame_fill, '运动'),
  };

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 11) return '早上好';
    if (hour < 14) return '中午好';
    if (hour < 18) return '下午好';
    return '晚上好';
  }

  String get _dateText {
    final now = DateTime.now();
    const weekdays = ['一', '二', '三', '四', '五', '六', '日'];
    return '${now.month}月${now.day}日 星期${weekdays[now.weekday - 1]}';
  }

  Future<void> _openRecord(BuildContext context, CheckInRecord record) async {
    if (record.done) {
      showIosToast(context, '今天已经打过卡啦');
      return;
    }
    final done = await showRecordSheet(context, state, record.type);
    if (done == true && context.mounted) {
      showIosToast(context, '已记录，真棒！');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final textTheme = Theme.of(context).textTheme;
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppDimens.pagePadding),
            children: [
              // iOS Large Title：34pt 粗体左对齐大标题 + 问候副标题
              Text('今天', style: textTheme.displayMedium),
              const SizedBox(height: AppDimens.spaceXs),
              Text(
                '$_greeting，王奶奶 · $_dateText',
                style: textTheme.bodyLarge
                    ?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppDimens.spaceMd),
              _buildProgress(context),
              const SizedBox(height: AppDimens.spaceMd),
              for (final record in state.records) ...[
                CheckInCard(
                  icon: _meta[record.type]!.$1,
                  title: _meta[record.type]!.$2,
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

  Widget _buildProgress(BuildContext context) {
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
                  Text('今日进度', style: textTheme.titleMedium),
                  const SizedBox(height: AppDimens.spaceXs),
                  Text(
                    allDone ? '今天全部完成，真棒！' : '已完成 $done 项，还差 ${total - done} 项',
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
