import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/models/barang_models.dart';

class BarangController extends GetxController {
  final barangApiController = BarangApiController();
  var barangModels = <BarangModels>[].obs;

  Future<void> loadData(BuildContext context) async {
    final barang = await barangApiController.loadBarang(context);
    barangModels.clear();
    barangModels.addAll(barang);
  }
}
