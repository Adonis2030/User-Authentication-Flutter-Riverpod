import 'package:user_authentication/model/user.dart';

class AuthService {
  Future<String> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    User user = usersDatabase.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => User.invalid(),
    );

    if (user.userId != 'invalid') {
      return user.userId;
    } else {
      return user.userId;
    }
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration());
  }
}
