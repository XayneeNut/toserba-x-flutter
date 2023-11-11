import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/admin_api_controller.dart';
import 'package:toserba/controller/jwt_api_controller.dart';
import 'package:toserba/models/admin_account_model.dart';
import 'package:toserba/view/admin/auth_view.dart';
import 'package:toserba/widget/c/custom%20drawer%20widget/drawer_action_widget.dart';
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
  var contentTextStyle = GoogleFonts.notoSansJavanese(
      color: Colors.black,
      fontSize: SizeConfig.blockSizeVertical! * 2.5,
      fontWeight: FontWeight.w500);
  var adminEmail = '';
  var adminUsername = '';
  var adminAccountId = '';
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

  Future<void> drawer(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Bentar dulu...",
            style: contentTextStyle.copyWith(
                fontSize: SizeConfig.blockSizeVertical! * 3.5),
          ),
          content: Text(
            'beneran mau log out nih?',
            style: contentTextStyle,
          ),
          actions: [
            TextButton(
              onPressed: _logout,
              child: Text(
                'iyah banget',
                style: contentTextStyle.copyWith(
                    fontSize: SizeConfig.blockSizeVertical! * 1.8,
                    color: const Color.fromARGB(255, 255, 17, 0)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'gag dulu',
                style: contentTextStyle.copyWith(
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
            height: SizeConfig.blockSizeVertical! * 65,
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
                DrawerActions(
                  onLogout: () => drawer(context),
                  onAdmin: () {},
                  onPesanan: () {},
                ),
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
            ],
          ),
        ],
      ),
    );
  }
}
