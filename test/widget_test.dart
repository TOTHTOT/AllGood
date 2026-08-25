import 'package:flutter_test/flutter_test.dart';

import 'package:all_good/main.dart';
import 'package:all_good/state/app_state.dart';

void main() {
  testWidgets('启动进入引导初始页，可推进到登录选择', (WidgetTester tester) async {
    await tester.pumpWidget(AllGoodApp(state: AppState()));
    // Localizations delegates resolve asynchronously after the first frame,
    // so pump once more to let the home content mount before asserting.
    await tester.pump();

    // 默认语言为英语：初始页渲染英文文案 + 右上角语言切换入口。
    expect(find.text('How are you today?'), findsOneWidget);
    expect(find.text("I'm good!"), findsOneWidget);
    expect(find.text('中'), findsOneWidget); // 当前为英文，提示可切到「中」

    // 点击右上角语言切换：界面文案应切到中文。
    await tester.tap(find.text('中'));
    await tester.pumpAndSettle();
    expect(find.text('今天过得怎么样？'), findsOneWidget);
    expect(find.text('都好！'), findsOneWidget);
    expect(find.text('EN'), findsOneWidget);

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