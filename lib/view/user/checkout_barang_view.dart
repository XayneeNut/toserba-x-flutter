import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/a/action_button_row.dart';
import 'package:toserba/widget/c/checkout%20barang%20widget/checkout_summary_widget.dart';
import 'package:toserba/widget/c/checkout%20barang%20widget/product_detail_widget.dart';
import 'package:toserba/widget/c/user_app_bar_widget.dart';

class CheckoutBarangView extends StatefulWidget {
  const CheckoutBarangView({super.key, required this.barangModels});

  final BarangModels barangModels;

  @override
  State<CheckoutBarangView> createState() => _CheckoutBarangViewState();
}

class _CheckoutBarangViewState extends State<CheckoutBarangView> {
  var jumlahItem = 1;
  bool proteksiTambahan = false;
  bool cod = false;
  bool alamat = false;

  double calculateTotalPrice() {
    return widget.barangModels.hargaJual.toDouble() * jumlahItem;
  }

  double calculateTotalTax() {
    return calculateTotalPrice() * 0.05;
  }

  double calculateSubtotal() {
    return calculateTotalPrice() + calculateTotalTax();
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

    final currencyFormatter = NumberFormat.currency(locale: 'ID');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: UserAppBarWidget(barangModels: [], isListBarang: false),
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
                  calculateTotalPrice();
                  calculateTotalTax();
                },
                onMinusPressed: () {
                  setState(
                    () {
                      if (jumlahItem > 1) {
                        jumlahItem--;
                      }
                    },
                  );
                  calculateTotalPrice();
                  calculateTotalTax();
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
            CheckoutSummaryWidget(
              alamat: alamat,
              cod: cod,
              proteksiTambahan: proteksiTambahan,
              detailSubtotalTextStyle: detailSubtotalStyle,
              currencyFormatter: currencyFormatter,
              hargaProteksiTambahan: hargaProteksiTambahan.toDouble(),
              calculateTotalPrice: () {
                if (proteksiTambahan == true) {
                  calculateTotalPrice();
                }
                return calculateTotalPrice();
              },
              calculateTotalTax: () => calculateTotalTax(),
              calculateSubtotal: () {
                print('$proteksiTambahan dari view');
                if (proteksiTambahan == true) {
                  var harga = calculateSubtotal() + hargaProteksiTambahan;
                  print(harga);
                  return harga;
                }
                return calculateSubtotal();
              },
              updateHarga: (value) {
                setState(() {
                  proteksiTambahan = value;
                });
              },
            ),
            Container(
              margin: EdgeInsets.only(left: Get.width * 0.03),
              child: ActionButtonRowWidget(
                  defaultButtonColor: defaultButtonColor,
                  elevatedButtonStyle: elevatedButtonStyle,
                  onFirstButtonPressed: () {
                    Navigator.pop(context);
                  },
                  onSecondButtonPressed: () {},
                  firstButtonTitle: 'cancel',
                  secondButtonTitle: 'confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
