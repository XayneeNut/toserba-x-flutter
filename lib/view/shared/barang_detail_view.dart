import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/user/checkout_barang_view.dart';
import 'package:toserba/widget/a/action_button_row.dart';
import 'package:toserba/widget/c/user_app_bar_widget.dart';

class UserBarangDetailView extends StatefulWidget {
  const UserBarangDetailView(
      {Key? key, required this.barangModels, required this.isAdmin})
      : super(key: key);

  final BarangModels barangModels;
  final bool isAdmin;

  @override
  State<UserBarangDetailView> createState() => _UserBarangDetailViewState();
}

class _UserBarangDetailViewState extends State<UserBarangDetailView> {
  var elevatedButtonStyle = GoogleFonts.inter(
    fontWeight: FontWeight.bold,
  );
  var subtitleStyle = GoogleFonts.poppins(fontWeight: FontWeight.w500);
  var selectedSize = "none";
  var defaultButtonColor = const Color.fromARGB(255, 231, 231, 231);
  late List<Image> image;
  final AppsController appsController = AppsController();

  void toCheckoutBarang() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CheckoutBarangView(barangModels: widget.barangModels),
        ));
  }

  @override
  void initState() {
    super.initState();
    image = appsController.loadImage(
      widget.barangModels,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'ID');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: UserAppBarWidget.home(barangModels: [], isListBarang: false),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: Get.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: Get.width * 0.03,
                        bottom: Get.width * 0.03,
                        right: Get.width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fill, image: image[0].image),
                    ),
                  ),
                ),
              ),
              const Column(children: []),
              Row(
                children: [
                  Text(
                    "Size",
                    style: elevatedButtonStyle.copyWith(
                        color: const Color.fromARGB(255, 50, 50, 50),
                        fontSize: Get.width * 0.05),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  SizedBox(
                    height: Get.width * 0.12,
                    width: Get.width * 0.24,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedSize = "Small";
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: selectedSize == "Small"
                            ? Colors.black
                            : defaultButtonColor,
                        textStyle: elevatedButtonStyle,
                      ),
                      child: Text(
                        "Small",
                        style: elevatedButtonStyle.copyWith(
                          color: selectedSize == "Small"
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  SizedBox(
                    height: Get.width * 0.12,
                    width: Get.width * 0.27,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedSize = "Medium";
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.white,
                        backgroundColor: selectedSize == "Medium"
                            ? Colors.black
                            : defaultButtonColor,
                        textStyle: elevatedButtonStyle,
                      ),
                      child: Text(
                        "Medium",
                        style: elevatedButtonStyle.copyWith(
                          color: selectedSize == "Medium"
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  SizedBox(
                    height: Get.width * 0.12,
                    width: Get.width * 0.24,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedSize = "Large";
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: selectedSize == "Large"
                            ? Colors.black
                            : defaultButtonColor,
                        textStyle: elevatedButtonStyle,
                      ),
                      child: Text(
                        "Large",
                        style: elevatedButtonStyle.copyWith(
                          color: selectedSize == "Large"
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.width * 0.06,
              ),
              Text(
                widget.barangModels.namaBarang!,
                style: elevatedButtonStyle.copyWith(fontSize: Get.width * 0.09),
              ),
              SizedBox(
                height: Get.width * 0.02,
              ),
              Container(
                margin: EdgeInsets.only(right: Get.width * 0.05),
                child: Text(
                  widget.barangModels.deskripsi!,
                  style: subtitleStyle.copyWith(
                    fontSize: Get.width * 0.037,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: Get.width * 0.02,
              ),
              Text(
                currencyFormatter.format(widget.barangModels.hargaJual),
                style: subtitleStyle.copyWith(fontSize: Get.width * 0.056),
              ),
              SizedBox(
                height: Get.width * 0.07,
              ),
              ActionButtonRowWidget(
                  defaultButtonColor: defaultButtonColor,
                  elevatedButtonStyle: elevatedButtonStyle,
                  onFirstButtonPressed: () {},
                  onSecondButtonPressed: toCheckoutBarang,
                  firstButtonTitle: widget.isAdmin == true ? 'delete' : 'cart',
                  secondButtonTitle:
                      widget.isAdmin == true ? 'update' : 'checkout'),
            ],
          ),
        ),
      ),
    );
  }
}
