import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/models/admin_account_model.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/a/add_clear_widget.dart';
import 'package:toserba/widget/c/update_app_bar_widget.dart';
import 'package:toserba/widget/n/nama_kode_widget.dart';
import 'package:toserba/widget/s/size_config.dart';
import 'package:toserba/widget/i/image_picker_widget.dart';

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
  File? _enteredImage;
  var _enteredHargaJual = 0;
  var _enteredUnit = '';
  final _labelTextStyle =
      GoogleFonts.poppins(color: Colors.black, fontSize: 18);

  void updateBarang() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
      final currentAccountId =
          await flutterSecureStorage.read(key: 'admin_account_id');
      final barangModel = BarangModels(
          idBarang: widget.newBarangModels.idBarang,
          namaBarang: _enteredName,
          kodeBarang: _enteredCode,
          hargaBarang: _enteredHarga,
          imageBarang: _enteredImage,
          stokBarang: _enteredStok,
          hargaJual: _enteredHargaJual,
          unit: _enteredUnit,
          adminAccountEntity: AdminAccountModel.second(
              accountId: int.parse(currentAccountId!)));

      final update = barangModel.toJson();

      await widget.newBarangController.updateBarang(
          idBarang: widget.newBarangModels.idBarang,
          hargaBarang: _enteredHarga,
          hargaJual: _enteredHargaJual,
          kodeBarang: _enteredCode,
          namaBarang: _enteredName,
          stokBarang: _enteredStok,
          imageBarang: _enteredImage!.path,
          unit: _enteredUnit);
      print(updateBarang);

      if (!context.mounted) return;

      Navigator.pop(
        context,
        update,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 243),
      appBar: UpdateAppBarWidget(barangModels: [], isUpdateBarang: true),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: SizeConfig.blockSizeVertical! * 0.6),
                height: SizeConfig.blockSizeVertical! * 60,
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
                  SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeVertical! * 1,
                          right: SizeConfig.blockSizeVertical! * 1.5),
                      child: ImagePickerWidget(
                        isUser: false,
                        initialImage: widget.newBarangModels.imageBarang,
                        pickedImage: (image) {
                          _enteredImage = image;
                        },
                      ),
                    ),
                  ),
                  NamaKodeWidget(
                    initialValue: widget.newBarangModels.namaBarang,
                    onSaved: (val) {
                      _enteredName = val;
                    },
                    textStyle: _labelTextStyle.copyWith(
                      color: const Color.fromARGB(255, 116, 116, 116),
                    ),
                    labelText: "Nama Barang*",
                  ),
                  NamaKodeWidget(
                      initialValue: widget.newBarangModels.unit,
                      onSaved: (val) {
                        _enteredUnit = val;
                      },
                      textStyle: _labelTextStyle.copyWith(
                          color: const Color.fromARGB(255, 116, 116, 116)),
                      labelText: "Unit*"),
                  NamaKodeWidget(
                      initialValue:
                          widget.newBarangModels.stokBarang.toString(),
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
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeVertical! * 0.6),
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
                            initialValue: widget.newBarangModels.kodeBarang,
                            onSaved: (val) {
                              _enteredCode = val;
                            },
                            textStyle: _labelTextStyle.copyWith(
                                color:
                                    const Color.fromARGB(255, 116, 116, 116)),
                            labelText: "SKU*"),
                        NamaKodeWidget(
                            initialValue:
                                widget.newBarangModels.hargaBarang.toString(),
                            onSaved: (val) {
                              _enteredHarga = int.parse(val);
                            },
                            textStyle: _labelTextStyle.copyWith(
                                color:
                                    const Color.fromARGB(255, 116, 116, 116)),
                            labelText: "Harga Beli*"),
                        NamaKodeWidget(
                            initialValue:
                                widget.newBarangModels.hargaJual.toString(),
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
                            onPressed: updateBarang,
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(255, 89, 84, 245)),
                            labelText: 'Update`'),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 2,
                        ),
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
