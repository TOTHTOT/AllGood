import 'package:flutter_test/flutter_test.dart';

import 'package:all_good/main.dart';
import 'package:all_good/state/app_state.dart';

void main() {
  testWidgets('首页展示问候、进度与打卡卡片', (WidgetTester tester) async {
    await tester.pumpWidget(AllGoodApp(state: AppState()));

    // 今日进度与未完成的打卡按钮
    expect(find.text('今日进度'), findsOneWidget);
    expect(find.text('打卡'), findsWidgets);

    // 底部三个 Tab（「今天」同时是大标题，允许多处）
    expect(find.text('今天'), findsWidgets);
    expect(find.text('趋势'), findsOneWidget);
    expect(find.text('家人'), findsOneWidget);
  });
}
