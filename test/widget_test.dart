
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mega/components/bars/error_snack_bar.dart';
import 'package:mega/components/buttons/my_async_button.dart';
import 'package:mega/components/buttons/my_reset_password_button.dart';
import 'package:mega/components/cards/my_card_grid.dart';
import 'package:mega/components/inputs/my_file_input.dart';
import 'package:mega/components/my_dialog.dart';
import 'package:mega/services/callback_types.dart';

/// test widgets
void main() {
  // test widget loads works the same for all widget
  // No need to repeat tests for all widgets
  testWidgets('Test MyDialog works with appropriate arguments', (WidgetTester tester) async {
    final text = 'Test';

    await tester.pumpWidget( MaterialApp(
      home: MyDialog(title: text, subtitle: text,),
    ));

    final typeFinder = find.byType(MyDialog);

    expect(typeFinder, findsOneWidget);
  });

  testWidgets('Test MyFileInput sets file correctly', (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();

    MyFileInput widget = MyFileInput(controller: controller, hintText: 'Test',);

    expect(widget.controller.text, '');
  });

  group('MyCardGrid', (){
    test('Test that MyCardGrid.getTexts works properly', () {
      List<String> listOfString = ['a', 'b', 'c', 'd'];

      MyCardGrid cardGrid = MyCardGrid(
        list: listOfString,
        emptyText: 'Empty',
        gridTexts: listOfString,
      );

      // test that function returns correct values
      for(int i=0; i<listOfString.length; i++){
        expect(cardGrid.getTexts(i), listOfString[i]);
      }

    });

    test('Test that MyCardGrid.getSubtexts works properly', () {
      List<String> listOfString = ['a', 'b', 'c', 'd'];

      MyCardGrid cardGrid = MyCardGrid(
        list: listOfString,
        emptyText: 'Empty',
        gridSubTexts: listOfString,
      );

      // test that function returns correct values
      for(int i=0; i<listOfString.length; i++){
        expect(cardGrid.getSubtexts(i), listOfString[i]);
      }

    });

    test('Test that MyCardGrid.gridPicturesUrls works properly', () {
      List<String> listOfString = ['a', 'b', 'c', 'd'];

      MyCardGrid cardGrid = MyCardGrid(
        list: listOfString,
        emptyText: 'Empty',
        gridPicturesUrls: listOfString,
      );

      // test that function returns correct values
      for(int i=0; i<listOfString.length; i++){
        expect(cardGrid.getPictureUrl(i), listOfString[i]);
      }

    });
  });

  testWidgets('Test that MyPasswordResetButton is working', (WidgetTester tester) async {

    MyResetPasswordButton button = MyResetPasswordButton(email: 'test@test.com',);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: button,
        ),
      )
    );

    // tap the button
    await tester.tap(find.byWidget(button));

    await tester.pump();

    // popup should be shown
    expect(find.descendant(
        of: find.byType(MaterialApp),
        matching: find.byType(MyDialog)
    ), findsOneWidget);
  });

}