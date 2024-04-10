import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButtonRowWidget extends StatelessWidget {
  const ActionButtonRowWidget(
      {super.key,
      required this.defaultButtonColor,
      required this.elevatedButtonStyle,
      required this.onFirstButtonPressed,
      required this.onSecondButtonPressed,
      required this.firstButtonTitle,
      required this.secondButtonTitle,
      required this.isAdmin});

  final Color defaultButtonColor;
  final TextStyle elevatedButtonStyle;
  final void Function() onFirstButtonPressed;
  final void Function() onSecondButtonPressed;
  final String firstButtonTitle;
  final String secondButtonTitle;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isAdmin == true)
          SizedBox(
            height: Get.width * 0.14,
            width: Get.width * 0.3,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                textStyle: elevatedButtonStyle,
              ),
              child: Text(
                'back',
                style: elevatedButtonStyle.copyWith(
                    fontSize: Get.width * 0.05, color: Colors.white),
              ),
            ),
          ),
        if (isAdmin == false)
          SizedBox(
            height: Get.width * 0.14,
            width: Get.width * 0.29,
            child: ElevatedButton(
              onPressed: onFirstButtonPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: Colors.black,
                backgroundColor: defaultButtonColor,
                textStyle: elevatedButtonStyle,
              ),
              child: Text(
                firstButtonTitle,
                style: elevatedButtonStyle.copyWith(fontSize: Get.width * 0.04),
              ),
            ),
          ),
        SizedBox(
          width: Get.width * 0.02,
        ),
        if (isAdmin == false)
          SizedBox(
            height: Get.width * 0.14,
            width: Get.width * 0.634,
            child: ElevatedButton(
              onPressed: onSecondButtonPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                textStyle: elevatedButtonStyle,
              ),
              child: Text(
                secondButtonTitle,
                style: elevatedButtonStyle.copyWith(
                    fontSize: Get.width * 0.05, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
