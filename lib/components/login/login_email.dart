import 'package:flutter/material.dart';
import 'package:user_authentication/constants/constants.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const EmailInput(
      {required this.controller, required this.validator, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      cursorColor: Constants.kPrimaryColor,
      controller: controller,
      validator: validator,
      decoration: const InputDecoration(
        hintText: "Email",
        prefixIcon: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Icon(Icons.person),
        ),
      ),
    );
  }
}
