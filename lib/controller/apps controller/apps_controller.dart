import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toserba/widget/s/size_config.dart';

class AppsController {
  Future<void> logoutAllertDialog(
      BuildContext context,
      TextStyle titleTextStyle,
      TextStyle contentTextStyle,
      void Function() logout) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Log Out Of Your Account?",
            style: titleTextStyle.copyWith(
                fontSize: SizeConfig.blockSizeVertical! * 2.3),
          ),
          content: Text(
            'Logging out temporarily will hide your account activity history, to see it again, please log back into your account',
            style: contentTextStyle,
          ),
          actions: [
            TextButton(
              onPressed: logout,
              child: Text(
                'log out',
                style: titleTextStyle.copyWith(
                    fontSize: SizeConfig.blockSizeVertical! * 1.8,
                    color: const Color.fromARGB(255, 255, 17, 0)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'cancel',
                style: titleTextStyle.copyWith(
                  fontSize: SizeConfig.blockSizeVertical! * 1.8,
                  color: const Color.fromARGB(255, 0, 120, 219),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> takeImageAllertDialog(
      BuildContext context,
      TextStyle titleTextStyle,
      void Function() fromGallery,
      void Function() fromCamera) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text(
            "Take Image?",
            style: titleTextStyle.copyWith(
                fontSize: SizeConfig.blockSizeVertical! * 2.3),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: fromGallery,
                icon: const Icon(CupertinoIcons.photo),
                iconSize: Get.width * 0.15,
              ),
              IconButton(
                onPressed: fromCamera,
                icon: const Icon(CupertinoIcons.camera),
                iconSize: Get.width * 0.15,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'cancel',
                style: titleTextStyle.copyWith(
                    fontSize: SizeConfig.blockSizeVertical! * 1.8,
                    color: const Color.fromARGB(255, 255, 17, 0)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> loginAsDiferentAlertDialog(
      BuildContext context,
      TextStyle titleTextStyle,
      TextStyle contentTextStyle,
      void Function() logout,
      String account) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Log in as admin?",
            style: titleTextStyle.copyWith(
                fontSize: SizeConfig.blockSizeVertical! * 2.3),
          ),
          content: Text(
            'Logging out and login as $account temporarily will hide your account activity history, to see it again, please log back into your account',
            style: contentTextStyle,
          ),
          actions: [
            TextButton(
              onPressed: logout,
              child: Text(
                'log out',
                style: titleTextStyle.copyWith(
                    fontSize: SizeConfig.blockSizeVertical! * 1.8,
                    color: const Color.fromARGB(255, 255, 17, 0)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'cancel',
                style: titleTextStyle.copyWith(
                  fontSize: SizeConfig.blockSizeVertical! * 1.8,
                  color: const Color.fromARGB(255, 0, 120, 219),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
