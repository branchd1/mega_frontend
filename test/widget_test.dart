
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mega/components/my_dialog.dart';

/// test widgets
void main() {
  group('MyDialog', (){
    testWidgets('Test MyDialog needs the appropriate arguments', (WidgetTester tester) async {
      final text = 'Test';

      await tester.pumpWidget( MaterialApp(
        home: MyDialog(title: text, subtitle: text,),
      ));

      final titleFinder = find.byType(MyDialog);

      expect(titleFinder, findsOneWidget);
    });
  });

  group('MyDialog', (){
    testWidgets('Test MyDialog needs the appropriate arguments', (WidgetTester tester) async {
      final text = 'Test';

      await tester.pumpWidget( MaterialApp(
        home: MyDialog(title: text, subtitle: text,),
      ));

      final titleFinder = find.byType(MyDialog);

      expect(titleFinder, findsOneWidget);
    });
  });
}