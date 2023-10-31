import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/widget/s/size_config.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.formKey,
    required this.isLogin,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.onLoginButtonPressed,
  });

  final GlobalKey<FormState> formKey;
  final bool isLogin;
  final void Function(String?) onEmailSaved;
  final void Function(String?) onPasswordSaved;
  final Function() onLoginButtonPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeVertical! * 3,
            right: SizeConfig.blockSizeVertical! * 3),
        child: Form(
          key: formKey,
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
                onSaved: onEmailSaved,
                decoration: InputDecoration(
                  labelText: 'email',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
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
                onSaved: onPasswordSaved,
                decoration: InputDecoration(
                  labelText: 'password',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: SizeConfig.blockSizeVertical! * 2,
                ),
                child: Center(
                  child: SizedBox(
                    height: SizeConfig.blockSizeVertical! * 8,
                    width: SizeConfig.blockSizeVertical! * 30,
                    child: ElevatedButton(
                      onPressed: isLogin ? onLoginButtonPressed : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(85, 92, 246, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        isLogin ? "Login" : "Sign Up",
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
