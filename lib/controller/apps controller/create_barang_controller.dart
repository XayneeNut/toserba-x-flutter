import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/models/barang_models.dart';

class CreateBarangController {
  FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
  Future<void> saveBarang(
    GlobalKey<FormState> formKey,
    BarangApiController barangApiController,
    String enteredName,
    int enteredHarga,
    String enteredCode,
    int enteredStok,
    String enteredImage,
    Function setState,
    BuildContext context,
    int enteredHargaJual, 
    String enteredUnit,
  ) async {
    formKey = GlobalKey<FormState>();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final currentAccountId =
          await flutterSecureStorage.read(key: 'admin_account_id');
      await barangApiController.saveBarang(
        namaBarang: enteredName,
        hargaBarang: enteredHarga,
        kodeBarang: enteredCode,
        stokBarang: enteredStok,
        imageBarang: enteredImage,
        hargaJual: enteredHargaJual,
        unit: enteredUnit
      );
      final allBarang = await barangApiController.loadBarang();
      setState(() {
        barangApiController.barangModels = allBarang;
      });

      final getIdBarang =
          await barangApiController.getId(allBarang.first.idBarang);
      final jsonData = json.decode(getIdBarang.body);

      final idBarang = jsonData['idBarang'];

      if (!context.mounted) return;

      Navigator.pop(
        context,
        BarangModels(
            idBarang: idBarang,
            namaBarang: enteredName,
            kodeBarang: enteredCode,
            hargaBarang: enteredHarga,
            stokBarang: enteredStok,
            imageBarang: File(enteredImage),
            accountId: int.parse(currentAccountId!),
            hargaJual: enteredHargaJual,
            unit: enteredUnit),
      );
    }
  }
}
