/// 血糖向导蓝牙配对步：大圆环展示，点击提示功能暂未开放。
library;

import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_dimens.dart';
import '../../../../widgets/apple_button.dart';
import '../../../../widgets/ios_toast.dart';

/// 51:30 蓝牙配对步（卡内嵌版）：大圆环 + 「蓝牙」。
/// 蓝牙连接尚未实现，点击圆环仅提示暂未开放。
class BluetoothStep extends StatelessWidget {
  const BluetoothStep({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spaceLg),
      child: Column(
        children: [
          Pressable(
            onTap: () => showIosToast(context, '蓝牙连接暂未开放，敬请期待'),
            child: Container(
              width: 189,
              height: 189,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.slate, width: 7),
              ),
              child: Center(
                child: Container(
                  width: 137,
                  height: 137,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bluetoothInner,
                  ),
                  child: Center(
                    child: Text(
                      '蓝牙',
                      style: textTheme.headlineMedium?.copyWith(
                        color: AppColors.slate,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceSm),
          Text(
            '请打开血糖仪蓝牙，点击圆环连接',
            style: textTheme.bodyMedium?.copyWith(color: AppColors.bgCard),
          ),
        ],
      ),
    );
  }
}
