import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/add_clear_widget.dart';
import 'package:toserba/widget/nama_kode_widget.dart';
import 'package:toserba/widget/size_config.dart';
import 'package:toserba/widget/stok_harga_widget.dart';

class UpdateBarangView extends StatefulWidget {
  const UpdateBarangView(
      {super.key,
      required this.newBarangController,
      required this.newBarangModels});

  final BarangApiController newBarangController;
  final BarangModels newBarangModels;

  @override
  State<UpdateBarangView> createState() => _UpdateBarangViewState();
}

class _UpdateBarangViewState extends State<UpdateBarangView> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredHarga = 0;
  var _enteredStok = 0;
  var _enteredCode = '';
  var _enteredImage = '';
  final _labelTextStyle =
      GoogleFonts.poppins(color: Colors.black, fontSize: 18);

  void updateBarang() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updateBarang = BarangModels(
          idBarang: widget.newBarangModels.idBarang,
          namaBarang: _enteredName,
          kodeBarang: _enteredCode,
          hargaBarang: _enteredHarga,
          stokBarang: _enteredStok,
          imageBarang: File(_enteredImage));

      await widget.newBarangController.updateBarang(updateBarang);

      if (!context.mounted) return;

      Navigator.pop(
        context,
        updateBarang,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Item',
          style: GoogleFonts.poppins(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              NamaKodeWidget(
                  initialValue: widget.newBarangModels.namaBarang,
                  onSaved: (val) {
                    _enteredName = val;
                  },
                  textStyle: _labelTextStyle,
                  labelText: "Nama Barang"),
              NamaKodeWidget(
                  initialValue: widget.newBarangModels.kodeBarang,
                  onSaved: (val) {
                    _enteredCode = val;
                  },
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
                        onSaved: (value) {
                          _enteredStok = value;
                        },
                        textStyle: _labelTextStyle,
                        labelText: "stok"),
                    const SizedBox(
                      width: 20,
                    ),
                    StokHargaWidget(
                        initialValue: widget.newBarangModels.hargaBarang,
                        onSaved: (value) {
                          _enteredHarga = value;
                        },
                        textStyle: _labelTextStyle,
                        labelText: "harga"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal! * 5,
                  top: SizeConfig.blockSizeVertical! * 5,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      AddClearWidget(
                          onPressed: updateBarang,
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFFFFAD22)),
                          labelText: 'Add'),
                      AddClearWidget(
                          onPressed: () {
                            _formKey.currentState!.reset();
                          },
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF8B97FF)),
                          labelText: 'Clear')
                    ],
                  ),
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
