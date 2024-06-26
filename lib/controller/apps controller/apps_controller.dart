import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/api%20controller/admin_api_controller.dart';
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/admin/auth_view.dart';
import 'package:toserba/widget/s/size_config.dart';

class AppsController {
  Future<void> response400AlertDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('yahh'),
            ),
          ],
        );
      },
    );
  }

  void logout(
      FlutterSecureStorage storage,
      BuildContext context,
      JwtApiController jwtApiController,
      AdminApiController adminApiController) async {
    await storage.deleteAll();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => AuthView(
              jwtApiController: jwtApiController,
              adminApiController: adminApiController)),
      (route) => false,
    );
  }

  Future<void> waitingFor(
      {required BuildContext context,
      required String title,
      required String content}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  SizedBox(
                    width: Get.width * 0.5,
                    child: Text(
                      content,
                      style: GoogleFonts.ubuntu(),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> loginFailedAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: const Text('Login Failed'),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Text('email atau password kamu salah, coba cek dan login ulang')
              ],
            ),
          ),
        );
      },
    );
  }

  Uint8List decodeImage(String? base64String) {
    try {
      if (base64String != null && base64String.isNotEmpty) {
        return base64Decode(base64String);
      }
    } catch (e) {
      print("Error decoding image: $e");
    }
    return Uint8List(0);
  }

  List<Image> loadImage(BarangModels barangModels) {
    return barangModels.imageBarang!.map((imageModel) {
      Uint8List bytes = imageModel.gambar;
      return Image.memory(bytes, fit: BoxFit.fill);
    }).toList();
  }

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

  Future<void> loginSuccess(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: const Text('Login Success'),
          content: Row(
            children: [
              const CircularProgressIndicator(),
              SizedBox(
                width: Get.width * 0.03,
              ),
              const Text('Setting up the home page')
            ],
          ),
        );
      },
    );
  }

  Future<void> loginAllertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: const Text('Please wait'),
          content: Row(
            children: [
              const CircularProgressIndicator(),
              SizedBox(
                width: Get.width * 0.03,
              ),
              const Text('currently verifying your email')
            ],
          ),
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
            "Log in as $account?",
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
