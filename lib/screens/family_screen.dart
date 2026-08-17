import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../widgets/apple_button.dart';
import '../widgets/gentle_banner.dart';
import '../widgets/ios_toast.dart';

/// Tab 3「家人」：子女 / 照护者视角。
class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key, required this.state});

  final AppState state;

  static const Map<CheckInType, String> _names = {
    CheckInType.medication: '用药',
    CheckInType.bloodPressure: '血压',
    CheckInType.bloodSugar: '血糖',
    CheckInType.diet: '饮食',
    CheckInType.exercise: '运动',
  };

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
              Text('家人', style: textTheme.displayMedium),
              const SizedBox(height: AppDimens.spaceXs),
              Text('正在关注：妈妈 · 数据由妈妈授权共享',
                  style: textTheme.bodyMedium),
              const SizedBox(height: AppDimens.spaceMd),
              const GentleBanner(
                icon: CupertinoIcons.chat_bubble_2_fill,
                text: '妈妈今天中午还没打卡，方便时联系一下她',
              ),
              const SizedBox(height: AppDimens.cardGap),
              _buildTodayStatus(context),
              const SizedBox(height: AppDimens.cardGap),
              _buildWeeklyReport(context),
              const SizedBox(height: AppDimens.spaceMd),
              AppleTintedButton(
                label: '导出健康数据',
                icon: CupertinoIcons.square_arrow_up,
                onPressed: () => showIosToast(context, '演示版本暂未开放'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTodayStatus(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('今天的情况', style: textTheme.headlineMedium),
            const SizedBox(height: AppDimens.spaceSm),
            for (final record in state.records) ...[
              Row(
                children: [
                  Icon(
                    record.done
                        ? CupertinoIcons.checkmark_circle_fill
                        : CupertinoIcons.circle,
                    color:
                        record.done ? AppColors.ok : AppColors.textTertiary,
                  ),
                  const SizedBox(width: AppDimens.spaceSm),
                  Expanded(
                    child: Text(
                      _names[record.type]!,
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    record.done ? '已完成' : '待打卡',
                    style: textTheme.bodyMedium?.copyWith(
                      color: record.done
                          ? AppColors.ok
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              if (record != state.records.last)
                const SizedBox(height: AppDimens.spaceSm),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyReport(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const rows = [
      (CupertinoIcons.checkmark_square_fill, '本周打卡完成率 86%'),
      (CupertinoIcons.heart_fill, '血压大部平稳，周三略偏高'),
      (CupertinoIcons.drop_fill, '餐后血糖偶尔偏高，注意甜食'),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('本周简报', style: textTheme.headlineMedium),
            const SizedBox(height: AppDimens.spaceSm),
            for (final (icon, text) in rows) ...[
              Row(
                children: [
                  Icon(icon, color: AppColors.accent),
                  const SizedBox(width: AppDimens.spaceSm),
                  Expanded(
                    child: Text(text, style: textTheme.bodyLarge),
                  ),
                ],
              ),
              if ((icon, text) != rows.last)
                const SizedBox(height: AppDimens.spaceSm),
            ],
          ],
        ),
      ),
    );
  }
}
