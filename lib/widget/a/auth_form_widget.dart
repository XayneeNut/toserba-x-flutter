import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/widget/s/size_config.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.formKey,
    required this.isLogin,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.onPressed,
  });

  final GlobalKey<FormState> formKey;
  final bool isLogin;
  final void Function(String?) onEmailSaved;
  final void Function(String?) onPasswordSaved;
  final Function() onPressed;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      labelStyle: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
    final margin = SizedBox(
      height: Get.height * 0.03,
    );
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeVertical! * 3,
            right: SizeConfig.blockSizeVertical! * 3),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              TextFormField(
                minLines: 1,
                maxLength: 300,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'not valid email';
                  }
                  return null;
                },
                onSaved: widget.onEmailSaved,
                decoration: inputDecoration.copyWith(labelText: "email"),
              ),
              margin,
              TextFormField(
                minLines: 1,
                maxLength: 20,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'not valid password';
                  }
                  return null;
                },
                onSaved: widget.onPasswordSaved,
                obscureText: _obscureText,
                decoration: inputDecoration.copyWith(
                  labelText: "password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(_obscureText == true
                        ? CupertinoIcons.eye_fill
                        : CupertinoIcons.eye_slash_fill),
                  ),
                ),
              ),
              margin,
              Container(
                margin: EdgeInsets.only(
                  bottom: SizeConfig.blockSizeVertical! * 2,
                ),
                child: Center(
                  child: SizedBox(
                    height: SizeConfig.blockSizeVertical! * 8,
                    width: SizeConfig.blockSizeVertical! * 30,
                    child: ElevatedButton(
                      onPressed: widget.onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 106, 7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        widget.isLogin == true ? "Login" : "Sign Up",
                        style: GoogleFonts.arimo(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
