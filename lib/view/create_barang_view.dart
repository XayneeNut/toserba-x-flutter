import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/add_clear_widget.dart';
import 'package:toserba/widget/custom_app_bar_widget.dart';
import 'package:toserba/widget/image_picker_widget.dart';
import 'package:toserba/widget/nama_kode_widget.dart';
import 'package:toserba/widget/size_config.dart';
import 'package:toserba/widget/stok_harga_widget.dart';
class CreateBarangView extends StatefulWidget {
  const CreateBarangView(
      {super.key,
      required this.barangApiController,
      required this.toCreateBarang,
      required this.barangModels});

  final BarangApiController barangApiController;
  final List<BarangModels> barangModels;
  final void Function(BuildContext, BarangApiController, List<BarangModels>,
      void Function(VoidCallback)) toCreateBarang;

  @override
  State<CreateBarangView> createState() => _CreateBarangViewState();
}

class _CreateBarangViewState extends State<CreateBarangView> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredHarga = 0;
  var _enteredStok = 0;
  var _enteredCode = '';
  File? _enteredImage;
  final _labelTextStyle =
      GoogleFonts.poppins(color: Colors.black, fontSize: 18);

  Future<void> _saveBarang() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await widget.barangApiController.saveBarang(
          namaBarang: _enteredName,
          hargaBarang: _enteredHarga,
          kodeBarang: _enteredCode,
          stokBarang: _enteredStok,
          imageBarang: _enteredImage!.path);

      final allBarang = await widget.barangApiController.loadBarang();
      setState(() {
        widget.barangApiController.barangModels = allBarang;
      });
      if (!context.mounted) return;

      Navigator.pushNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
          barangModels: widget.barangModels, isListBarang: false),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 3,
              ),
              ImagePickerWidget(
                pickedImage: (image) {
                  _enteredImage = image;
                },
              ),
              NamaKodeWidget(
                  initialValue: '',
                  onSaved: (val) {
                    _enteredName = val;
                  },
                  textStyle: _labelTextStyle,
                  labelText: "Nama Barang"),
              NamaKodeWidget(
                  initialValue: '',
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
                        initialValue: 0,
                        onSaved: (value) {
                          _enteredStok = value;
                        },
                        textStyle: _labelTextStyle,
                        labelText: "stok"),
                    const SizedBox(
                      width: 20,
                    ),
                    StokHargaWidget(
                        initialValue: 0,
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
                          onPressed: _saveBarang,
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
            ],
          ),
        ),
      ),
    );
  }
}
