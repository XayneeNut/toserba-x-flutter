import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/widget/c/user_app_bar_widget.dart';
import 'package:toserba/widget/p/profile_form_field_widget.dart';

class DetailProfileView extends StatefulWidget {
  const DetailProfileView({super.key, required this.userAccountModel});

  final UserAccountModel userAccountModel;

  @override
  State<DetailProfileView> createState() => _DetailProfileViewState();
}

class _DetailProfileViewState extends State<DetailProfileView> {
  var userNameTextStyle = GoogleFonts.inter(
      fontSize: Get.width * 0.07, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBarWidget.profile(
        barangModels: const [],
        isUser: true,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.width * 0.05,
                  ),
                  Text(
                    widget.userAccountModel.username,
                    style: userNameTextStyle,
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                  left: Get.width * 0.1,
                  right: Get.width * 0.1,
                  top: Get.width * 0.018),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileFormFieldWidget(
                        hintText: 'Add your email',
                        titleText: 'Your Email',
                        icon: const Icon(CupertinoIcons.mail),
                        initialValue: widget.userAccountModel.email),
                    SizedBox(
                      height: Get.width * 0.03,
                    ),
                    ProfileFormFieldWidget(
                        hintText: 'Add your password',
                        titleText: 'Your Password',
                        icon: const Icon(CupertinoIcons.eye),
                        initialValue: widget.userAccountModel.password),
                    SizedBox(
                      height: Get.width * 0.03,
                    ),
                    ProfileFormFieldWidget(
                      hintText: '',
                      titleText: 'Alamat Lengkap',
                      icon: const Icon(CupertinoIcons.location_solid),
                      initialValue: widget
                          .userAccountModel.userAddressEntity!.first.patokan,
                    ),
                    SizedBox(
                      height: Get.width * 0.03,
                    ),
                    ProfileFormFieldWidget(
                      hintText: '',
                      titleText: 'Your Code Pos',
                      icon: const Icon(CupertinoIcons.map_pin),
                      initialValue: widget
                          .userAccountModel.userAddressEntity!.first.posCode,
                    ),
                    SizedBox(
                      height: Get.width * 0.07,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
