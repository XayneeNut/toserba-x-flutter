import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/shared/barang_detail_view.dart';

class AdminItemWidget extends StatefulWidget {
  const AdminItemWidget(
      {super.key, required this.barangModels, required this.itemTextStyle});

  final List<BarangModels> barangModels;
  final TextStyle itemTextStyle;

  @override
  State<AdminItemWidget> createState() => _AdminItemWidgetState();
}

class _AdminItemWidgetState extends State<AdminItemWidget> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp');
  var margin = Get.width * 0.04;
  double borderRadius = 15;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 1.4,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
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
                      builder: (context) => UserBarangDetailView(
                          isAdmin: true,
                          barangModels: widget.barangModels[index])),
                );
              },
              child: Container(
                height: Get.width * 2,
                margin: EdgeInsets.only(
                    left: margin, right: margin, bottom: margin, top: margin),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 253, 251),
                    border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 196, 196, 196)),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.4), // Warna shadow dan opasitasnya
                        blurRadius: 10, // Besarnya blur radius
                        offset: const Offset(0, 3),
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(borderRadius),
                          topRight: Radius.circular(borderRadius),
                        ),
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
                          left: Get.width * 0.02, top: Get.width * 0.007),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.width * 0.02,
                          ),
                          Text(
                            widget.barangModels[index].namaBarang!,
                            style: GoogleFonts.roboto(
                              fontSize: Get.width * 0.043,
                            ),
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
            return Container();
          }
        },
      ),
    );
  }
}
