import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/c/custom_search_delegate.dart';
import 'package:toserba/widget/s/size_config.dart';

// ignore: must_be_immutable
class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBarWidget(
      {super.key, required this.barangModels, required this.isListBarang});

  final List<BarangModels> barangModels;
  bool? isListBarang;

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();

  @override
  Size get preferredSize => Size(
      SizeConfig.blockSizeVertical! * 100, SizeConfig.blockSizeVertical! * 120);
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
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
        top: widget.isListBarang == false
            ? SizeConfig.blockSizeVertical! * 3
            : 0,
      ),
      child: Row(
        mainAxisAlignment: widget.isListBarang == true
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homeview',);
              },
              child: widget.isListBarang == false
                  ? Text(
                      'Batal',
                      style: textButtonStyle,
                    )
                  : IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(
                        size: SizeConfig.blockSizeVertical! * 4,
                        Icons.menu_open_rounded,
                        color: Colors.black,
                      ))),
          if (widget.isListBarang == false)
            SizedBox(
              width: SizeConfig.blockSizeVertical! * 7,
            ),
          widget.isListBarang == true
              ? Text(
                  'List Barang',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 20),
                )
              : Text(
                  'Tambah Barang',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500, fontSize: 20),
                ),
          if (widget.isListBarang == true)
            Container(
              margin: EdgeInsets.only(right: SizeConfig.safeBlockVertical! * 2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 8, color: Color.fromARGB(255, 217, 217, 217)),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                        widget.barangModels,
                        listBarangController,
                        barangApiController,
                        setState,
                        context),
                  );
                },
                icon: const Icon(Icons.search, size: 36),
              ),
            ),
        ],
      ),
    );
  }
}
