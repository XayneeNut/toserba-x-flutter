import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/s/size_config.dart';

// ignore: must_be_immutable
class UpdateAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  UpdateAppBarWidget(
      {super.key, required this.barangModels, required this.isUpdateBarang});

  final List<BarangModels> barangModels;
  bool? isUpdateBarang;

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
  var textButtonStyle = GoogleFonts.roboto(
      color: const Color.fromARGB(255, 33, 68, 243),
      fontSize: SizeConfig.blockSizeVertical! * 2.5);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical! * 7,
      decoration: BoxDecoration(color: Colors.white),
      margin: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical! * 3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Batal',
              style: textButtonStyle,
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeVertical! * 7,
          ),
          widget.isUpdateBarang == true
              ? Text(
                  'Update Barang',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 20),
                )
              : Text(
                  'Detail Barang',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500, fontSize: 20),
                ),
        ],
      ),
    );
  }
}
