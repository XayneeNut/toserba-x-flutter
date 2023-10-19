import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/models/barang_models.dart';

class CreateBarangController {
  Future<void> saveBarang(
      GlobalKey<FormState> formKey,
      BarangApiController barangApiController,
      String enteredName,
      int enteredHarga,
      String enteredCode,
      int enteredStok,
      Function setState,
      BuildContext context) async {
        formKey = GlobalKey<FormState>();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await barangApiController.saveBarang(
          namaBarang: enteredName,
          hargaBarang: enteredHarga,
          kodeBarang: enteredCode,
          stokBarang: enteredStok);
      print(enteredName);
      print(enteredHarga);
      print(enteredCode);
      print(enteredStok);

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
            stokBarang: enteredStok),
      );
    }
  }
}
