import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/controller/api%20controller/user_account_api_controller.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/controller/apps%20controller/validator_controller.dart';
import 'package:toserba/view/user/home_user_view.dart';
import 'package:toserba/widget/s/size_config.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/svg.dart';

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

class _UserAuthViewState extends State<UserAuthView>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;
  var _enteredEmail = '';
  var statusCode = 0;
  var _enteredPassword = '';
  var _enteredUsername = '';
  bool _isValidEmail = false;
  String? birthday;
  bool _obscureText = true;
  final ValidatorController _validatorController = ValidatorController();
  final AppsController _appsController = AppsController();
  final birthdayController = TextEditingController();
  late AnimationController _animationController;
  late Animation _animation;

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
      'https://img.freepik.com/free-vector/user-verification-unauthorized-access-prevention-private-account-authentication-cyber-security-people-entering-login-password-safety-measures_335657-3530.jpg?w=740&t=st=1704420480~exp=1704421080~hmac=3bfca4d17f9ffda70bd93fcb60f860001ead259a0433a38319ca3f860e86ef38';

  void _animationFadeIn() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationFadeIn();
  }

  void _toHomeUserView() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeUserView(),
      ),
      (route) => false,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        birthday = DateFormat('d-MM-yyyy').format(picked);
        birthdayController.text = DateFormat('d-MM-yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    birthdayController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _isSubmit() async {
    final isValid = _formKey.currentState!.validate();
    try {
      if (_isLogin && isValid) {
        _formKey.currentState!.save();

        final signUp = await widget.userAccountApiController.signUp(
            birthday: birthdayController.text,
            email: _enteredEmail,
            username: _enteredUsername,
            password: _enteredPassword,
            context: context);

        if (signUp.statusCode == 200) {
          if (!context.mounted) return;
          _appsController.loginSuccess(context);
          await widget.jwtApiController.getUserTokenJwt();
          _toHomeUserView();
          return;
        }
      } else if (!_isLogin && isValid) {
        _formKey.currentState!.save();
        if (!context.mounted) return;
        final login = await widget.userAccountApiController.login(
            context: context, email: _enteredEmail, password: _enteredPassword);

        if (login.statusCode == 200) {
          if (!context.mounted) return;
          _appsController.loginSuccess(context);
          await widget.jwtApiController.getUserTokenJwt();
          _toHomeUserView();
          return;
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: Container(
              padding: EdgeInsets.only(
                  left: Get.width * 0.04, right: Get.width * 0.04),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _isLogin
                          ? Center(
                              child: SizedBox(
                                  height: 300,
                                  width: 300,
                                  child: SvgPicture.asset('assets/signup.svg')),
                            )
                          : Center(
                              child: Container(
                                  height: 334,
                                  width: 300,
                                  margin:
                                      EdgeInsets.only(top: Get.width * 0.01),
                                  child: SvgPicture.asset('assets/auth.svg')),
                            ),
                      if (_isLogin == true)
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
                        SizedBox(
                          height: Get.width * 0.1,
                        ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _isValidEmail = EmailValidator.validate(value);
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (newValue) {
                          _enteredEmail = newValue!;
                        },
                        validator: (value) {
                          if (_isValidEmail == false) {
                            return 'Email not valid';
                          }
                          return null;
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
                          validator: (value) => _validatorController
                              .authValidator('Username', value),
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
                        obscureText: _obscureText,
                        validator: (value) => _validatorController
                            .authValidator('Password', value),
                        onSaved: (newValue) {
                          _enteredPassword = newValue!;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outlined),
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
                          label: const Text("Password"),
                        ),
                      ),
                      if (_isLogin)
                        TextFormField(
                          controller: birthdayController,
                          validator: (value) => _validatorController
                              .authValidator('Birthday', value),
                          onSaved: (newValue) {
                            birthdayController.text = newValue!;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.cake),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _selectDate(context);
                                },
                                icon: const Icon(Icons.date_range_outlined)),
                            label: const Text("Birthday"),
                          ),
                        ),
                      SizedBox(
                        height: Get.width * 0.02,
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate() == true) {
                                _isSubmit();
                                _appsController.loginAllertDialog(context);
                                if (statusCode != 200) {
                                  await Future.delayed(
                                      const Duration(milliseconds: 2000));
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(85, 92, 246, 1),
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
                            child:
                                Divider(color: Color.fromARGB(255, 97, 97, 97)),
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
                            child:
                                Divider(color: Color.fromARGB(255, 97, 97, 97)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLogin
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
                                _animationFadeIn();
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
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: Get.width * 0.06,
                                  right: Get.width * 0.06),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
