import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

/// iOS 风格 toast：居中偏下、深色半透明圆角胶囊、白色文字 + 对勾图标，
/// 2 秒后自动消失。
void showIosToast(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _IosToast(message: message, onDone: entry.remove),
  );
  overlay.insert(entry);
}

class _IosToast extends StatefulWidget {
  const _IosToast({required this.message, required this.onDone});

  final String message;
  final VoidCallback onDone;

  @override
  State<_IosToast> createState() => _IosToastState();
}

class _IosToastState extends State<_IosToast> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) setState(() => _opacity = 1);
    });
    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;
      setState(() => _opacity = 0);
      await Future.delayed(const Duration(milliseconds: 250));
      widget.onDone();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 200),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spaceMd,
                vertical: AppDimens.spaceSm,
              ),
              decoration: const BoxDecoration(
                color: AppColors.toastBg,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimens.radiusPill),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    CupertinoIcons.checkmark_circle_fill,
                    color: AppColors.bgCard,
                  ),
                  const SizedBox(width: AppDimens.spaceXs),
                  Flexible(
                    child: Text(
                      widget.message,
                      style: textTheme.bodyLarge
                          ?.copyWith(color: AppColors.bgCard),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
