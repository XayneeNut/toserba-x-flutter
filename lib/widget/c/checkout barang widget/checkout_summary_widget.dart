import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutSummaryWidget extends StatefulWidget {
  const CheckoutSummaryWidget(
      {super.key,
      required this.alamat,
      required this.cod,
      required this.proteksiTambahan,
      required this.detailSubtotalTextStyle,
      required this.currencyFormatter,
      required this.calculateTotalPrice,
      required this.calculateTotalTax,
      required this.calculateSubtotal,
      required this.hargaProteksiTambahan,
      required this.updateHarga});

  final bool alamat;
  final bool cod;
  final bool proteksiTambahan;
  final TextStyle detailSubtotalTextStyle;
  final NumberFormat currencyFormatter;
  final double Function() calculateTotalPrice;
  final double Function() calculateTotalTax;
  final double Function() calculateSubtotal;
  final double hargaProteksiTambahan;
  final void Function(bool value) updateHarga;

  @override
  State<CheckoutSummaryWidget> createState() => _CheckoutSummaryWidgetState();
}

class _CheckoutSummaryWidgetState extends State<CheckoutSummaryWidget> {
  var alamat = false;
  var cod = false;
  var proteksiTambahan = false;
  var hargaProteksiTambahan = 0.0;

  @override
  void initState() {
    super.initState();
    alamat = widget.alamat;
    cod = widget.cod;
    proteksiTambahan = widget.proteksiTambahan;
    hargaProteksiTambahan = widget.hargaProteksiTambahan;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: Get.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: alamat,
                          onChanged: (value) {
                            setState(
                              () {
                                alamat = !alamat;
                              },
                            );
                          },
                        ),
                        Text('Gunakan alamat saat ini')
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: Get.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: cod,
                          onChanged: (value) {
                            setState(
                              () {
                                cod = !cod;
                              },
                            );
                          },
                        ),
                        Text('COD')
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: Get.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: proteksiTambahan,
                          onChanged: (value) {
                            widget.updateHarga(value ?? false);

                            proteksiTambahan = value ?? false;
                            print('$proteksiTambahan dari widget');
                            widget.calculateSubtotal();

                            if (value! == true) {
                              widget.calculateSubtotal();
                            }
                            print(widget.calculateSubtotal());
                          },
                        ),
                        Text('Proteksi tambahan')
                      ],
                    ),
                    Text('IDR 500,00')
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(Get.width * 0.03),
            child: const Divider(
              height: 2,
              color: Color.fromARGB(255, 103, 103, 103),
            ),
          ),
          Container(
            margin: EdgeInsets.all(Get.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subtotal',
                      style: widget.detailSubtotalTextStyle,
                    ),
                    Text(
                      'Tax',
                      style: widget.detailSubtotalTextStyle,
                    ),
                    SizedBox(
                      height: Get.width * 0.1,
                    ),
                    Text(
                      'Total',
                      style: widget.detailSubtotalTextStyle.copyWith(
                          fontSize: Get.width * 0.045,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.currencyFormatter.format(
                        widget.calculateTotalPrice(),
                      ),
                      style: widget.detailSubtotalTextStyle,
                    ),
                    Text(
                      widget.currencyFormatter.format(
                        widget.calculateTotalTax(),
                      ),
                      style: widget.detailSubtotalTextStyle,
                    ),
                    SizedBox(
                      height: Get.width * 0.1,
                    ),
                    Text(
                      widget.currencyFormatter.format(
                        widget.calculateSubtotal(),
                      ),
                      style: widget.detailSubtotalTextStyle.copyWith(
                          fontSize: Get.width * 0.045,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
