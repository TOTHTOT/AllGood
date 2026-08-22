import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../widgets/apple_button.dart';
import 'finish_pages.dart';
import 'onboarding_widgets.dart';
import 'record_wants/blood_pressure_card.dart';
import 'record_wants/card_stack.dart';
import 'record_wants/exercise_card.dart';
import 'record_wants/glucose/glucose_wizard.dart';

/// 44:199「我想要记录」：手风琴卡片堆叠——血压（深石板蓝）/
/// 血糖（中蓝）/ 运动信息（浅蓝），点击展开。
class RecordWantsPage extends StatefulWidget {
  const RecordWantsPage({super.key, required this.state});

  final AppState state;

  @override
  State<RecordWantsPage> createState() => _RecordWantsPageState();
}

class _RecordWantsPageState extends State<RecordWantsPage> {
  // 默认展开第一张卡（血压）；任何时候总保持一张卡展开，不出现空堆叠。
  String _expanded = '血压';

  /// 血糖卡内嵌向导的当前步骤下标（步骤流见 _glucoseFlow）。
  int _glucoseStep = 0;

  /// 步骤流：CGM 比手动多一步蓝牙配对；「自定义目标」由目标页选择后进入。
  List<String> get _glucoseFlow => [
    'method',
    if (widget.state.glucoseMethod == GlucoseMethod.cgm) 'bluetooth',
    'timing',
    'target',
    'custom',
  ];

  String get _glucoseStepName =>
      _glucoseFlow[_glucoseStep.clamp(0, _glucoseFlow.length - 1)];

  /// 点击卡片标题切换展开；点已展开的卡不收起（避免整页空白）。
  void _toggle(String key) => setState(() {
    if (_expanded != key) _expanded = key;
  });

  void _glucoseGo(String step) =>
      setState(() => _glucoseStep = _glucoseFlow.indexOf(step));

  /// 血糖卡标题栏右上圆圈箭头的行为：向导中回退一步；已在第一步则无操作。
  void _glucoseBack() => setState(() {
    if (_glucoseStep > 0) _glucoseStep--;
  });

  /// 面包屑小字（Figma 标题栏：蓝牙帧为「蓝牙配对」，目标帧为已完成步骤）。
  String? get _glucoseBreadcrumb => switch (_glucoseStepName) {
    'bluetooth' => '蓝牙配对',
    'timing' => '血糖测量',
    'target' => '血糖测量/测量时段',
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // 堆叠参数：收起高 88，每张卡向上叠 24（露出圆角，形成"一摞卡"观感）。
    const collapsedH = 88.0;
    const overlap = 24.0;
    // Figma 原稿卡片通栏（x=0 满宽、延伸出下边缘），只有标题行保留页面边距；
    // scroll: false + Expanded 让堆叠区自动填满标题以下的全部空间。
    return OnboardingScaffold(
      title: null,
      scroll: false,
      safeBottom: false,
      contentPadding: const EdgeInsets.only(top: AppDimens.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.pagePadding,
            ),
            child: Row(
              children: [
                Text(
                  '我想要记录',
                  style: textTheme.displayMedium?.copyWith(
                    color: AppColors.slate,
                  ),
                ),
                const SizedBox(width: AppDimens.spaceXs),
                // 标题旁的圆圈箭头即「下一步」（Figma 原稿即此交互）。
                Pressable(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => DietIntroPage(state: widget.state),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(AppDimens.spaceXs),
                    child: Icon(
                      CupertinoIcons.arrow_right_circle,
                      color: AppColors.accent,
                      size: AppDimens.iconLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.spaceMd),
          Expanded(
            child: CardStack(
              expanded: _expanded,
              collapsedHeight: collapsedH,
              overlap: overlap,
              onToggle: _toggle,
              children: {
                '血压': BloodPressureCard(state: widget.state),
                '血糖': GlucoseWizard(
                  state: widget.state,
                  step: _glucoseStepName,
                  onStep: _glucoseGo,
                ),
                '运动信息': ExerciseCard(state: widget.state),
              },
              // 收起时的各自底色（展开时统一变浅蓝，血糖为面板蓝，见 _CardStack）。
              colors: const {
                '血压': AppColors.slate,
                '血糖': AppColors.blueMid,
                '运动信息': AppColors.slate,
              },
              breadcrumbs: {'血糖': _glucoseBreadcrumb},
              backActions: {if (_expanded == '血糖') '血糖': _glucoseBack},
              scrollKeys: {'血糖': _glucoseStepName},
            ),
          ),
        ],
      ),
    );
  }
}
