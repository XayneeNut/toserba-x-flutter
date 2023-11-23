import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/api%20controller/admin_api_controller.dart';
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/controller/api%20controller/user_account_api_controller.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/models/user_profile_model.dart';
import 'package:toserba/view/admin/auth_view.dart';
import 'package:toserba/view/user/detail_profile_view.dart';
import 'package:toserba/view/user/user_auth_view.dart';
import 'package:toserba/widget/c/custom%20drawer%20widget/user_drawer_action_widget.dart';
import 'package:toserba/widget/s/size_config.dart';

class UserDrawerWidget extends StatefulWidget {
  const UserDrawerWidget({
    super.key,
  });
  @override
  State<UserDrawerWidget> createState() => _UserDrawerWidgetState();
}

class _UserDrawerWidgetState extends State<UserDrawerWidget> {
  final storage = const FlutterSecureStorage();
  final jwtApiController = JwtApiController();
  final adminApiController = AdminApiController();
  final userApiController = UserAccountApiController();
  final userAppController = AppsController();
  UserAccountModel userAccountModel = UserAccountModel(
    userAccountId: 0,
    email: '',
    password: '',
    username: '',
    createdAt: DateTime(0),
    updateAt: DateTime(0),
    userProfileModel: UserProfileModel(
        userProfileId: 0,
        patokanAlamat: '',
        userBirthday: DateTime(0),
        userPhoto: '',
        kodePos: '',
        alamatLengkap: ''),
  );

  var titleTextStyle = GoogleFonts.notoSansJavanese(
      color: Colors.black,
      fontSize: SizeConfig.blockSizeVertical! * 2.5,
      fontWeight: FontWeight.bold);
  var contentTextStyle = GoogleFonts.notoSansJavanese(
      color: const Color.fromARGB(255, 63, 63, 63),
      fontSize: SizeConfig.blockSizeVertical! * 2,
      fontWeight: FontWeight.w500);
  final textButtonStyle = GoogleFonts.lato(
      color: Colors.black,
      fontSize: SizeConfig.blockSizeVertical! * 2,
      fontWeight: FontWeight.w500);

  Future<void> getUserAccountId() async {
    final userAccountId = await storage.read(key: 'user-account-id');
    userAccountModel = await userApiController.getUserAccountAndUserProfile(
      int.parse(userAccountId!),
    );
    setState(() {
      userAccountModel;
    });
    print(userAccountModel.email);
  }

  void _startSelling() async {
    await storage.deleteAll();
    if (!context.mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthView(
              jwtApiController: jwtApiController,
              adminApiController: adminApiController),
        ));
  }

  void _logout() async {
    await storage.deleteAll();
    if (!context.mounted) return;
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return UserAuthView(
            jwtApiController: jwtApiController,
            userAccountApiController: userApiController);
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    getUserAccountId();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.blockSizeVertical! * 55,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 212, 212, 212),
                blurRadius: SizeConfig.blockSizeVertical! * 1.8,
              )
            ], color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.5),
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical! * 4,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage: FileImage(
                                File(userAccountModel
                                    .userProfileModel!.userPhoto),
                              ),
                              radius: Get.width * 0.06,
                            ),
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userAccountModel.username,
                                  style: titleTextStyle,
                                ),
                                Text(
                                  userAccountModel.email,
                                  style: titleTextStyle.copyWith(
                                      fontSize: Get.width * 0.03),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.04,
                ),
                UserDrawerActionWidgets(
                    onHome: () => Navigator.pop(context),
                    onAccount: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailProfileView(
                              userAccountModel: userAccountModel),
                        )),
                    onPesanan: () {})
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Policy and privacy",
                  style: textButtonStyle,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Help center',
                  style: textButtonStyle,
                ),
              ),
              TextButton(
                onPressed: () => userAppController.loginAsDiferentAlertDialog(
                    context,
                    titleTextStyle,
                    contentTextStyle,
                    _startSelling,
                    'admin'),
                child: Text(
                  'Start selling',
                  style: textButtonStyle,
                ),
              ),
              TextButton(
                onPressed: () => userAppController.logoutAllertDialog(
                    context, titleTextStyle, contentTextStyle, _logout),
                child: Text(
                  'Log out',
                  style: textButtonStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
