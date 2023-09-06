import 'package:user_authentication/model/user.dart';

class AuthService {
  // Simulate a fake user
  Future<String> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    User user = usersDatabase.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => User.invalid(),
    );

    if (user.userId != 'invalid') {
      return user.userId;
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate delay
  }
}
