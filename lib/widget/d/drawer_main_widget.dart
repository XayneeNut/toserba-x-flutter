import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/admin_api_controller.dart';
import 'package:toserba/controller/jwt_api_controller.dart';
import 'package:toserba/view/auth_view.dart';
import 'package:toserba/widget/s/size_config.dart';

class DrawerMain extends StatefulWidget {
  const DrawerMain({super.key});

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
            'beneran mau logout nih?',
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
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 50,
            child: DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.onPrimaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withOpacity(0.8),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Column(
                children: [
                  Container(
                    height: SizeConfig.blockSizeVertical! * 10,
                    child: Column(children: [Text("Profile menu nantinya")]),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () => drawer(context),
                        icon: Icon(
                          Icons.logout,
                          color: Colors.black,
                          size: SizeConfig.blockSizeVertical! * 4,
                        ),
                        label: Text(
                          'log out',
                          style: GoogleFonts.rubik(
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeVertical! * 3),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.people,
                          color: Colors.black,
                          size: SizeConfig.blockSizeVertical! * 4,
                        ),
                        label: Text(
                          'Profile',
                          style: GoogleFonts.rubik(
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeVertical! * 3),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
