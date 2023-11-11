import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupTextWidget extends StatefulWidget {
  const SignupTextWidget({super.key});

  @override
  State<SignupTextWidget> createState() => _SignupTextWidgetState();
}

class _SignupTextWidgetState extends State<SignupTextWidget> {
  @override
  void initState() {
    super.initState();
    Get;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: Get.height * 0.07),
          child: Text(
            "Sign Up",
            style: GoogleFonts.poppins(
                fontSize: 38,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(46, 24, 180, 1)),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: Get.width * 0.35,
          height: 1,
          color: Colors.black,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Find your needs",
          textAlign: TextAlign.end,
          style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(10, 0, 122, 1)),
        ),
      ],
    );
  }
}
