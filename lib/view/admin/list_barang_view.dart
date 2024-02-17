import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toserba/controller/api%20controller/admin_api_controller.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/api%20controller/image_barang_api_controller.dart';
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/controller/apps%20controller/create_barang_controller.dart';
import 'package:toserba/controller/apps%20controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/admin/create_barang_view.dart';
import 'package:toserba/widget/a/active_page_widget.dart';
import 'package:toserba/widget/c/custom_bottom_nav_bar_widget.dart';
import 'package:toserba/widget/s/size_config.dart';

class ListBarangView extends StatefulWidget {
  const ListBarangView(
      {super.key, required this.barangModels, required this.barangModel});

  final List<BarangModels> barangModels;
  final BarangModels barangModel;

  @override
  State<ListBarangView> createState() => _ListBarangViewState();
}

class _ListBarangViewState extends State<ListBarangView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();
  List<BarangModels> filteredBarangModels = [];
  final BarangApiController barangApiController = BarangApiController();
  final JwtApiController jwtApiController = JwtApiController();
  final AdminApiController adminApiController = AdminApiController();
  final ImageBarangApiController imageBarangApiController =
      ImageBarangApiController();
  final ListBarangController listBarangController = ListBarangController();
  final CreateBarangController createBarangController =
      CreateBarangController();
  int _selectedPageIndex = 0;
  AnimationController? _controller;
  var bottomIconColor = const Color.fromARGB(255, 143, 143, 143);
  var pressedButtonColor = Colors.white;
  final FlutterSecureStorage flutterSecureStorage =
      const FlutterSecureStorage();

  void _onSelectedPage(int index) async {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _onSelectedPage(_selectedPageIndex);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void deleteBarang(BarangModels barangModels) async {
    final response = await barangApiController.deleteBarang(barangModels);

    setState(() {
      widget.barangModels.remove(barangModels);
    });

    response;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SizeConfig().init(context);
    Widget activePage = ActivePageWidget(
      barangModels: widget.barangModels,
      deleteData: (barangModels) => deleteBarang(barangModels),
      barangModel: widget.barangModel,
    );

    if (_selectedPageIndex == 2) {
      activePage = CreateBarangView(
        barangModels: widget.barangModels,
        barangApiController: barangApiController,
        toCreateBarang: (p0, p1, p2, p3) => listBarangController.toCreateBarang(
            context,
            barangApiController,
            widget.barangModels,
            setState,
            createBarangController,
            imageBarangApiController),
        createBarangController: createBarangController,
        imageBarangApiController: imageBarangApiController,
      );
    }
    return Scaffold(
        bottomNavigationBar: CustomBottomNavBarWidget(
          bottomIconColor: bottomIconColor,
          pressedIconColor: pressedButtonColor,
          selectedPageIndex: _selectedPageIndex,
          onPageSelected: (index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
        ),
        backgroundColor: Colors.white,
        body: activePage);
  }
}
