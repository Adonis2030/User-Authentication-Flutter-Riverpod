import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:user_authentication/screens/login_screen.dart';
import 'package:user_authentication/components/background.dart';
import 'package:user_authentication/screens/welcome_screen.dart';
import 'package:user_authentication/utils/responsive.dart';
import 'package:user_authentication/components/login/login_screen_top_image.dart';
import 'package:user_authentication/components/login/login_form.dart';
import 'package:user_authentication/provider/auth_provider.dart';
import 'package:user_authentication/service/auth_service.dart';

class MockAuthService extends AuthService {
  @override
  Future<String> signIn(String email, String password) async {
    return 'test_user_id';
  }

  @override
  Future<void> signOut() async {
    return;
  }
}

class MockAuthStateNotifier extends AuthStateNotifier {
  MockAuthStateNotifier() : super(authService: MockAuthService());

  @override
  Future<bool> signIn(String email, String password) async {
    state = AuthState(status: AuthStatus.authenticated, userId: 'test_user_id');
    return true;
  }
}

void main() {
  group('LoginScreen tests', () {
    testWidgets('LoginScreen has a Background widget',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: Scaffold(body: LoginScreen())));
      expect(find.byType(Background), findsOneWidget);
    });

    testWidgets('LoginScreen has a Responsive widget',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: Scaffold(body: LoginScreen())));
      expect(find.byType(Responsive), findsOneWidget);
    });

    testWidgets('LoginScreen has a LoginForm widget',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: Scaffold(body: LoginScreen())));
      expect(find.byType(LoginForm), findsOneWidget);
    });
  });

  group('MobileLoginScreen tests', () {
    testWidgets('MobileLoginScreen has a LoginScreenTopImage widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: MobileLoginScreen(),
            ),
          ),
        ),
      );
      expect(find.byType(LoginScreenTopImage), findsOneWidget);
    });

    testWidgets('MobileLoginScreen has a LoginForm widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: MobileLoginScreen(),
            ),
          ),
        ),
      );
      expect(find.byType(LoginForm), findsOneWidget);
    });
  });

  group('Login tests', () {
    testWidgets('navigates to WelcomeScreen upon successful login',
        (WidgetTester tester) async {
      final mockAuthStateNotifier = MockAuthStateNotifier();

      await tester.pumpWidget(ProviderScope(
        overrides: [
          authStateProvider.overrideWithProvider(
            StateNotifierProvider<AuthStateNotifier, AuthState>(
                (ref) => mockAuthStateNotifier),
          ),
        ],
        child: MaterialApp(
          home: const LoginScreen(),
          routes: {
            '/welcome': (context) => const WelcomeScreen(),
          },
        ),
      ));

      // Find the text fields and button.
      final emailField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);
      final loginButton = find.byType(ElevatedButton);

      // Enter 'test@email.com' into the email field.
      await tester.enterText(emailField, 'test@email.com');
      // Enter 'test123' into the password field.
      await tester.enterText(passwordField, 'test123');

      // Scroll the button into view and tap on it.
      await tester.ensureVisible(loginButton);
      await tester.tap(loginButton);

      // Trigger a frame and wait for all animations to complete.
      await tester.pumpAndSettle();

      // Trigger another frame and wait for all animations to complete. This is to wait for the signIn function to complete.
      await tester.pumpAndSettle();

      // Verify that the WelcomeScreen is displayed.
      expect(find.byType(WelcomeScreen), findsOneWidget);
    });
  });
}
