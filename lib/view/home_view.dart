import 'package:flutter/material.dart';
import 'package:toserba/controller/barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/list_barang_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<BarangModels> barangModels = [];
  final BarangController barangController = BarangController();

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    List<BarangModels> barang = await barangController.loadBarang();

    setState(() {
      barangModels.clear();
      barangModels.addAll(barang);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListBarangView(barangModels: barangModels);
  }
}
