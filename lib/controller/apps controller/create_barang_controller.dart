import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/api%20controller/image_barang_api_controller.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';

class CreateBarangController {
  FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
  Future<void> saveBarang(
    GlobalKey<FormState> formKey,
    BarangApiController barangApiController,
    ImageBarangApiController imageBarangApiController,
    String enteredName,
    int enteredHarga,
    String enteredCode,
    int enteredStok,
    File enteredImage,
    Function setState,
    BuildContext context,
    int enteredHargaJual,
    String enteredUnit,
  ) async {
    formKey = GlobalKey<FormState>();
    AppsController appsController = AppsController();
    appsController.waitingFor(
        context: context,
        title: "Wait a minute...",
        content: "this action may take more time");

    final response = await barangApiController.saveBarang(
        namaBarang: enteredName,
        hargaBarang: enteredHarga,
        kodeBarang: enteredCode,
        stokBarang: enteredStok,
        hargaJual: enteredHargaJual,
        unit: enteredUnit);

    final newBarang = await json.decode(response.body);
    if (!context.mounted) return;

    if (response.statusCode == 200) {
      final barangId = newBarang['idBarang'];
      print(barangId);
      await imageBarangApiController.saveImage(
          barangId: barangId, gambar: enteredImage);
    }

    final allBarang = await barangApiController.loadBarang(context);
    setState(() {
      barangApiController.barangModels = allBarang;
    });

    if (!context.mounted) return;
  }
}
