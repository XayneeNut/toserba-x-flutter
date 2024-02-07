import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/api%20controller/admin_api_controller.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/controller/apps%20controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/a/admin_item_widget.dart';
import 'package:toserba/widget/a/app_bar_admin_widget.dart';
import 'package:toserba/widget/s/search_bar_widget.dart';
import 'package:toserba/widget/s/size_config.dart';

class ActivePageWidget extends StatefulWidget {
  const ActivePageWidget(
      {super.key,
      required this.barangModels,
      required this.deleteData,
      required this.barangModel});

  final List<BarangModels> barangModels;
  final BarangModels barangModel;
  final void Function(BarangModels barangModels) deleteData;

  @override
  State<ActivePageWidget> createState() => _ActivePageWidgetState();
}

class _ActivePageWidgetState extends State<ActivePageWidget> {
  final searchController = TextEditingController();
  List<BarangModels> filteredBarangModels = [];
  final barangApiController = BarangApiController();
  final listBarangController = ListBarangController();
  final adminApiController = AdminApiController();
  final appsController = AppsController();
  var groceryTextStyle =
      GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 30);
  String email = "";
  String username = "";
  bool _isLoading = true;
  final List<BarangModels> barangModels = [];

  var customTextStyle = GoogleFonts.ubuntu();

  @override
  void initState() {
    super.initState();
    loadAdminAccount();
    _loadItem();
  }

  Future<void> loadAdminAccount() async {
    final adminAccount = await adminApiController.loadAdminAccount();
    setState(() {
      email = adminAccount.email!;
      username = adminAccount.username!;
    });
  }

  void _loadItem() async {
    setState(() {
      _isLoading =
          true; // Set isLoading menjadi true saat proses loading dimulai
    });
    List<BarangModels> barang = await barangApiController.loadBarang(context);

    setState(() {
      _isLoading =
          false; // Set isLoading menjadi true saat proses loading dimulai
      barangModels.clear();
      barangModels.addAll(barang);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("sabar"), CircularProgressIndicator()],
            ),
          )
        : SingleChildScrollView(
            child: SizedBox(
              height: Get.height * 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.width * 0.068,
                  ),
                  AppBarAdminWidget(
                      username: username,
                      customTextStyle: customTextStyle,
                      barangModels: widget.barangModels,
                      listBarangController: listBarangController,
                      barangApiController: barangApiController),
                  SearchBarWidget(
                      barangModels: barangModels,
                      listBarangController: listBarangController,
                      barangApiController: barangApiController),
                  widget.barangModels.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'upss... Your item is empty',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal! * 100,
                              width: SizeConfig.blockSizeHorizontal! * 100,
                              child: Image.asset('assets/empty_list.png'),
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: Get.width * 0.03,
                                  top: Get.width * 0.07),
                              child: Column(
                                children: [
                                  Text(
                                    'Your Collection',
                                    style: GoogleFonts.ubuntu(
                                        fontSize: Get.width * 0.08),
                                  ),
                                ],
                              ),
                            ),
                            AdminItemWidget(
                              barangModels: barangModels,
                              itemTextStyle:
                                  groceryTextStyle.copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          );
  }
}
