import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toserba/widget/auth/email_password_input_widget.dart';
import 'package:toserba/widget/size_config.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  var textButtonStyle = GoogleFonts.nunitoSans(
      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25);
  var elevatedButtonStyle = GoogleFonts.arimo(
      color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25);
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: SizeConfig.blockSizeVertical! * 65,
            width: SizeConfig.blockSizeVertical! * 70,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: const Color.fromARGB(255, 207, 207, 207))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal! * 60,
                  width: SizeConfig.blockSizeHorizontal! * 60,
                  child: Image.asset('assets/logo.png'),
                ),
                SizedBox(height: SizeConfig.blockSizeHorizontal! * 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = true;
                        });
                      },
                      child: Text(
                        "login",
                        style: textButtonStyle,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeVertical! * 15,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = false;
                        });
                      },
                      child: Text(
                        "sign up",
                        style: textButtonStyle,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          EmailPasswordInputWidget(
              isLogin: isLogin, elevatedButtonStyle: elevatedButtonStyle)
        ],
      ),
    );
  }
}
