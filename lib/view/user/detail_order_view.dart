import 'package:flutter/material.dart';
import 'package:toserba/controller/api%20controller/pembelian_api_controller.dart';
import 'package:toserba/models/pembelian_model.dart';

class DetailOrderView extends StatefulWidget {
  const DetailOrderView({super.key, required this.pembelianModel});

  final List<PembelianModel> pembelianModel;

  @override
  State<DetailOrderView> createState() => _DetailOrderViewState();
}

class _DetailOrderViewState extends State<DetailOrderView> {
  final _pembelianApiController = PembelianApiController();

  void _loadItem() async {
    List<PembelianModel> pembelian =
        await _pembelianApiController.loadPembelian(context);
    setState(() {
      widget.pembelianModel.clear();
      widget.pembelianModel.addAll(pembelian);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.pembelianModel.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                    widget.pembelianModel[index].detailPembelianEntity!.alamatPengiriman)
              ],
            ),
          );
        },
      ),
    );
  }
}
