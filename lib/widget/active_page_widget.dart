import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/detail_barang_view.dart';
import 'package:toserba/widget/barang_text_widget.dart';
import 'package:toserba/widget/custom_app_bar_widget.dart';
import 'package:toserba/widget/size_config.dart';

class ActivePageWidget extends StatefulWidget {
  const ActivePageWidget({
    super.key,
    required this.barangModels,
    required this.deleteData,
    required this.barangModel
  });

  final List<BarangModels> barangModels;
  final BarangModels barangModel;
  final void Function(BarangModels barangModels) deleteData;

  @override
  State<ActivePageWidget> createState() => _ActivePageWidgetState();
}

class _ActivePageWidgetState extends State<ActivePageWidget> {
  TextEditingController searchController = TextEditingController();
  List<BarangModels> filteredBarangModels = [];
  final BarangApiController barangApiController = BarangApiController();
  final ListBarangController listBarangController = ListBarangController();
  var groceryTextStyle =
      GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 30);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.safeBlockVertical! * 5),
        CustomAppBarWidget(
            barangModels: widget.barangModels, isListBarang: true),
        Container(
          margin: const EdgeInsets.only(left: 12, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: SizeConfig.blockSizeVertical! * 16,
                    height: SizeConfig.blockSizeVertical! * 12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 202, 233, 237)),
                    child: Center(
                      child: Text(
                        'Find',
                        style: groceryTextStyle.copyWith(fontSize: 50),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Your Daily',
                    style: groceryTextStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Grocery',
                    style: groceryTextStyle.copyWith(fontSize: 32),
                  ),
                ],
              ),
            ],
          ),
        ),
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
                          ),
                        );
                      },
                      child: Container(
                        width: SizeConfig.blockSizeVertical! * 13,
                        height: SizeConfig.blockSizeVertical! * 13,
                        margin: const EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            Container(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shadows: const [
                                  BoxShadow(
                                    blurRadius: 10,
                                    color: Color.fromARGB(255, 201, 201, 201),
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                            BarangTextWidget(
                                index: index,
                                barangModels: widget.barangModels,
                                barangModel: widget.barangModel),
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