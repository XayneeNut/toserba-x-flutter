import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toserba/controller/api%20controller/admin_api_controller.dart';
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/view/admin/home_view.dart';
import 'package:toserba/widget/a/auth_form_widget.dart';
import 'package:toserba/widget/s/size_config.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({
    super.key,
    required this.jwtApiController,
    required this.adminApiController,
  });

  final JwtApiController jwtApiController;
  final AdminApiController adminApiController;

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  final _formKey = GlobalKey<FormState>();
  var textButtonStyle = GoogleFonts.nunitoSans(
      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25);

  bool _isLogin = true;
  var _enteredEmail = '';
  var _enteredUsername = '';
  var _enteredPassword = '';
  final _appsController = AppsController();
  var titleStyle2 = GoogleFonts.poppins(
    color: Colors.grey,
    fontWeight: FontWeight.w400,
  );

  @override
  void initState() {
    super.initState();
    _isLogin;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 253, 112, 18),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark));
  }

  void _toHomeView() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
      (route) => false,
    );
  }

  Future _isSubmit() async {
    final isValid = _formKey.currentState!.validate();

    try {
      if (_isLogin == true && isValid) {
        _formKey.currentState!.save();

        // ignore: use_build_context_synchronously
        final login = await widget.adminApiController.login(
          context: context,
          email: _enteredEmail,
          password: _enteredPassword,
        );

        if (login.statusCode == 200) {
          await widget.jwtApiController.getTokenJwt();
          _toHomeView();
        }
      } else if (_isLogin == false && isValid) {
        _formKey.currentState!.save();
        if (!context.mounted) return;
        final signUp = await widget.adminApiController.createAdmin(
            email: _enteredEmail,
            password: _enteredPassword,
            username: _enteredUsername,
            context: context);

        if (signUp.statusCode == 200) {
          await widget.jwtApiController.getTokenJwt();
          _toHomeView();
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(75);
    var labelStyle = GoogleFonts.ubuntu(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );

    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 253, 112, 18),
        ),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: Get.width * 0.07),
              width: double.infinity,
              height: Get.height * 0.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isLogin ? "Login" : "Register",
                    style: labelStyle.copyWith(fontSize: Get.width * 0.15),
                  ),
                  Text(
                    _isLogin ? "Welcome Back !" : "create new account !",
                    style: labelStyle.copyWith(fontSize: Get.width * 0.06),
                  )
                ],
              ),
            ),
            Container(
              height: Get.height * 1,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color.fromARGB(255, 187, 187, 187),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: borderRadius, topRight: borderRadius),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  AuthForm(
                    formKey: _formKey,
                    isLogin: _isLogin,
                    onEmailSaved: (value) {
                      _enteredEmail = value!;
                    },
                    onUsernameSaved: (value) {
                      _enteredUsername = value!;
                    },
                    onPasswordSaved: (value) {
                      _enteredPassword = value!;
                    },
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _isSubmit();
                        _appsController.loginAllertDialog(context);
                        await Future.delayed(const Duration(seconds: 2));
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      }
                    },
                  ),
                  SizedBox(
                    height: Get.width * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLogin == false
                            ? "already have account?"
                            : "New in OurShop?",
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
                          _isLogin == false ? "Login" : "Register",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
