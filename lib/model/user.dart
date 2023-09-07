class User {
  final String email;
  final String password;
  final String userId;

  User(
      {required this.email,
      required this.password,
      this.userId = '315878784545@#4887475'});

  // Named constructor for an invalid user
  User.invalid()
      : email = 'invalid',
        password = 'invalid',
        userId = 'invalid';
}

final List<User> usersDatabase = [
  User(email: 'test@email.com', password: 'test123'),
];
