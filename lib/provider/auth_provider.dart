import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_authentication/service/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

enum AuthStatus { authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final String userId;

  AuthState({required this.status, this.userId = ''});
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthStateNotifier({required this.authService})
      : super(AuthState(status: AuthStatus.unauthenticated));

  Future signIn(String email, String password) async {
    try {
      final userId = await authService.signIn(email, password);
      if (userId != 'invalid') {
        state = AuthState(status: AuthStatus.authenticated, userId: userId);
        return true;
      } else {
        state = AuthState(status: AuthStatus.unauthenticated);
        return false;
      }
    } catch (error) {
      throw Exception('$error');
    }
  }

  Future<bool> signOut() async {
    try {
      await authService.signOut();
      state = AuthState(status: AuthStatus.unauthenticated);
      return false;
    } catch (error) {
      return true;
    }
  }
}

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthStateNotifier(authService: authService);
});
