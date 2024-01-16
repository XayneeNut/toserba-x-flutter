
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/c/checkout%20barang%20widget/jumlah_item_widget.dart';

// ignore: must_be_immutable
class ProductDetailWidget extends StatefulWidget {
  const ProductDetailWidget(
      {super.key,
      required this.barangModels,
      required this.checkoutTextStyle,
      required this.bottomItemTextStyle,
      required this.currencyFormatter,
      required this.jumlahItem,
      required this.onAddPressed,
      required this.onMinusPressed});

  final BarangModels barangModels;
  final TextStyle checkoutTextStyle;
  final TextStyle bottomItemTextStyle;
  final NumberFormat currencyFormatter;
  final int jumlahItem;
  final VoidCallback onAddPressed;
  final VoidCallback onMinusPressed;

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  int localJumlahItem = 0;
  late Image image;
  final AppsController appsController = AppsController();

  @override
  void initState() {
    super.initState();
    localJumlahItem = widget.jumlahItem;
    image = appsController.loadImage(widget.barangModels);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          child: Container(
            height: Get.width * 0.4,
            width: Get.width * 0.32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: image.image,
              ),
            ),
          ),
        ),
        SizedBox(
          width: Get.width * 0.03,
        ),
        Expanded(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.barangModels.namaBarang,
                  style: widget.checkoutTextStyle
                      .copyWith(fontSize: Get.width * 0.05),
                ),
                Text(
                  widget.currencyFormatter
                      .format(widget.barangModels.hargaJual),
                  style: widget.checkoutTextStyle
                      .copyWith(fontSize: Get.width * 0.035),
                ),
                SizedBox(
                  height: Get.width * 0.03,
                ),
                Text(
                  '----------------',
                  style: widget.bottomItemTextStyle,
                ),
                Text(
                  'Size : M',
                  style: widget.bottomItemTextStyle,
                ),
                Text(
                  'Color : Black',
                  style: widget.bottomItemTextStyle,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: Get.width * 0.15,
        ),
        Container(
          margin:
              EdgeInsets.only(top: Get.width * 0.04, right: Get.width * 0.025),
          height: Get.width * 0.286,
          width: Get.width * 0.09,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(blurRadius: 5, color: Colors.grey),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: JumlahItemWidget(
              onAddPressed: () => widget.onAddPressed(),
              onMinusPressed: () => widget.onMinusPressed(),
              jumlahItem: localJumlahItem),
        ),
      ],
    );
  }
}
