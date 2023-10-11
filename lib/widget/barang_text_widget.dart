import 'package:flutter/material.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:google_fonts/google_fonts.dart';
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
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 19,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        Positioned(
          top: SizeConfig.blockSizeVertical! * 5,
          left: SizeConfig.blockSizeHorizontal! * 4.9,
          child: Text(
            formatter.format(barangModels[index].hargaBarang),
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 19,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        Positioned(
          top: SizeConfig.blockSizeVertical! * 8,
          left: SizeConfig.blockSizeHorizontal! * 4.9,
          child: Text('jumlah stok ${barangModels[index].stokBarang}',
              style: GoogleFonts.poppins(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.w500,
                height: 0,
              )),
        ),
      ],
    );
  }
}
