import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toserba/models/pembelian_model.dart';

class SearchOrderWidget extends StatelessWidget {
  const SearchOrderWidget({super.key, required this.pembelianModel});

  final List<PembelianModel> pembelianModel;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(
      locale: 'ID',
      symbol: 'Rp',
    );
    var item = 'item:';
    numberFormat.minimumFractionDigits = 0;
    numberFormat.maximumFractionDigits = 0;
    return ListView.builder(
      itemCount: pembelianModel.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(Get.width * 0.04),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Color.fromARGB(255, 211, 210, 210),
                                spreadRadius: 2)
                          ],
                        ),
                        child: CircleAvatar(
                          radius: Get.width * 0.04,
                          backgroundImage: const AssetImage(
                              'assets/UserLoginAccountImage.png'),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.03),
                      Text(
                        pembelianModel[index]
                            .barangEntity!
                            .adminAccountEntity!
                            .username!,
                        style: GoogleFonts.ubuntu(fontSize: 17),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(CupertinoIcons.forward))
                    ],
                  ),
                  Text(
                    'Pesanan Selesai',
                    style: GoogleFonts.ubuntu(fontSize: 17),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: Get.width * 0.07),
                height: Get.width * 0.37,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.3,
                      height: Get.width * 0.3,
                      child: Image.memory(
                        fit: BoxFit.cover,
                        pembelianModel[index]
                            .barangEntity!
                            .imageBarang![0]
                            .gambar,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.04,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pembelianModel[index].barangEntity!.namaBarang!,
                            style: GoogleFonts.ubuntu(fontSize: 20),
                          ),
                          Text(
                            pembelianModel[index]
                                .detailPembelianEntity!
                                .catatan,
                            style: GoogleFonts.ubuntu(
                                fontSize: 15,
                                color:
                                    const Color.fromARGB(255, 132, 132, 132)),
                          ),
                          SizedBox(
                            height: Get.width * 0.07,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        numberFormat.format(
                                            pembelianModel[index]
                                                .detailPembelianEntity!
                                                .hargaSatuan),
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'x${pembelianModel[index].detailPembelianEntity!.jumlahBarang}',
                                            style: GoogleFonts.ubuntu(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          '${pembelianModel[index].detailPembelianEntity!.jumlahBarang} $item',
                                          style: GoogleFonts.roboto(
                                            fontSize: 17,
                                          )),
                                      Text(
                                        ' ${numberFormat.format(pembelianModel[index].detailPembelianEntity!.subtotal)}',
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
