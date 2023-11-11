import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/a/add_clear_widget.dart';
import 'package:toserba/widget/c/custom_app_bar_widget.dart';
import 'package:toserba/widget/i/image_picker_widget.dart';
import 'package:toserba/widget/n/nama_kode_widget.dart';
import 'package:toserba/widget/s/size_config.dart';

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
  var _enteredHargaJual = 0;
  var _enteredUnit = '';
  File? _enteredImage;
  final _labelTextStyle =
      GoogleFonts.inter(color: Color.fromRGBO(71, 75, 82, 1), fontSize: 18);

  Future<void> _saveBarang() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await widget.barangApiController.saveBarang(
          namaBarang: _enteredName,
          hargaBarang: _enteredHarga,
          kodeBarang: _enteredCode,
          stokBarang: _enteredStok,
          imageBarang: _enteredImage!.path,
          hargaJual: _enteredHargaJual,
          unit: _enteredUnit);

      final allBarang = await widget.barangApiController.loadBarang();
      setState(() {
        widget.barangApiController.barangModels = allBarang;
      });
      if (!context.mounted) return;

      Navigator.pushNamed(context, '/homeview');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 243),
      appBar: CustomAppBarWidget(
          barangModels: widget.barangModels, isListBarang: false),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 1,
              ),
              Container(
                height: SizeConfig.blockSizeVertical! * 56,
                width: SizeConfig.blockSizeVertical! * 47.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeVertical! * 4)),
                ),
                child: Column(children: [
                  SizedBox(height: SizeConfig.blockSizeVertical! * 4),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeVertical! * 0.3),
                      width: SizeConfig.blockSizeVertical! * 30,
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeVertical! * 1),
                      child: Text(
                        "Informasi Item",
                        style: _labelTextStyle.copyWith(
                            letterSpacing: 0.50,
                            fontSize: SizeConfig.blockSizeVertical! * 3,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeVertical! * 1,
                          right: SizeConfig.blockSizeVertical! * 1.5),
                      child: ImagePickerWidget(
                        isUser: false,
                        initialImage: null,
                        pickedImage: (image) {
                          _enteredImage = image;
                        },
                      ),
                    ),
                  ),
                  NamaKodeWidget(
                    initialValue: '',
                    onSaved: (val) {
                      _enteredName = val;
                    },
                    textStyle: _labelTextStyle.copyWith(
                      color: const Color.fromARGB(255, 116, 116, 116),
                    ),
                    labelText: "Nama Barang*",
                  ),
                  NamaKodeWidget(
                      initialValue: '',
                      onSaved: (val) {
                        _enteredUnit = val;
                      },
                      textStyle: _labelTextStyle.copyWith(
                          color: const Color.fromARGB(255, 116, 116, 116)),
                      labelText: "Unit*"),
                  NamaKodeWidget(
                      initialValue: '',
                      onSaved: (val) {
                        _enteredStok = int.parse(val);
                      },
                      textStyle: _labelTextStyle.copyWith(
                          color: const Color.fromARGB(255, 116, 116, 116)),
                      labelText: "Stok*"),
                ]),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical! * 1),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(left: SizeConfig.blockSizeVertical!),
                    width: SizeConfig.blockSizeVertical! * 47.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(SizeConfig.blockSizeVertical! * 4),
                        topRight:
                            Radius.circular(SizeConfig.blockSizeVertical! * 4),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.blockSizeVertical! * 4),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeVertical! * 1,
                              right: SizeConfig.blockSizeVertical! * 1.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Informasi Pembelian",
                                style: _labelTextStyle.copyWith(
                                    fontSize: SizeConfig.blockSizeVertical! * 3,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        NamaKodeWidget(
                            initialValue: '',
                            onSaved: (val) {
                              _enteredCode = val;
                            },
                            textStyle: _labelTextStyle.copyWith(
                                color:
                                    const Color.fromARGB(255, 116, 116, 116)),
                            labelText: "SKU*"),
                        NamaKodeWidget(
                            initialValue: '',
                            onSaved: (val) {
                              _enteredHarga = int.parse(val);
                            },
                            textStyle: _labelTextStyle.copyWith(
                                color:
                                    const Color.fromARGB(255, 116, 116, 116)),
                            labelText: "Harga Beli*"),
                        NamaKodeWidget(
                            initialValue: '',
                            onSaved: (val) {
                              _enteredHargaJual = int.parse(val);
                            },
                            textStyle: _labelTextStyle.copyWith(
                                color:
                                    const Color.fromARGB(255, 116, 116, 116)),
                            labelText: "Harga Jual*"),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 1.7,
                        ),
                        AddClearWidget(
                            onPressed: _saveBarang,
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 89, 84, 245)),
                            labelText: 'Tambah'),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 1.7,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}