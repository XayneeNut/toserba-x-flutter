import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/c/update_app_bar_widget.dart';
import 'package:toserba/widget/i/image_picker_widget.dart';
import 'package:toserba/widget/n/nama_kode_widget.dart';
import 'package:toserba/widget/s/size_config.dart';

class DetailBarangView extends StatefulWidget {
  const DetailBarangView({super.key, required this.barangModels});

  final BarangModels barangModels;

  @override
  State<DetailBarangView> createState() => _DetailBarangViewState();
}

class _DetailBarangViewState extends State<DetailBarangView> {
  File? _convertUint8ListToFile(Uint8List? uint8list) {
    if (uint8list == null) return null;

    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/temp_image.png');

    tempFile.writeAsBytesSync(uint8list);

    return tempFile;
  }

  File? _getInitialImageFile() {
    // Decode the base64 string if it exists
    if (widget.barangModels.imageBarang != null) {
      Uint8List base64ImageBytes = widget.barangModels.imageBarang![0].gambar;
      return _convertUint8ListToFile(base64ImageBytes);
    } else {
      return null;
    }
  }

  final _labelTextStyle = GoogleFonts.inter(
      color: const Color.fromRGBO(71, 75, 82, 1), fontSize: 18);
  final appsController = AppsController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 243),
      appBar: UpdateAppBarWidget(barangModels: [], isUpdateBarang: false),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 1,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: SizeConfig.blockSizeVertical! * 0.6),
                height: SizeConfig.blockSizeVertical! * 70,
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
                  SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeVertical! * 1,
                          right: SizeConfig.blockSizeVertical! * 1.5),
                      child: ImagePickerWidget(
                        isUser: false,
                        initialImage: _getInitialImageFile(),
                        pickedImage: (image) {},
                      ),
                    ),
                  ),
                  NamaKodeWidget(
                    initialValue: widget.barangModels.namaBarang!,
                    onSaved: (val) {},
                    textStyle: _labelTextStyle.copyWith(
                      color: const Color.fromARGB(255, 116, 116, 116),
                    ),
                    labelText: "Nama Barang*",
                  ),
                  NamaKodeWidget(
                      initialValue: widget.barangModels.unit!,
                      onSaved: (val) {},
                      textStyle: _labelTextStyle.copyWith(
                          color: const Color.fromARGB(255, 116, 116, 116)),
                      labelText: "Unit*"),
                  NamaKodeWidget(
                      initialValue: widget.barangModels.stokBarang.toString(),
                      onSaved: (val) {},
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
                            initialValue: widget.barangModels.kodeBarang!,
                            onSaved: (val) {},
                            textStyle: _labelTextStyle.copyWith(
                                color:
                                    const Color.fromARGB(255, 116, 116, 116)),
                            labelText: "SKU*"),
                        NamaKodeWidget(
                            initialValue:
                                widget.barangModels.hargaBarang.toString(),
                            onSaved: (val) {},
                            textStyle: _labelTextStyle.copyWith(
                                color:
                                    const Color.fromARGB(255, 116, 116, 116)),
                            labelText: "Harga Beli*"),
                        NamaKodeWidget(
                            initialValue:
                                widget.barangModels.hargaJual.toString(),
                            onSaved: (val) {},
                            textStyle: _labelTextStyle.copyWith(
                                color:
                                    const Color.fromARGB(255, 116, 116, 116)),
                            labelText: "Harga Jual*"),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 1.7,
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
