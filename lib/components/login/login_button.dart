import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final Function(String) onError;

  const LoginButton(
      {required this.emailController,
      required this.passwordController,
      required this.formKey,
      required this.onError,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "login_btn",
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            final navigator = Navigator.of(context);
            final body = {
              "email": emailController.text,
              "password": passwordController.text
            };
          }
        },
        child: Text(
          "Login".toUpperCase(),
        ),
      ),
    );
  }
}
