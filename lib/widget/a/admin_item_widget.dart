import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/admin/detail_barang_view.dart';

class AdminItemWidget extends StatefulWidget {
  const AdminItemWidget(
      {super.key, required this.barangModels, required this.itemTextStyle});

  final List<BarangModels> barangModels;
  final TextStyle itemTextStyle;

  @override
  State<AdminItemWidget> createState() => _AdminItemWidgetState();
}

class _AdminItemWidgetState extends State<AdminItemWidget> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  var margin = Get.width * 0.04;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 1.4,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          // Check if index is within bounds of barangModels list
          if (index < widget.barangModels.length) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailBarangView(
                      barangModels: widget.barangModels[index],
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: margin, right: margin, bottom: margin),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(
                                widget
                                    .barangModels[index].imageBarang![0].gambar,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: Get.width * 0.007, top: Get.width * 0.007),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.barangModels[index].namaBarang!,
                            style: widget.itemTextStyle,
                          ),
                          SizedBox(height: Get.width * 0.01),
                          Text(
                            currencyFormatter.format(
                              widget.barangModels[index].hargaJual,
                            ),
                            style: widget.itemTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Return an empty container if index is out of bounds
            return Container();
          }
        },
      ),
    );
  }
}
