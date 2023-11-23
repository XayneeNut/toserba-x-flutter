import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/controller/api%20controller/user_account_api_controller.dart';
import 'package:toserba/view/user/home_user_view.dart';
import 'package:toserba/widget/i/image_picker_widget.dart';
import 'package:toserba/widget/s/sign_up_text_widget.dart';
import 'package:toserba/widget/s/size_config.dart';

class UserAuthView extends StatefulWidget {
  const UserAuthView(
      {super.key,
      required this.jwtApiController,
      required this.userAccountApiController});

  final JwtApiController jwtApiController;
  final UserAccountApiController userAccountApiController;

  @override
  State<UserAuthView> createState() => _UserAuthViewState();
}

class _UserAuthViewState extends State<UserAuthView> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  File? _entereImage;

  var titleStyle = GoogleFonts.poppins(
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  var titleStyle2 = GoogleFonts.poppins(
    color: Colors.grey,
    fontWeight: FontWeight.w400,
  );

  var labelStyle = GoogleFonts.poppins();
  var imageUrl =
      'https://img.freepik.com/free-vector/user-verification-unauthorized-access-prevention-private-account-authentication-cyber-security-people-entering-login-password-safety-measures_335657-3530.jpg?w=740&t=st=1693831915~exp=1693832515~hmac=13d369ada8acdaf56d24c52bd4c5981cec1f9c9f8d8f7f17af74c817bf47aaaa';

  void _toHomeUserView() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeUserView(),
      ),
      (route) => false,
    );
  }

  Future _isSubmit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid || _isLogin && _entereImage == null) {
      return;
    }

    try {
      if (_isLogin && isValid) {
        await widget.jwtApiController.getUserTokenJwt();
        _formKey.currentState!.save();

        final signUp = await widget.userAccountApiController.signUp(
            email: _enteredEmail,
            username: _enteredUsername,
            password: _enteredPassword,);

        if (signUp.statusCode == 200) {
          if (!context.mounted) return;
          _toHomeUserView();
        }
      } else if (!_isLogin && isValid) {
        await widget.jwtApiController.getUserTokenJwt();
        _formKey.currentState!.save();

        final login = await widget.userAccountApiController
            .login(email: _enteredEmail, password: _enteredPassword);
        if (login.statusCode == 200) {
          if (!context.mounted) return;
          _toHomeUserView();
        }
      }
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding:
            EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _isLogin
                    ? const SignupTextWidget()
                    : Center(
                        child: Container(
                            height: 334,
                            width: 300,
                            margin: EdgeInsets.only(top: Get.width * 0.01),
                            child: Image.network(imageUrl)),
                      ),
                SizedBox(
                  height: Get.width * 0.0002,
                ),
                if (!_isLogin)
                  Text(
                    "Login",
                    style: GoogleFonts.poppins(
                        fontSize: 38,
                        color: const Color.fromRGBO(46, 24, 180, 1),
                        fontWeight: FontWeight.w600),
                  ),
                if (_isLogin)
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 2,
                        ),
                        ImagePickerWidget(
                            isUser: true,
                            pickedImage: (image) {
                              _entereImage = image;
                            },
                            initialImage: null),
                      ],
                    ),
                  ),
                SizedBox(
                  height: Get.width * 0.02,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    _enteredEmail = newValue!;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                    label: Text("Email"),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.02,
                ),
                if (_isLogin)
                  TextFormField(
                    onSaved: (newValue) {
                      _enteredUsername = newValue!;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outlined),
                      label: Text("Username"),
                    ),
                  ),
                SizedBox(
                  height: Get.width * 0.02,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    _enteredPassword = newValue!;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outlined),
                    label: Text("Password"),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.1,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(85, 92, 246, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _isLogin ? "Sign in" : "Log in",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.width * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Expanded(
                      child: Divider(color: Color.fromARGB(255, 97, 97, 97)),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Text(
                      "OR",
                      style: titleStyle.copyWith(
                          fontSize: Get.width * 0.05, color: Colors.grey),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    const Expanded(
                      child: Divider(color: Color.fromARGB(255, 97, 97, 97)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isLogin ? "already have account?" : "New in Grolist?",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin ? "Login" : "Register",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.06, right: Get.width * 0.06),
                      child: Text(
                        "${_isLogin ? "if you are creating new account, " : "if you have an account, "} Terms & Conditions and Privacy Policy will apply. You can also set up your communication preferences",
                        style: titleStyle2,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
