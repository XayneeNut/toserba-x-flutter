import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/widget/size_config.dart';

class EmailPasswordInputWidget extends StatelessWidget {
  const EmailPasswordInputWidget(
      {super.key, required this.isLogin, required this.elevatedButtonStyle});

  final bool isLogin;
  final TextStyle elevatedButtonStyle;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Form(
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeVertical! * 4,
              right: SizeConfig.blockSizeVertical! * 4),
          child: Column(
            children: [
              Column(
                children: [
                  TextFormField(
                    minLines: 1,
                    maxLength: 300,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "email address",
                      labelStyle: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLength: 300,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.trim().length < 6) {
                        return 'password must be at least 6 character';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "password",
                      labelStyle: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: SizeConfig.blockSizeVertical! * 8,
                      width: SizeConfig.blockSizeVertical! * 30,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(85, 92, 246, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          isLogin == true ? "Login" : "Sign Up",
                          style: elevatedButtonStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
