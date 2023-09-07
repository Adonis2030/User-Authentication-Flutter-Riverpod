import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_authentication/provider/auth_provider.dart';
import 'package:user_authentication/screens/welcome_screen.dart';
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
  Future<bool> signOut() async {
    state = AuthState(status: AuthStatus.unauthenticated);
    return true;
  }
}

void main() {
  group('WelcomeScreen Widget', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(
        child: MaterialApp(
          home: WelcomeScreen(),
        ),
      ));

      expect(find.text('Welcome!'), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('logout button signs out user', (WidgetTester tester) async {
      final mockAuthStateNotifier = MockAuthStateNotifier();

      await tester.pumpWidget(ProviderScope(
        overrides: [
          authStateProvider.overrideWithProvider(
            StateNotifierProvider<AuthStateNotifier, AuthState>(
                (ref) => mockAuthStateNotifier),
          ),
        ],
        child: MaterialApp(
          home: const WelcomeScreen(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/login':
                return MaterialPageRoute(builder: (_) => const Scaffold());
              default:
                return MaterialPageRoute(builder: (_) => const WelcomeScreen());
            }
          },
        ),
      ));

      await tester.tap(find.byIcon(Icons.logout));
      expect(mockAuthStateNotifier.state.status, AuthStatus.unauthenticated);
    });
  });
}
