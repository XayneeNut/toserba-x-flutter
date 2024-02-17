import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget(
      {super.key,
      this.onLogoutTap,
      this.onloginAsUserTap,
      this.onProfileTap,
      this.onHelpCenterTap});

  final Function()? onLogoutTap;
  final Function()? onloginAsUserTap;
  final Function()? onProfileTap;
  final Function()? onHelpCenterTap;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      icon: const Icon(CupertinoIcons.ellipsis_vertical),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: onLogoutTap,
          child: Row(
            children: [
              const Icon(Icons.logout_outlined),
              SizedBox(
                width: Get.width * 0.02,
              ),
              const Text('Logout'),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: onloginAsUserTap,
          child: Row(
            children: [
              const Icon(CupertinoIcons.person_circle),
              SizedBox(
                width: Get.width * 0.02,
              ),
              const Text('Login as user'),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: onProfileTap,
          child: Row(
            children: [
              const Icon(CupertinoIcons.profile_circled),
              SizedBox(
                width: Get.width * 0.02,
              ),
              const Text('Profile'),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: onHelpCenterTap,
          child: Row(
            children: [
              const Icon(CupertinoIcons.question_circle),
              SizedBox(
                width: Get.width * 0.02,
              ),
              const Text('Help center'),
            ],
          ),
        ),
      ],
    );
  }
}
