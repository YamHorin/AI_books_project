// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:pjbooks/main.dart' as app;

// //test 3 functional testing
// making a sequel to a story

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('test make sequel book - original book is found ', (WidgetTester tester) async {

    app.main();

// Simulate 3 seconds passing for Future.delayed
    await tester.pump(const Duration(seconds: 3));

    const book  = "Door to Door";
    const String email = "yam@smail.com";
    const String password ="yamking113";

    const skipButtonKey = Key('keySkip');
    const signInKeyFirstScreen = Key('sign in');
    const emailKey = Key('email_key');
    const passwordKey = Key('password_key');
    const signInKeyLoginScreen = Key('sign_in_key_login_screen');
    const searchKey = Key("search");
    const searchInputKey = Key("search_text_input");
    const keyMenu = Key("menu");
    const keyAssistance = Key("Sequel to Story");
    const keyMakeSequel = Key("make sequel");
    await tester.pumpAndSettle(); // Wait for all UI to settle

    //tap on skip
    print("Tapping skip");
    expect(find.byKey(Key('keySkip')), findsOneWidget); // Add this check

    await tester.tap(find.byKey(skipButtonKey));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    //tap on sign in
    await tester.pumpAndSettle(); // Wait for all UI to settle
    await tester.tap(find.byKey(signInKeyFirstScreen));
    await tester.pumpAndSettle();
    //tap on email
    await tester.tap(find.byKey(emailKey));

    //put email

    await  tester.enterText(find.byKey(emailKey), email);

    //tap on password

    await tester.tap(find.byKey(passwordKey));

    //put password
    await tester.enterText(find.byKey(passwordKey), password);

    //enter done
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(Key('sign_in_key_login_screen')));

    //tap on sign in
    await tester.pumpAndSettle();
    print("Tapping sign in 1");

    await tester.tap(find.byKey(signInKeyLoginScreen));
    await tester.pump(const Duration(seconds: 5));
    print("Tapping sign in 2 ");


    await tester.tap(find.byKey(signInKeyLoginScreen));
    await tester.pump(const Duration(seconds: 5));


    //assert we are in the main screen
    expect(find.text('Our Top Picks'), findsOneWidget);
    //go to main
    await tester.tap(find.byKey(keyMenu));
    await tester.pump(const Duration(seconds: 5));

    //go to 3 option
    await tester.tap(find.byKey(keyAssistance));
    await tester.pump(const Duration(seconds: 2));



    await tester.tap(find.byKey(searchKey));



    await tester.pump(const Duration(seconds: 5));

      await tester.pump(const Duration(seconds: 5));

      await tester.tap(find.byKey(searchInputKey));
      await tester.pump(const Duration(seconds: 5));
      //enetr book name
      await tester.enterText(find.byKey(searchInputKey), book);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      //press on the result
      var keyBook = Key("book_$book");

      expect(find.text(book), findsOneWidget);

      await tester.pump(const Duration(seconds: 5));

      await tester.tap(find.byKey(keyBook));

      await tester.pump(const Duration(seconds: 5));

      await tester.tap(find.byKey(keyBook));
      //check if there is book
      expect(find.text(book), findsOneWidget);
      //tap on make sequel
    await tester.tap(find.byKey(keyMakeSequel));

    await tester.pump(const Duration(seconds: 5));

    //try to find error widget
    final textFinder = find.text("Error book was not form");
    final textWidget = tester.widget<Text>(textFinder);
    final String value = textWidget.data ?? '';
    if (value != "") {
      fail("book was form , test fail");
    }



  });


  testWidgets('test make sequel book - original book is not found ', (WidgetTester tester) async {

    app.main();

// Simulate 3 seconds passing for Future.delayed
    await tester.pump(const Duration(seconds: 3));

    const book  = "Door to Door";
    const String email = "yam@smail.com";
    const String password ="yamking113";

    const skipButtonKey = Key('keySkip');
    const signInKeyFirstScreen = Key('sign in');
    const emailKey = Key('email_key');
    const passwordKey = Key('password_key');
    const signInKeyLoginScreen = Key('sign_in_key_login_screen');
    const searchKey = Key("search");
    const searchInputKey = Key("search_text_input");
    const keyMenu = Key("menu");
    const keyAssistance = Key("Sequel to Story");
    await tester.pumpAndSettle(); // Wait for all UI to settle

    //tap on skip
    print("Tapping skip");
    expect(find.byKey(Key('keySkip')), findsOneWidget); // Add this check

    await tester.tap(find.byKey(skipButtonKey));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    //tap on sign in
    await tester.pumpAndSettle(); // Wait for all UI to settle
    await tester.tap(find.byKey(signInKeyFirstScreen));
    await tester.pumpAndSettle();
    //tap on email
    await tester.tap(find.byKey(emailKey));

    //put email

    await  tester.enterText(find.byKey(emailKey), email);

    //tap on password

    await tester.tap(find.byKey(passwordKey));

    //put password
    await tester.enterText(find.byKey(passwordKey), password);

    //enter done
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(Key('sign_in_key_login_screen')));

    //tap on sign in
    await tester.pumpAndSettle();
    print("Tapping sign in 1");

    await tester.tap(find.byKey(signInKeyLoginScreen));
    await tester.pump(const Duration(seconds: 5));
    print("Tapping sign in 2 ");


    await tester.tap(find.byKey(signInKeyLoginScreen));
    await tester.pump(const Duration(seconds: 5));


    //assert we are in the main screen
    expect(find.text('Our Top Picks'), findsOneWidget);
    //go to main
    await tester.tap(find.byKey(keyMenu));
    await tester.pump(const Duration(seconds: 5));

    //go to 3 option
    await tester.tap(find.byKey(keyAssistance));
    await tester.pump(const Duration(seconds: 2));



    await tester.tap(find.byKey(searchKey));



    await tester.pump(const Duration(seconds: 5));

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.byKey(searchInputKey));
    await tester.pump(const Duration(seconds: 5));
    //enetr book name
    await tester.enterText(find.byKey(searchInputKey), book);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    //press on the result
    var keyBook = Key("book_$book");

    expect(find.text(book), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.byKey(keyBook));

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.byKey(keyBook));


    //try to find error widget
    final textFinder = find.text("Error book was not found");
    final textWidget = tester.widget<Text>(textFinder);
    String value = textWidget.data?? '';

    if (value == "") {
      fail("error was not form  , test fail");
    }



  });
}
