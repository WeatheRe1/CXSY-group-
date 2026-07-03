import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hello_personalized/main.dart';

void main() {
  testWidgets('group topic page renders and evidence button works',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GroupTopicApp());

    expect(find.text('创新实验三 · 小组专题网站'), findsOneWidget);
    expect(find.text('小组专题网站运行展示'), findsOneWidget);
    expect(find.text('3 / 8'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.check_rounded));
    await tester.pump();

    expect(find.text('4 / 8'), findsOneWidget);
  });
}
