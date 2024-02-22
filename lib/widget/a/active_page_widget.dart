import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/api%20controller/admin_api_controller.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/controller/api%20controller/user_account_api_controller.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/controller/apps%20controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/user/user_auth_view.dart';
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

class _ActivePageWidgetState extends State<ActivePageWidget>
    with AutomaticKeepAliveClientMixin {
  final searchController = TextEditingController();
  List<BarangModels> filteredBarangModels = [];
  final barangApiController = BarangApiController();
  final listBarangController = ListBarangController();
  final adminApiController = AdminApiController();
  final appsController = AppsController();
  final userAccountApiController = UserAccountApiController();
  final jwtApiController = JwtApiController();
  var storage = const FlutterSecureStorage();
  var groceryTextStyle =
      GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 30);
  String email = "";
  String username = "";
  bool _isLoading = true;
  bool _dataLoaded = false; // Track if data has been loaded
  List<BarangModels> barangModels = [];
  final loginAsDifferent = GoogleFonts.ubuntu();

  var customTextStyle = GoogleFonts.ubuntu();
  var loadingTextStyle = GoogleFonts.ubuntu(fontSize: 20);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadDataIfNeeded();
  }

  Future<void> _loadDataIfNeeded() async {
    if (!_dataLoaded) {
      await loadAdminAccount();
      _loadItem();
      _dataLoaded = true;
    }
  }

  Future<void> loadAdminAccount() async {
    final adminAccount = await adminApiController.loadAdminAccount();
    setState(() {
      email = adminAccount.email!;
      username = adminAccount.username!;
      _isLoading = false; // Update loading state
    });
  }

  void _loginAsUser() async {
    await storage.deleteAll();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => UserAuthView(
              jwtApiController: jwtApiController,
              userAccountApiController: userAccountApiController),
        ),
        (route) => false);
  }

  Future<List<BarangModels>> loadBarang() async {
    final barangModels = await barangApiController.loadBarangFromCache();
    return barangModels;
  }

  void _loadItem() async {
    setState(() {
      _isLoading = true;
    });
    List<BarangModels> barang = await barangApiController.loadBarangFromCache();
    setState(() {
      barangModels.clear();
      barangModels.addAll(barang);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
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
              barangApiController: barangApiController,
              onLogout: () => appsController.logoutAllertDialog(
                context,
                customTextStyle,
                customTextStyle,
                () => appsController.logout(
                    storage, context, jwtApiController, adminApiController),
              ),
              onLoginAsUser: () => appsController.loginAsDiferentAlertDialog(
                  context,
                  loginAsDifferent,
                  loginAsDifferent,
                  _loginAsUser,
                  'user'),
            ),
            SearchBarWidget(
                barangModels: barangModels,
                listBarangController: listBarangController,
                barangApiController: barangApiController),
            _isLoading
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Masih Loading", style: loadingTextStyle),
                        Text(
                          "Orang Sabar Disayangg Tuhan",
                          style: loadingTextStyle,
                        ),
                        SizedBox(
                          height: Get.width * 0.04,
                        ),
                        const CircularProgressIndicator()
                      ],
                    ),
                  )
                : widget.barangModels.isEmpty
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
                                left: Get.width * 0.03, top: Get.width * 0.07),
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
