import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/apps%20controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/p/popup_menu_widget.dart';

class AppBarAdminWidget extends StatefulWidget {
  const AppBarAdminWidget(
      {super.key,
      required this.username,
      required this.customTextStyle,
      required this.barangModels,
      required this.listBarangController,
      required this.barangApiController,
      required this.onLogout,
      required this.onLoginAsUser});

  final String username;
  final TextStyle customTextStyle;
  final List<BarangModels> barangModels;
  final ListBarangController listBarangController;
  final BarangApiController barangApiController;
  final Function() onLogout;
  final Function() onLoginAsUser;

  @override
  State<AppBarAdminWidget> createState() => _AppBarAdminWidgetState();
}

class _AppBarAdminWidgetState extends State<AppBarAdminWidget> {
  @override
  void initState() {
    super.initState();
    widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: Get.width * 0.17,
            margin: EdgeInsets.only(left: Get.width * 0.03),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Color.fromARGB(255, 211, 210, 210),
                              spreadRadius: 2)
                        ],
                      ),
                      child: CircleAvatar(
                        radius: Get.width * 0.05,
                        backgroundImage: const AssetImage(
                            'assets/UserLoginAccountImage.png'),
                      ),
                    ),
                    SizedBox(width: Get.width * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Menetapkan teks ke atas gambar
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hii, ${widget.username}',
                          style: widget.customTextStyle.copyWith(
                              fontSize: Get.width * 0.04,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Penjual',
                          style: widget.customTextStyle.copyWith(
                            fontSize: Get.width * 0.037,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.shopping_cart),
              ),
              PopUpMenuWidget(
                onLogoutTap: widget.onLogout,
                onloginAsUserTap: widget.onLoginAsUser,
              ),
            ],
          )
        ],
      ),
    );
  }
}
