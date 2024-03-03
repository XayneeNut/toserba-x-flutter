import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toserba/controller/api%20controller/user_account_api_controller.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/widget/d/detail_order_appbar_widget.dart';

class DetailOrderView extends StatefulWidget {
  const DetailOrderView({super.key, this.userAccountModel});

  final UserAccountModel? userAccountModel;

  @override
  State<DetailOrderView> createState() => _DetailOrderViewState();
}

class _DetailOrderViewState extends State<DetailOrderView> {
  final _userController = UserAccountApiController();
  final _flutterSecureStorage = const FlutterSecureStorage();
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    _loadItem();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _visible = !_visible;
      });
    });
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
  }

  Future<UserAccountModel> _loadItem() async {
    var id = await _flutterSecureStorage.read(key: 'user-account-id');

    return await _userController.loadUserData(int.parse(id!));
  }

  Future<UserAccountModel> _loadFromCache() async {
    return await _userController.loadUserDataFromCache();
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(
      locale: 'ID',
      symbol: 'Rp',
    );
    numberFormat.minimumFractionDigits = 0;
    numberFormat.maximumFractionDigits = 0;
    var item = 'item:';
    return Scaffold(
      body: FutureBuilder(
        future: _loadFromCache(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Error: ${snapshot.error}');
          } else {
            final userAccountModel = snapshot.data;
            return ListView.builder(
              itemCount: userAccountModel!.pembelianModel!.length,
              itemBuilder: (context, index) {
                return AnimatedOpacity(
                  opacity: _visible ? 0.0 : 1.0,
                  duration: const Duration(seconds: 4),
                  child: Container(
                    margin: EdgeInsets.all(Get.width * 0.04),
                    child: Column(
                      children: [
                        const DetailAppbarWidget(),
                        SizedBox(height: Get.width * 0.08,),
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            color: Color.fromARGB(
                                                255, 211, 210, 210),
                                            spreadRadius: 2)
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: Get.width * 0.04,
                                      backgroundImage: const AssetImage(
                                          'assets/UserLoginAccountImage.png'),
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.03),
                                  Text(
                                    userAccountModel
                                        .pembelianModel![index]
                                        .barangEntity!
                                        .adminAccountEntity!
                                        .username!,
                                    style: GoogleFonts.ubuntu(fontSize: 17),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.forward))
                                ],
                              ),
                              Text(
                                'Pesanan Selesai',
                                style: GoogleFonts.ubuntu(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Get.width * 0.07),
                          height: Get.width * 0.37,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width * 0.3,
                                height: Get.width * 0.3,
                                child: Image.memory(
                                  fit: BoxFit.cover,
                                  userAccountModel.pembelianModel![index]
                                      .barangEntity!.imageBarang![0].gambar,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.04,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userAccountModel.pembelianModel![index]
                                          .barangEntity!.namaBarang!,
                                      style: GoogleFonts.ubuntu(fontSize: 20),
                                    ),
                                    Text(
                                      userAccountModel.pembelianModel![index]
                                          .detailPembelianEntity!.catatan,
                                      style: GoogleFonts.ubuntu(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              255, 132, 132, 132)),
                                    ),
                                    SizedBox(
                                      height: Get.width * 0.07,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  numberFormat.format(
                                                      userAccountModel
                                                          .pembelianModel![
                                                              index]
                                                          .detailPembelianEntity!
                                                          .hargaSatuan),
                                                  style: GoogleFonts.ubuntu(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'x${userAccountModel.pembelianModel![index].detailPembelianEntity!.jumlahBarang}',
                                                      style: GoogleFonts.ubuntu(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                    '${userAccountModel.pembelianModel![index].detailPembelianEntity!.jumlahBarang} $item',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 17,
                                                    )),
                                                Text(
                                                  ' ${numberFormat.format(userAccountModel.pembelianModel![index].detailPembelianEntity!.subtotal)}',
                                                  style: GoogleFonts.ubuntu(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
