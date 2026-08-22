import 'package:flutter_test/flutter_test.dart';

import 'package:all_good/main.dart';
import 'package:all_good/state/app_state.dart';

void main() {
  testWidgets('启动进入引导初始页，可推进到登录选择', (WidgetTester tester) async {
    await tester.pumpWidget(AllGoodApp(state: AppState()));

    // 初始页（Figma 22:14）
    expect(find.text('今天过得怎么样？'), findsOneWidget);
    expect(find.text('都好！'), findsOneWidget);

    // 进入登录选择（45:213）
    await tester.tap(find.text('都好！'));
    await tester.pumpAndSettle();
    expect(find.text('我没有账号'), findsOneWidget);
    expect(find.text('登陆'), findsOneWidget);

    // 进入注册（42:143）
    await tester.tap(find.text('我没有账号'));
    await tester.pumpAndSettle();
    expect(find.text('注册'), findsOneWidget);
    expect(find.text('让他人设置'), findsOneWidget);
    expect(find.text('自己设置'), findsOneWidget);
  });
}
