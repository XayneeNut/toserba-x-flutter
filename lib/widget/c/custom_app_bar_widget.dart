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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: widget.isListBarang == false
            ? SizeConfig.blockSizeVertical! * 4.83
            : 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
          Text(
            'add new barang',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
          ),
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
            child: widget.isListBarang == true
                ? IconButton(
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
                  )
                : IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.restore, size: 36),
                  ),
          ),
        ],
      ),
    );
  }
}
