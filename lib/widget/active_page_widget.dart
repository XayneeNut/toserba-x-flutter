import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/detail_barang_view.dart';
import 'package:toserba/widget/barang_text_widget.dart';
import 'package:toserba/widget/size_config.dart';

class ActivePageWidget extends StatefulWidget {
  const ActivePageWidget(
      {super.key, required this.barangModels, required this.deleteData});

  final List<BarangModels> barangModels;
  final void Function(BarangModels barangModels) deleteData;

  @override
  State<ActivePageWidget> createState() => _ActivePageWidgetState();
}

class _ActivePageWidgetState extends State<ActivePageWidget> {
  TextEditingController searchController = TextEditingController();
  List<BarangModels> filteredBarangModels = [];
  final BarangApiController barangApiController = BarangApiController();
  final ListBarangController listBarangController = ListBarangController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: widget.barangModels.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'upss... Your item is empty',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal! * 100,
                      width: SizeConfig.blockSizeHorizontal! * 100,
                      child: Image.asset('assets/empty_list.png'),
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: widget.barangModels.length,
                  itemBuilder: (context, index) => Dismissible(
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) =>
                        widget.deleteData(widget.barangModels[index]),
                    key: ValueKey(widget.barangModels[index].idBarang),
                    child: GestureDetector(
                      onTap: () => listBarangController.toUpdateBarang(
                        index,
                        widget.barangModels,
                        context,
                        barangApiController,
                        setState,
                      ),
                      onDoubleTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailBarangView(
                                newBarangController: barangApiController,
                                newBarangModels: widget.barangModels[index],
                              ),
                            ));
                      },
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal! * 0.2,
                        height: SizeConfig.blockSizeVertical! * 13,
                        margin: const EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            Container(
                              decoration: ShapeDecoration(
                                color: const Color(0xFFD9D9D9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                            BarangTextWidget(
                                index: index,
                                barangModels: widget.barangModels),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
