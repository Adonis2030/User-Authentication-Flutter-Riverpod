import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_authentication/provider/auth_provider.dart';

class LoginButton extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Hero(
      tag: "login_btn",
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            try {
              final bool isAuthenticated = await ref
                  .read(authStateProvider.notifier)
                  .signIn(emailController.text, passwordController.text);
              if (isAuthenticated) {
                Navigator.pushNamed(context, '/welcome');
              } else {
                onError('Failed to authenticate the user.');
              }
            } catch (error) {
              onError(error.toString());
            }
          }
        },
        child: Text(
          "Login".toUpperCase(),
        ),
      ),
    );
  }
}
