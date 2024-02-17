import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileFormFieldWidget extends StatelessWidget {
  const ProfileFormFieldWidget(
      {super.key,
      required this.hintText,
      required this.titleText,
      required this.icon,
      required this.initialValue});

  final String hintText;
  final String titleText;
  final Icon icon;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    var labelTextStyle = GoogleFonts.inter(fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: labelTextStyle.copyWith(color: Colors.black),
        ),
        SizedBox(
          height: Get.width * 0.03,
        ),
        TextFormField(
          initialValue: initialValue,
          obscureText: titleText.contains('Your Password') ? true : false,
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            suffixIcon: icon,
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
