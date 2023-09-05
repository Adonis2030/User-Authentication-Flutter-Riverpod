import 'package:flutter/material.dart';
import 'package:user_authentication/components/error_message.dart';
import 'package:user_authentication/components/login/login_email.dart';
import 'package:user_authentication/components/login/login_password.dart';
import 'package:user_authentication/components/login/login_button.dart';
import 'package:user_authentication/constants/constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String notification = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleError(String error) {
    setState(() {
      notification = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ErrorMessage(message: notification),
          EmailInput(
            controller: emailController,
            validator: (String? value) {
              if (value == null ||
                  !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                return 'Please enter a valid Email';
              }
              return null;
            },
          ),
          PasswordInput(
            controller: passwordController,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: Constants.defaultPadding),
          LoginButton(
            emailController: emailController,
            passwordController: passwordController,
            formKey: _formKey,
            onError: handleError,
          ),
          const SizedBox(
            height: Constants.defaultPadding,
          ),
        ],
      ),
    );
  }
}
