import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/controller/list_barang_controller.dart';
import 'package:toserba/widget/s/size_config.dart';

class UpdateAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const UpdateAppBarWidget({
    super.key,
  });

  @override
  State<UpdateAppBarWidget> createState() => _UpdateAppBarWidgetState();

  @override
  Size get preferredSize => Size(
      SizeConfig.blockSizeVertical! * 100, SizeConfig.blockSizeVertical! * 120);
}

class _UpdateAppBarWidgetState extends State<UpdateAppBarWidget> {
  final BarangApiController barangApiController = BarangApiController();
  final ListBarangController listBarangController = ListBarangController();
  Widget? buttonRight;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 4.83),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
          Text(
            'update barang',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
