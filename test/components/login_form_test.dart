import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:user_authentication/components/login/login_form.dart';
import 'package:user_authentication/components/login/login_email.dart';
import 'package:user_authentication/components/login/login_password.dart';
import 'package:user_authentication/components/login/login_button.dart';

void main() {
  testWidgets('LoginForm - invalid email validation',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LoginForm(),
      ),
    ));

    // Find the email input field and password field
    var emailField = find.byType(EmailInput);
    var passwordField = find.byType(PasswordInput);

    // Enter invalid email
    await tester.enterText(emailField, 'invalidEmail');
    await tester.enterText(passwordField, 'validPassword');

    // Tap the login button and trigger a frame
    await tester.tap(find.byType(LoginButton));
    await tester.pump();

    // Expect an error message
    expect(find.text('Please enter a valid Email'), findsOneWidget);
  });

  testWidgets('LoginForm - empty password validation',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LoginForm(),
      ),
    ));

    // Find the email input field and password field
    var emailField = find.byType(EmailInput);
    var passwordField = find.byType(PasswordInput);

    // Enter valid email and empty password
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, '');

    // Tap the login button and trigger a frame
    await tester.tap(find.byType(LoginButton));
    await tester.pump();

    // Expect an error message
    expect(find.text('Please enter your password'), findsOneWidget);
  });
}
