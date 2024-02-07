import 'package:flutter/material.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/api%20controller/image_barang_api_controller.dart';
import 'package:toserba/controller/apps%20controller/create_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/admin/create_barang_view.dart';
import 'package:toserba/view/admin/update_barang_view.dart';

class ListBarangController {
  void toCreateBarang(
    BuildContext context,
    BarangApiController barangApiController,
    List<BarangModels> barangModels,
    Function setState,
    CreateBarangController createBarangController,
    ImageBarangApiController imageBarangApiController,
  ) async {
    final newBarang = await Navigator.push<BarangModels>(
      context,
      MaterialPageRoute(
        builder: (context) => CreateBarangView(
          barangModels: barangModels,
          barangApiController: barangApiController,
          toCreateBarang: (p0, p1, p2, p3) {},
          createBarangController: createBarangController,
          imageBarangApiController: imageBarangApiController,
        ),
      ),
    );

    if (newBarang != null) {
      setState(
        () {
          barangModels.add(newBarang);
        },
      );
    }
  }

  void toUpdateBarang(
    int index,
    List<BarangModels> barangModels,
    BuildContext context,
    BarangApiController barangApiController,
    Function setState,
  ) async {
    if (barangModels.isNotEmpty) {
      final updateBarang = await Navigator.push<BarangModels>(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateBarangView(
              newBarangController: barangApiController,
              newBarangModels: barangModels[index]),
        ),
      );
      if (updateBarang != null) {
        setState(
          () {
            loadItem(barangApiController, setState, context, barangModels);
          },
        );
      }
    }
  }

  void loadItem(BarangApiController barangApiController, Function setState,
      BuildContext context, List<BarangModels> barangModels) async {
    List<BarangModels> barang = await barangApiController.loadBarang(context);

    setState(
      () {
        barangModels.clear();
        barangModels.addAll(barang);
      },
    );
  }
}
