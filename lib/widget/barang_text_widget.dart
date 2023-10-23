import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/size_config.dart';
import 'package:intl/intl.dart';

class BarangTextWidget extends StatelessWidget {
  const BarangTextWidget(
      {super.key, required this.index, required this.barangModels});

  final int index;
  final List<BarangModels> barangModels;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(locale: 'id_ID');
    SizeConfig().init(context);
    return Stack(
      children: [
        Positioned(
          top: SizeConfig.blockSizeVertical! * 1,
          left: SizeConfig.blockSizeHorizontal! * 4.9,
          child: Text(
            barangModels[index].namaBarang,
            style: GoogleFonts.ubuntu(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
        Positioned(
          top: SizeConfig.blockSizeVertical! * 7.5,
          left: SizeConfig.blockSizeHorizontal! * 4.9,
          child: Text(
            formatter.format(barangModels[index].hargaBarang),
            style: GoogleFonts.montserrat(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            width: 55,
            height: 55,
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 12.0)],
              shape: BoxShape.circle,
              color: Color.fromRGBO(54, 54, 52, 1),
            ),
            child: Center(
              child: Text(
                barangModels[index].stokBarang.toString(),
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
