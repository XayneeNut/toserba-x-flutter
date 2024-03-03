import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/api%20controller/user_account_api_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/view/shared/barang_detail_view.dart';
import 'package:toserba/widget/c/user_app_bar_widget.dart';
import 'package:toserba/widget/c/custom%20drawer%20widget/user_drawer_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeUserView extends StatefulWidget {
  const HomeUserView({super.key});

  @override
  State<HomeUserView> createState() => _HomeUserViewState();
}

class _HomeUserViewState extends State<HomeUserView> {
  final List<BarangModels> barangModels = [];
  final BarangApiController barangController = BarangApiController();
  final UserAccountApiController userApiController = UserAccountApiController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  UserAccountModel userAccountModel = UserAccountModel(
      userAccountId: 0,
      email: '',
      password: '',
      username: '',
      createdAt: DateTime(0),
      updateAt: DateTime(0),
      userAddressEntity: null,
      pembelianModel: null);

  Future<void> _getUserAccountId() async {
    final userAccountId = await storage.read(key: 'user-account-id');
    userAccountModel = await userApiController.loadUserData(
      int.parse(userAccountId!),
    );
    setState(() {
      userAccountModel;
    });
  }

  void _loadItem() async {
    List<BarangModels> barang =
        await barangController.loadAllUserBarang(context);

    setState(() {
      barangModels.clear();
      barangModels.addAll(barang);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadItem();
    _getUserAccountId();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'ID');
    var itemTextStyle = GoogleFonts.poppins();
    return Scaffold(
      drawer: UserDrawerWidget(userAccountModel: userAccountModel),
      backgroundColor: Colors.white,
      appBar: UserAppBarWidget.home(barangModels: const [], isListBarang: true),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.only(left: Get.width * 0.06, right: Get.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: Get.width * 0.06),
                padding: EdgeInsets.all(Get.width * 0.2),
                height: Get.width * 0.36,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 211, 211),
                  borderRadius: BorderRadius.circular(Get.width * 0.08),
                ),
              ),
              SizedBox(
                height: Get.width * 0.08,
              ),
              const Text("Available Product"),
              GridView.builder(
                itemCount: barangModels.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserBarangDetailView(
                              isAdmin: false,
                              barangModels: barangModels[index]),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 13,
                                color: Color.fromARGB(255, 212, 212, 212))
                          ]),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserBarangDetailView(
                                  isAdmin: false,
                                  barangModels: barangModels[index]),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 1.0,
                              child: ClipRRect(
                                child: Container(
                                  margin: EdgeInsets.all(Get.width * 0.01),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: MemoryImage(
                                        barangModels[index]
                                            .imageBarang![0]
                                            .gambar,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: Get.width * 0.024),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    barangModels[index].namaBarang!,
                                    style: itemTextStyle,
                                  ),
                                  SizedBox(height: Get.width * 0.01),
                                  Text(
                                    currencyFormatter.format(
                                      barangModels[index].hargaJual,
                                    ),
                                    style: itemTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
