import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

/// DESIGN.md 第 6 节「趋势图表」：极简柱状图，自绘（CustomPaint）。
/// 无网格线、无 Y 轴刻度，只有正常范围色带（ok 10%）+ 数据柱；
/// 范围内用 accent，超范围用 danger 并附数值文字。
class TrendBarChart extends StatelessWidget {
  const TrendBarChart({
    super.key,
    required this.data,
    required this.normalMin,
    required this.normalMax,
    required this.minValue,
    required this.maxValue,
  });

  final List<DayReading> data;
  final double normalMin;
  final double normalMax;
  final double minValue;
  final double maxValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(
          height: AppDimens.chartHeight,
          width: double.infinity,
          child: CustomPaint(
            painter: _BarChartPainter(
              data: data,
              normalMin: normalMin,
              normalMax: normalMax,
              minValue: minValue,
              maxValue: maxValue,
              labelStyle: textTheme.bodyMedium ?? const TextStyle(),
            ),
          ),
        ),
        const SizedBox(height: AppDimens.spaceXs),
        Row(
          children: [
            for (final day in data)
              Expanded(
                child: Text(
                  day.label,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _BarChartPainter extends CustomPainter {
  _BarChartPainter({
    required this.data,
    required this.normalMin,
    required this.normalMax,
    required this.minValue,
    required this.maxValue,
    required this.labelStyle,
  });

  final List<DayReading> data;
  final double normalMin;
  final double normalMax;
  final double minValue;
  final double maxValue;
  final TextStyle labelStyle;

  static const double _topLabelSpace = 28;

  double _y(double value, double height) {
    final usable = height - _topLabelSpace;
    return _topLabelSpace +
        (maxValue - value) / (maxValue - minValue) * usable;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final slot = size.width / data.length;
    final barWidth = slot * 0.45;

    // 正常范围色带（ok 10% 透明度）
    final bandPaint = Paint()..color = AppColors.okSoft;
    canvas.drawRect(
      Rect.fromLTRB(
        0,
        _y(normalMax, size.height),
        size.width,
        _y(normalMin, size.height),
      ),
      bandPaint,
    );

    final accentPaint = Paint()..color = AppColors.accent;
    final dangerPaint = Paint()..color = AppColors.danger;

    for (var i = 0; i < data.length; i++) {
      final day = data[i];
      final abnormal = day.value < normalMin || day.value > normalMax;
      final centerX = slot * i + slot / 2;
      final top = _y(day.value, size.height);

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTRB(
            centerX - barWidth / 2,
            top,
            centerX + barWidth / 2,
            size.height,
          ),
          topLeft: const Radius.circular(AppDimens.radiusTag),
          topRight: const Radius.circular(AppDimens.radiusTag),
        ),
        abnormal ? dangerPaint : accentPaint,
      );

      // 柱顶数值文字（超范围用 danger 色，不只靠颜色传达）
      final value = day.value;
      final text = value == value.roundToDouble()
          ? value.toInt().toString()
          : value.toStringAsFixed(1);
      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: labelStyle.copyWith(
            color: abnormal ? AppColors.danger : AppColors.textSecondary,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(
        canvas,
        Offset(centerX - painter.width / 2, top - painter.height),
      );
    }
  }

  @override
  bool shouldRepaint(_BarChartPainter oldDelegate) => false;
}
