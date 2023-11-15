import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';

// ignore: must_be_immutable
class UserAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  UserAppBarWidget(
      {super.key, required this.barangModels, required this.isListBarang});

  final List<BarangModels> barangModels;
  bool? isListBarang;

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
          Row(children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined))
          ]),
        ],
      ),
    );
  }
}
