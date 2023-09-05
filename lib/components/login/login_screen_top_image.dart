import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_authentication/constants/constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Constants.defaultPadding * 2),
        Text(
          "LOGIN",
          style: GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: Constants.defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset('assets/svg/login.svg'),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: Constants.defaultPadding),
      ],
    );
  }
}
