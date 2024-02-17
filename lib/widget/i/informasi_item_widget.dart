import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toserba/widget/i/image_picker_widget.dart';
import 'package:toserba/widget/n/nama_kode_widget.dart';

// ignore: must_be_immutable
class InformasiItemWidget extends StatelessWidget {
  InformasiItemWidget(
      {super.key,
      required this.labelTextStyle,
      required this.onNamaChanged,
      required this.onUnitChanged,
      required this.onStokChanged,
      required this.onDeskripsiChanged,
      required this.onImageChange});
  final TextStyle labelTextStyle;
  final Function(String) onNamaChanged;
  final Function(String) onUnitChanged;
  final Function(String) onStokChanged;
  final Function(String) onDeskripsiChanged;
  final void Function(File) onImageChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              height: Get.width * 0.1,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Informasi Item",
                style: labelTextStyle.copyWith(
                    letterSpacing: 0.50,
                    fontSize: Get.width * 0.07,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.all(Get.width * 0.03),
                child: ImagePickerWidget(
                  isUser: false,
                  initialImage: null,
                  pickedImage: onImageChange,
                ),
              ),
            ),
            NamaKodeWidget(
              initialValue: '',
              onSaved: onNamaChanged,
              textStyle: labelTextStyle.copyWith(
                color: const Color.fromARGB(255, 116, 116, 116),
              ),
              labelText: "Nama Barang",
            ),
            NamaKodeWidget(
                initialValue: '',
                onSaved: onUnitChanged,
                textStyle: labelTextStyle.copyWith(
                    color: const Color.fromARGB(255, 116, 116, 116)),
                labelText: "Unit"),
            NamaKodeWidget(
                initialValue: '',
                keyboardType: TextInputType.number,
                onSaved: onStokChanged,
                textStyle: labelTextStyle.copyWith(
                    color: const Color.fromARGB(255, 116, 116, 116)),
                labelText: "Stok"),
            NamaKodeWidget(
                initialValue: '',
                onSaved: onDeskripsiChanged,
                textStyle: labelTextStyle.copyWith(
                    color: const Color.fromARGB(255, 116, 116, 116)),
                labelText: "Deskripsi"),
          ],
        ),
      ],
    );
  }
}
