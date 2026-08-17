import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_dimens.dart';
import '../widgets/trend_chart.dart';

/// Tab 2「趋势」：家属视角，最近 7 天血压 / 血糖图表（demo 数据）。
class TrendsScreen extends StatelessWidget {
  const TrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        children: [
          Text('趋势', style: textTheme.displayMedium),
          const SizedBox(height: AppDimens.spaceXs),
          Text('最近 7 天', style: textTheme.bodyMedium),
          const SizedBox(height: AppDimens.spaceMd),
          _TrendCard(
            title: '血压（高压）',
            rangeText: '正常范围 90–140 mmHg',
            summary: '最近 7 天血压大体平稳，周三略偏高，其余都在正常范围。',
            chart: const TrendBarChart(
              data: AppState.systolicWeek,
              normalMin: AppState.systolicMin,
              normalMax: AppState.systolicMax,
              minValue: 60,
              maxValue: 180,
            ),
          ),
          const SizedBox(height: AppDimens.cardGap),
          _TrendCard(
            title: '血糖',
            rangeText: '正常范围 3.9–7.8 mmol/L',
            summary: '血糖大多正常，周五餐后偏高，甜食要少吃一点。',
            chart: const TrendBarChart(
              data: AppState.glucoseWeek,
              normalMin: AppState.glucoseMin,
              normalMax: AppState.glucoseMax,
              minValue: 2,
              maxValue: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard({
    required this.title,
    required this.rangeText,
    required this.summary,
    required this.chart,
  });

  final String title;
  final String rangeText;
  final String summary;
  final Widget chart;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textTheme.headlineMedium),
            const SizedBox(height: AppDimens.spaceXs),
            Text(rangeText, style: textTheme.bodyMedium),
            const SizedBox(height: AppDimens.spaceSm),
            chart,
            const SizedBox(height: AppDimens.spaceSm),
            Text(summary, style: textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
