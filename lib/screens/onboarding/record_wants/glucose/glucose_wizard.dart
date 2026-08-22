/// 血糖卡片内嵌向导：按当前步骤切换各步骤页面，并提供共用的步骤标题行。
library;

import 'package:flutter/material.dart';

import '../../../../state/app_state.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_dimens.dart';
import 'bluetooth_step.dart';
import 'custom_step.dart';
import 'method_step.dart';
import 'target_step.dart';
import 'timing_step.dart';

/// 血糖展开：卡内三步向导（45:228 测量方式 → 56:12 测量时段 → 69:193 血糖目标），
/// 步骤由 RecordWantsPage 持有，标题栏显示面包屑与返回箭头。
class GlucoseWizard extends StatelessWidget {
  const GlucoseWizard({
    super.key,
    required this.state,
    required this.step,
    required this.onStep,
  });

  final AppState state;
  final String step;
  final ValueChanged<String> onStep;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) => switch (step) {
        'method' => GlucoseMethodStep(state: state, onStep: onStep),
        'bluetooth' => const BluetoothStep(),
        'timing' => GlucoseTimingStep(state: state, onStep: onStep),
        'custom' => GlucoseCustomStep(state: state, onStep: onStep),
        _ => GlucoseTargetStep(state: state, onStep: onStep),
      },
    );
  }
}

/// 向导步骤标题行：左粗体白字 + 右侧提示小字（Figma 各步骤头部）。
class StepHeader extends StatelessWidget {
  const StepHeader(this.title, this.hint, {super.key});

  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          title,
          style: textTheme.titleLarge?.copyWith(color: AppColors.bgCard),
        ),
        const SizedBox(width: AppDimens.spaceSm),
        Expanded(
          child: Text(
            hint,
            textAlign: TextAlign.right,
            style: textTheme.bodySmall?.copyWith(color: AppColors.bgCard),
          ),
        ),
      ],
    );
  }
}
