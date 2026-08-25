import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../theme/app_dimens.dart';
import '../widgets/trend_chart.dart';

/// Tab 2「趋势」：家属视角，最近 7 天血压 / 血糖图表（demo 数据）。
class TrendsScreen extends StatelessWidget {
  const TrendsScreen({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        children: [
          Text(l.tabTrends, style: textTheme.displayMedium),
          const SizedBox(height: AppDimens.spaceXs),
          Text(l.trendsSubtitle, style: textTheme.bodyMedium),
          const SizedBox(height: AppDimens.spaceMd),
          _TrendCard(
            title: l.trendsBpTitle,
            rangeText: l.trendsBpRange,
            summary: l.trendsBpSummary,
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
            title: l.trendsGlucoseTitle,
            rangeText: l.trendsGlucoseRange,
            summary: l.trendsGlucoseSummary,
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