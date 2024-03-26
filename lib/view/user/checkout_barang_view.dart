import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/api%20controller/detail_pembelian_api_controller.dart';
import 'package:toserba/controller/api%20controller/pembelian_api_controller.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/user/order_view.dart';
import 'package:toserba/widget/a/action_button_row.dart';
import 'package:toserba/widget/c/checkout%20barang%20widget/checkout_summary_widget.dart';
import 'package:toserba/widget/p/product_detail_widget.dart';
import 'package:toserba/widget/c/user_app_bar_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CheckoutBarangView extends StatefulWidget {
  const CheckoutBarangView({super.key, required this.barangModels});

  final BarangModels barangModels;

  @override
  State<CheckoutBarangView> createState() => _CheckoutBarangViewState();
}

class _CheckoutBarangViewState extends State<CheckoutBarangView> {
  final _detailPembelianApiController = DetailPembelianApiController();
  final _barangApiController = BarangApiController();
  final _pembelianApiController = PembelianApiController();
  final _flutterSecureStorage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  var jumlahItem = 1;
  bool proteksiTambahan = false;
  bool cod = false;
  bool alamat = false;
  String catatan = '';
  int? detailPembelianId;

  double _calculateTotalPrice() {
    return widget.barangModels.hargaJual!.toDouble() * jumlahItem;
  }

  double _calculateTotalTax() {
    return _calculateTotalPrice() * 0.05;
  }

  double _calculateSubtotal() {
    return _calculateTotalPrice() + _calculateTotalTax();
  }

  int _calculateNewStock() {
    var stok = widget.barangModels.stokBarang!;
    var newStok = stok - jumlahItem;
    return newStok;
  }

  Future<void> saveDetailBarang() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final appsController = AppsController();
      appsController.waitingFor(
          context: context,
          title: 'Wait a minute...',
          content: 'Wait for the transaction to complete');
      await _barangApiController.updateStok(
          idBarang: widget.barangModels.idBarang!,
          stokBarang: _calculateNewStock());
      final detailJson =
          await _detailPembelianApiController.saveDetailPembelian(
              jumlahBarang: jumlahItem,
              subtotal: _calculateSubtotal().toInt(),
              hargaSatuan: widget.barangModels.hargaJual!,
              catatan: catatan,
              alamatPengiriman: 'belum ada');
      final detailJsonData = json.decode(detailJson.body);
      detailPembelianId = detailJsonData['detailPembelianId'];
      await savePembelian();
      if (!context.mounted) return;
      Get.off(() => const OrderView());
    }
  }

  Future<void> savePembelian() async {
    final userAccountId =
        await _flutterSecureStorage.read(key: 'user-account-id');
    await _pembelianApiController.savePembelian(
        userAccountId: int.parse(userAccountId!),
        barangId: widget.barangModels.idBarang!,
        detailPembelianId: detailPembelianId!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hargaProteksiTambahan = 500;
    final detailSubtotalStyle = GoogleFonts.notoSansJavanese();
    final checkoutTextStyle = GoogleFonts.poppins(
        fontWeight: FontWeight.w700, fontSize: Get.width * 0.07);
    final itemTextStyle = GoogleFonts.notoSansJavanese(
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 57, 57, 57),
        letterSpacing: Get.width * 0.004);
    final bottomItemTextStyle = GoogleFonts.notoSansJavanese(
        fontWeight: FontWeight.normal,
        color: const Color.fromARGB(255, 57, 57, 57),
        letterSpacing: Get.width * 0.004);
    var elevatedButtonStyle = GoogleFonts.inter(
      fontWeight: FontWeight.bold,
    );
    var defaultButtonColor = const Color.fromARGB(255, 231, 231, 231);

    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp ');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          UserAppBarWidget.home(barangModels: const [], isListBarang: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(Get.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check Out',
                    style: checkoutTextStyle,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1 Item',
                        style: itemTextStyle,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.delete,
                          color: Color.fromARGB(255, 57, 57, 57),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 2,
                    color: Color.fromARGB(255, 103, 103, 103),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(Get.width * 0.02),
              child: ProductDetailWidget(
                barangModels: widget.barangModels,
                checkoutTextStyle: checkoutTextStyle,
                bottomItemTextStyle: bottomItemTextStyle,
                currencyFormatter: currencyFormatter,
                jumlahItem: jumlahItem,
                onAddPressed: () {
                  setState(
                    () {
                      jumlahItem++;
                    },
                  );
                  _calculateTotalPrice();
                  _calculateTotalTax();
                },
                onMinusPressed: () {
                  setState(
                    () {
                      if (jumlahItem > 1) {
                        jumlahItem--;
                      }
                    },
                  );
                  _calculateTotalPrice();
                  _calculateTotalTax();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(Get.width * 0.03),
              child: const Divider(
                height: 2,
                color: Color.fromARGB(255, 103, 103, 103),
              ),
            ),
            Form(
              key: _formKey,
              child: CheckoutSummaryWidget(
                onCatatanChange: (value) {
                  catatan = value;
                },
                alamat: alamat,
                cod: cod,
                proteksiTambahan: proteksiTambahan,
                detailSubtotalTextStyle: detailSubtotalStyle,
                currencyFormatter: currencyFormatter,
                hargaProteksiTambahan: hargaProteksiTambahan.toDouble(),
                calculateTotalPrice: () {
                  if (proteksiTambahan == true) {
                    _calculateTotalPrice();
                  }
                  return _calculateTotalPrice();
                },
                calculateTotalTax: () => _calculateTotalTax(),
                calculateSubtotal: () {
                  if (proteksiTambahan == true) {
                    var harga = _calculateSubtotal() + hargaProteksiTambahan;
                    return harga;
                  }
                  return _calculateSubtotal();
                },
                updateHarga: (value) {
                  setState(() {
                    proteksiTambahan = value;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: Get.width * 0.03),
              child: ActionButtonRowWidget(
                  defaultButtonColor: defaultButtonColor,
                  elevatedButtonStyle: elevatedButtonStyle,
                  onFirstButtonPressed: () {
                    Navigator.pop(context);
                  },
                  onSecondButtonPressed: () {
                    saveDetailBarang();
                  },
                  firstButtonTitle: 'cancel',
                  secondButtonTitle: 'confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
