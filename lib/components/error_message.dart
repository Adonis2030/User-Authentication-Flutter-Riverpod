import 'package:flutter/material.dart';
import 'package:user_authentication/constants/constants.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.defaultPadding),
      child: RichText(
        text: TextSpan(
          text: message,
          style: const TextStyle(color: Constants.errorColor),
        ),
      ),
    );
  }
}
