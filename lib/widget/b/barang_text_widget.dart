import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/s/size_config.dart';
import 'package:intl/intl.dart';

class BarangTextWidget extends ConsumerWidget {
  const BarangTextWidget(
      {super.key,
      required this.index,
      required this.barangModels,
      required this.barangModel});

  final int index;
  final List<BarangModels> barangModels;
  final BarangModels barangModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = NumberFormat.simpleCurrency(locale: 'id_ID');
    final style = GoogleFonts.ubuntu(
      decoration: TextDecoration.none,
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.w400,
      height: 0,
    );
    SizeConfig().init(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: SizeConfig.blockSizeVertical! * 10,
                height: SizeConfig.blockSizeVertical! * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AspectRatio(
                  aspectRatio: 1.0, // 1.0 means a square aspect ratio
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(barangModels[index].imageBarang),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10), // Add spacing between image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barangModels[index].namaBarang,
                    style: style,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formatter.format(barangModels[index].hargaBarang),
                    style: style.copyWith(fontSize: 15),
                  ),
                  Row(
                    children: [
                      Text(
                        'stok :',
                        style: style.copyWith(
                            fontSize: 17,
                            color: const Color.fromARGB(255, 125, 125, 125)),
                      ),
                      Text(
                        '${barangModels[index].stokBarang}',
                        style: style.copyWith(fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(), // Add this to push the IconButton to the right
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ))
            ],
          ),
          const Divider(color: Colors.black38),
        ],
      ),
    );
  }
}
