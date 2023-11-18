import 'package:flutter/material.dart';
import 'package:toserba/widget/s/size_config.dart';

class UserAppController {
  Future<void> userLogoutAllertDialog(
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

  Future<void> loginAsAdminAlertDialog(
      BuildContext context,
      TextStyle titleTextStyle,
      TextStyle contentTextStyle,
      void Function() logout) async {
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
            'Logging out and login as admin temporarily will hide your account activity history, to see it again, please log back into your account',
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
