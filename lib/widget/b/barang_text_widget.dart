import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/s/size_config.dart';

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
    final style = GoogleFonts.lato(
      decoration: TextDecoration.none,
      color: Colors.black,
      fontSize: SizeConfig.blockSizeVertical! * 2,
      fontWeight: FontWeight.w400,
      height: 0,
    );
    final titleStyle = GoogleFonts.mukta(
      decoration: TextDecoration.none,
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.w400,
      height: 0,
    );
    SizeConfig().init(context);
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeVertical! * 2,
              right: SizeConfig.blockSizeVertical! * 2),
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
                      aspectRatio: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: MemoryImage(
                                barangModels[index].imageBarang![0].gambar),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        barangModels[index].namaBarang!,
                        style: titleStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical! * 2.7),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'SKU : ',
                            style: style.copyWith(
                                fontSize: 17,
                                color: const Color.fromARGB(255, 93, 93, 93)),
                          ),
                          Text(
                            barangModels[index].kodeBarang!,
                            style: style.copyWith(fontSize: 17),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeVertical! * 2),
                    child: Column(
                      children: [
                        Text(
                          '${barangModels[index].stokBarang}',
                          style: style.copyWith(
                            fontSize: SizeConfig.blockSizeVertical! * 2.3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical! * 1),
                        Text(
                          barangModels[index].unit!,
                          style: style.copyWith(
                            fontSize: SizeConfig.blockSizeVertical! * 2.3,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 56, 56, 56),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
