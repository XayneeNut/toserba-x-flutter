import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toserba/widget/a/add_clear_widget.dart';
import 'package:toserba/widget/n/nama_kode_widget.dart';

// ignore: must_be_immutable
class InformasiPembelianWidget extends StatelessWidget {
  const InformasiPembelianWidget(
      {super.key,
      required this.labelTextStyle,
      required this.saveBarang,
      required this.onSavedCode,
      required this.onSavedHargaBeli,
      required this.onSavedHargaJual});

  final TextStyle labelTextStyle;
  final Function(String val) onSavedCode;
  final Function(String val) onSavedHargaBeli;
  final Function(String val) onSavedHargaJual;
  final Function() saveBarang;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: Get.width * 0.01),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Informasi Pembelian",
            style: labelTextStyle.copyWith(
                fontSize: Get.width * 0.07, fontWeight: FontWeight.w600),
          ),
        ),
        NamaKodeWidget(
            initialValue: '',
            onSaved: onSavedCode,
            textStyle: labelTextStyle.copyWith(
                color: const Color.fromARGB(255, 116, 116, 116)),
            labelText: "Kode Barang"),
        NamaKodeWidget(
            keyboardType: TextInputType.number,
            initialValue: '',
            onSaved: onSavedHargaBeli,
            textStyle: labelTextStyle.copyWith(
                color: const Color.fromARGB(255, 116, 116, 116)),
            labelText: "Harga Beli"),
        NamaKodeWidget(
            keyboardType: TextInputType.number,
            initialValue: '',
            onSaved: onSavedHargaJual,
            textStyle: labelTextStyle.copyWith(
                color: const Color.fromARGB(255, 116, 116, 116)),
            labelText: "Harga Jual"),
        SizedBox(
          height: Get.width * 0.03,
        ),
        AddClearWidget(
            onPressed: saveBarang,
            backgroundColor: const MaterialStatePropertyAll(
                Color.fromARGB(255, 89, 84, 245)),
            labelText: 'Tambah'),
        SizedBox(
          height: Get.width * 0.03,
        )
      ],
    );
  }
}
