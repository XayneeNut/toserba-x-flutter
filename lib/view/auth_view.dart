import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toserba/controller/admin_api_controller.dart';
import 'package:toserba/controller/jwt_api_controller.dart';
import 'package:toserba/view/home_view.dart';
import 'package:toserba/widget/auth/auth_form_widget.dart';
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

  bool isLogin = false;
  var _enteredEmail = '';
  var _enteredPassword = '';

  @override
  void initState() {
    super.initState();
    isLogin;
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
      if (isLogin == true && isValid) {
        await widget.jwtApiController.getTokenJwt();
        _formKey.currentState!.save();

        // ignore: use_build_context_synchronously
        final login = await widget.adminApiController.login(
          context: context,
          email: _enteredEmail,
          password: _enteredPassword,
        );

        if (login.statusCode == 200) {
          _toHomeView();
        }
      }
    } catch (e) {
      print(e);
    }
  }

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
                  color: const Color.fromARGB(255, 207, 207, 207),
                ),
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
                        setState(
                          () {
                            isLogin = true;
                          },
                        );
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
          AuthForm(
            formKey: _formKey,
            isLogin: isLogin,
            onEmailSaved: (value) {
              _enteredEmail = value!;
            },
            onPasswordSaved: (value) {
              _enteredPassword = value!;
            },
            onLoginButtonPressed: _isSubmit,
          ),
        ],
      ),
    );
  }
}
