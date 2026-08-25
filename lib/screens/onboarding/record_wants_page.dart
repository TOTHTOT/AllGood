import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
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

/// 内部稳定的卡片 key（不随语言变化）。所有 CardStack 的 children /
/// colors / breadcrumbs / backActions / scrollKeys 都用这个枚举，
/// 只有显示给用户看的 title 走本地化。
enum _CardKey { bloodPressure, bloodSugar, exercise }

class _RecordWantsPageState extends State<RecordWantsPage> {
  /// 当前展开的卡片。切换语言不会影响这个状态，因为本地化只在 build 里
  /// 把 `_CardKey` 翻译成对应语言的标题字符串。
  _CardKey _expanded = _CardKey.bloodPressure;

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
  void _toggle(_CardKey key) => setState(() {
    if (_expanded != key) _expanded = key;
  });

  void _glucoseGo(String step) =>
      setState(() => _glucoseStep = _glucoseFlow.indexOf(step));

  /// 血糖卡标题栏右上圆圈箭头的行为：向导中回退一步；已在第一步则无操作。
  void _glucoseBack() => setState(() {
    if (_glucoseStep > 0) _glucoseStep--;
  });

  /// 面包屑小字（Figma 标题栏：蓝牙帧为「蓝牙配对」，目标帧为已完成步骤）。
  String? get _glucoseBreadcrumb {
    final l = AppLocalizations.of(context);
    return switch (_glucoseStepName) {
      'bluetooth' => l.recordWantsBreadcrumbBluetooth,
      'timing' => l.recordWantsBreadcrumbSugar,
      'target' => l.recordWantsBreadcrumbSugarTiming,
      _ => null,
    };
  }

  String _titleFor(_CardKey k, AppLocalizations l) => switch (k) {
        _CardKey.bloodPressure => l.recordWantsBp,
        _CardKey.bloodSugar => l.recordWantsSugar,
        _CardKey.exercise => l.recordWantsExercise,
      };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    // 堆叠参数：收起高 88，每张卡向上叠 24（露出圆角，形成"一摞卡"观感）。
    const collapsedH = 88.0;
    const overlap = 24.0;
    final sugar = _CardKey.bloodSugar;

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
                  l.recordWantsTitle,
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
              titles: {
                for (final k in _CardKey.values) k: _titleFor(k, l),
              },
              collapsedHeight: collapsedH,
              overlap: overlap,
              onToggle: _toggle,
              children: {
                _CardKey.bloodPressure: BloodPressureCard(state: widget.state),
                _CardKey.bloodSugar: GlucoseWizard(
                  state: widget.state,
                  step: _glucoseStepName,
                  onStep: _glucoseGo,
                ),
                _CardKey.exercise: ExerciseCard(state: widget.state),
              },
              // 收起时的各自底色（展开时统一变浅蓝，血糖为面板蓝，见 _CardStack）。
              colors: {
                _CardKey.bloodPressure: AppColors.slate,
                _CardKey.bloodSugar: AppColors.blueMid,
                _CardKey.exercise: AppColors.slate,
              },
              sugarKey: sugar,
              breadcrumbs: {sugar: _glucoseBreadcrumb},
              backActions: {if (_expanded == sugar) sugar: _glucoseBack},
              scrollKeys: {sugar: _glucoseStepName},
            ),
          ),
        ],
      ),
    );
  }
}