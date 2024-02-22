import 'package:flutter/material.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/models/admin_account_model.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:flutter/services.dart';
import 'package:toserba/view/admin/list_barang_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<BarangModels> barangModels = [];
  final appsController = AppsController();
  BarangModels barangModel = BarangModels(
      idBarang: 0,
      namaBarang: '',
      kodeBarang: '',
      hargaBarang: 0,
      stokBarang: 0,
      imageBarang: [],
      deskripsi: '',
      adminAccountEntity: const AdminAccountModel(
          accountId: 0, email: "", username: "", password: ""),
      hargaJual: 0,
      unit: '');
  final BarangApiController barangController = BarangApiController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    _loadItem();
  }

  void _loadItem() async {
    List<BarangModels> barang = await barangController.loadBarang(context);

    setState(() {
      barangModels.clear();
      barangModels.addAll(barang);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListBarangView(
      barangModels: barangModels,
      barangModel: barangModel,
    );
  }
}
