import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/api%20controller/admin_api_controller.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/controller/api%20controller/user_account_api_controller.dart';
import 'package:toserba/models/admin_account_model.dart';
import 'package:toserba/view/admin/auth_view.dart';
import 'package:toserba/view/user/user_auth_view.dart';
import 'package:toserba/widget/c/custom%20drawer%20widget/user_drawer_action_widget.dart';
import 'package:toserba/widget/s/size_config.dart';
import 'package:toserba/widget/a/admin_account_headers_widget.dart';

class DrawerMain extends StatefulWidget {
  const DrawerMain({super.key, required this.adminAccountModel});
  final List<AdminAccountModel> adminAccountModel;
  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  final storage = const FlutterSecureStorage();
  final jwtApiController = JwtApiController();
  final adminApiController = AdminApiController();
  final userAccountApiController = UserAccountApiController();
  final appsController = AppsController();
  var adminEmail = '';
  var adminUsername = '';
  var adminAccountId = '';
  var contentTextStyle = GoogleFonts.notoSansJavanese(
      color: Colors.black,
      fontSize: SizeConfig.blockSizeVertical! * 2.5,
      fontWeight: FontWeight.w500);
  var titleTextStyle = GoogleFonts.notoSansJavanese(
      color: Colors.black,
      fontSize: SizeConfig.blockSizeVertical! * 2.5,
      fontWeight: FontWeight.bold);

  final textButtonStyle = GoogleFonts.lato(
      color: Colors.black,
      fontSize: SizeConfig.blockSizeVertical! * 2,
      fontWeight: FontWeight.w500);

  Future<void> getAdminAccountId() async {
    final adminAccount = await storage.read(key: 'admin_account_id');
    print('ini id $adminAccount');
    var response = await adminApiController.getEmailById(
      int.parse(adminAccount!),
    );
    final data = json.decode(response.body);

    setState(() {
      adminEmail = data['email'];
      adminUsername = data['username'];
      adminAccountId = adminAccount;
      print(adminAccountId);
    });
  }

  void _logout() async {
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

  void _loginAsUser() async {
    await storage.deleteAll();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => UserAuthView(
              jwtApiController: jwtApiController,
              userAccountApiController: userAccountApiController),
        ),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    getAdminAccountId();
    print('dari init state$adminUsername');
    print('dari init state$adminEmail');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeConfig.blockSizeVertical! * 70,
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
                  child: UserAccountHeader(
                    adminUsername: adminUsername,
                    adminAccountId: adminAccountId,
                    adminEmail: adminEmail,
                  ),
                ),
                UserDrawerActionWidgets(
                  onHome: () {},
                  onAccount: () {},
                  onPesanan: () {},
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Setting and privacy",
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
                onPressed: () => appsController.loginAsDiferentAlertDialog(
                    context,
                    titleTextStyle,
                    contentTextStyle,
                    _loginAsUser,
                    'user'),
                child: Text(
                  'Login as user',
                  style: textButtonStyle,
                ),
              ),
              TextButton(
                onPressed: () => appsController.logoutAllertDialog(
                    context,
                    titleTextStyle,
                    contentTextStyle.copyWith(
                      color: const Color.fromARGB(255, 63, 63, 63),
                    ),
                    _logout),
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
