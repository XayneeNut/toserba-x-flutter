import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/api%20controller/image_barang_api_controller.dart';
import 'package:toserba/controller/apps%20controller/create_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/c/custom_app_bar_widget.dart';
import 'package:toserba/widget/i/informasi_item_widget.dart';
import 'package:toserba/widget/i/informasi_pembelian_widget.dart';
import 'package:toserba/widget/s/size_config.dart';

class CreateBarangView extends StatefulWidget {
  const CreateBarangView(
      {super.key,
      required this.createBarangController,
      required this.toCreateBarang,
      required this.barangModels,
      required this.barangApiController,
      required this.imageBarangApiController});

  final CreateBarangController createBarangController;
  final BarangApiController barangApiController;
  final ImageBarangApiController imageBarangApiController;
  final List<BarangModels> barangModels;
  final void Function(BuildContext, BarangApiController, List<BarangModels>,
      void Function(VoidCallback)) toCreateBarang;

  @override
  State<CreateBarangView> createState() => _CreateBarangViewState();
}

class _CreateBarangViewState extends State<CreateBarangView> {
  final _formKey = GlobalKey<FormState>();
  var enteredName = '';
  var enteredHarga = 0;
  var enteredStok = 0;
  var enteredCode = '';
  var enteredHargaJual = 0;
  var enteredUnit = '';
  var enteredDeskripsi = '';
  File? _enteredImage;
  final _labelTextStyle = GoogleFonts.ubuntu(
      color: const Color.fromRGBO(71, 75, 82, 1), fontSize: 18);

  Future<void> _saveBarang() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await widget.createBarangController.saveBarang(
          _formKey,
          widget.barangApiController,
          widget.imageBarangApiController,
          enteredName,
          enteredHarga,
          enteredCode,
          enteredStok,
          _enteredImage,
          setState,
          context,
          enteredHargaJual,
          enteredUnit,
          enteredDeskripsi);
      if (!context.mounted) return;

      final allBarang = await widget.barangApiController.loadBarang(context);
      setState(() {
        widget.barangApiController.barangModels = allBarang;
      });
      if (!context.mounted) return;

      Navigator.pushNamed(context, '/homeview');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 243),
      appBar: CustomAppBarWidget(
          barangModels: widget.barangModels, isListBarang: false),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(
                left: Get.width * 0.02, right: Get.width * 0.02),
            child: Column(
              children: [
                SizedBox(
                  height: Get.width * 0.03,
                ),
                Container(
                    height: Get.width * 1.57,
                    width: SizeConfig.blockSizeVertical! * 47.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.blockSizeVertical! * 4)),
                    ),
                    child: InformasiItemWidget(
                      labelTextStyle: _labelTextStyle,
                      onImageChange: (image) {
                        _enteredImage = image;
                      },
                      onNamaChanged: (val) {
                        enteredName = val;
                      },
                      onUnitChanged: (val) {
                        enteredUnit = val;
                      },
                      onStokChanged: (val) {
                        enteredStok = int.parse(val);
                      },
                      onDeskripsiChanged: (val) {
                        enteredDeskripsi = val;
                      },
                    )),
                SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(SizeConfig.blockSizeVertical! * 4),
                      topRight:
                          Radius.circular(SizeConfig.blockSizeVertical! * 4),
                    ),
                  ),
                  child: InformasiPembelianWidget(
                    labelTextStyle: _labelTextStyle,
                    saveBarang: _saveBarang,
                    onSavedCode: (val) {
                      enteredCode = val;
                    },
                    onSavedHargaBeli: (val) {
                      enteredHarga = int.parse(val);
                    },
                    onSavedHargaJual: (val) {
                      enteredHargaJual = int.parse(val);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
