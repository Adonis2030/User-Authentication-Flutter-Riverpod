import 'package:flutter/material.dart';
import 'package:user_authentication/constants/constants.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const PasswordInput(
      {required this.controller, required this.validator, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.defaultPadding),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        obscureText: true,
        cursorColor: Constants.kPrimaryColor,
        controller: controller,
        validator: validator,
        decoration: const InputDecoration(
          hintText: "Password",
          prefixIcon: Padding(
            padding: EdgeInsets.all(Constants.defaultPadding),
            child: Icon(Icons.lock),
          ),
        ),
      ),
    );
  }
}
