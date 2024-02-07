import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/apps%20controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';

// ignore: must_be_immutable
class UserAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  UserAppBarWidget.home({
    super.key,
    required this.barangModels,
    required this.isListBarang,
  });

  UserAppBarWidget.profile(
      {super.key, required this.barangModels, required this.isUser});

  UserAppBarWidget.checkout(
      {super.key, required this.barangModels, required this.isCheckout});

  final List<BarangModels> barangModels;
  bool? isListBarang;
  bool? isUser;
  bool? isCheckout;

  @override
  State<UserAppBarWidget> createState() => _UserAppBarWidgetState();

  @override
  Size get preferredSize => Size(Get.width * 1, Get.width * 1);
}

class _UserAppBarWidgetState extends State<UserAppBarWidget> {
  final BarangApiController barangApiController = BarangApiController();
  final ListBarangController listBarangController = ListBarangController();
  Widget? buttonRight;
  var textButtonStyle = GoogleFonts.roboto(
      color: const Color.fromARGB(255, 33, 68, 243),
      fontSize: Get.width * 0.25);

  var titleTextStyle = GoogleFonts.poppins(fontSize: Get.width * 0.06);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 0.2,
      decoration: const BoxDecoration(color: Colors.white),
      margin: EdgeInsets.only(
        top: Get.width * 0.027,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isListBarang == true
              ? IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                )
              : IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
          if (widget.isListBarang == true)
            Text(
              "Home View",
              style: titleTextStyle,
            ),
          if (widget.isListBarang == true)
            Row(children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined))
            ]),
          if (widget.isUser == true)
            Text(
              "User Profile",
              style: titleTextStyle,
            ),
          if (widget.isUser == true)
            Row(children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.home),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.bell))
            ]),
        ],
      ),
    );
  }
}
