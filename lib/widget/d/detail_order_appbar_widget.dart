import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/apps%20controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/s/search_bar_order_widget.dart';
import 'package:toserba/widget/s/search_bar_widget.dart';

class DetailAppbarWidget extends StatefulWidget {
  const DetailAppbarWidget({super.key});

  @override
  State<DetailAppbarWidget> createState() => _DetailAppbarWidgetState();
}

class _DetailAppbarWidgetState extends State<DetailAppbarWidget> {
  List<BarangModels> barangModels = [];
  final listBarangController = ListBarangController();
  final barangApiController = BarangApiController();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.back)),
        SearchBarOrderWidget(),
        IconButton(
            onPressed: () {}, icon: Icon(CupertinoIcons.ellipsis_vertical))
      ],
    );
  }
}
