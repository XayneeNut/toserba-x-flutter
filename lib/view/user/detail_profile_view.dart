import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/widget/c/user_app_bar_widget.dart';
import 'package:toserba/widget/i/image_picker_widget.dart';
import 'package:toserba/widget/profile_form_field_widget.dart';

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
                  ImagePickerWidget(
                      pickedImage: (image) {},
                      initialImage: File(
                          widget.userAccountModel.userProfileModel!.userPhoto),
                      isUser: true),
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
                          .userAccountModel.userProfileModel!.alamatLengkap,
                    ),
                    SizedBox(
                      height: Get.width * 0.03,
                    ),
                    ProfileFormFieldWidget(
                      hintText: '',
                      titleText: 'Your Code Pos',
                      icon: const Icon(CupertinoIcons.map_pin),
                      initialValue:
                          widget.userAccountModel.userProfileModel!.kodePos,
                    ),
                    SizedBox(
                      height: Get.width * 0.07,
                    ),
                    Center(
                        child: SizedBox(
                      width: Get.width * 0.7,
                      height: Get.width * 0.15,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 4,
                          shadowColor: const Color.fromARGB(255, 57, 91, 241),
                          backgroundColor:
                              const Color.fromARGB(255, 57, 91, 241),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: userNameTextStyle.copyWith(
                              fontSize: Get.width * 0.05),
                        ),
                      ),
                    ))
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
