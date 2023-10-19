import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/nama_kode_widget.dart';
import 'package:toserba/widget/size_config.dart';
import 'package:toserba/widget/stok_harga_widget.dart';

class DetailBarangView extends StatefulWidget {
  const DetailBarangView(
      {super.key,
      required this.newBarangController,
      required this.newBarangModels});

  final BarangApiController newBarangController;
  final BarangModels newBarangModels;

  @override
  State<DetailBarangView> createState() => _DetailBarangViewState();
}

class _DetailBarangViewState extends State<DetailBarangView> {
  final _labelTextStyle =
      GoogleFonts.poppins(color: Colors.black, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Item',
          style: GoogleFonts.poppins(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              NamaKodeWidget(
                  initialValue: widget.newBarangModels.namaBarang,
                  onSaved: (val) {},
                  textStyle: _labelTextStyle,
                  labelText: "Nama Barang"),
              NamaKodeWidget(
                  initialValue: widget.newBarangModels.kodeBarang,
                  onSaved: (val) {},
                  textStyle: _labelTextStyle,
                  labelText: "Kode Barang"),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal! * 5,
                  vertical: SizeConfig.blockSizeVertical! * 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StokHargaWidget(
                        initialValue: widget.newBarangModels.stokBarang,
                        onSaved: (value) {},
                        textStyle: _labelTextStyle,
                        labelText: "stok"),
                    const SizedBox(
                      width: 20,
                    ),
                    StokHargaWidget(
                        initialValue: widget.newBarangModels.hargaBarang,
                        onSaved: (value) {},
                        textStyle: _labelTextStyle,
                        labelText: "harga"),
                  ],
                ),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 100,
                height: SizeConfig.blockSizeHorizontal! * 100,
                child: SvgPicture.asset(
                  'assets/gambar.svg',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
