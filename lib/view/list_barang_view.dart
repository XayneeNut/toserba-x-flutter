import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/detail_barang_view.dart';
import 'package:toserba/widget/barang_text_widget.dart';
import 'package:toserba/widget/custom_search_delegate.dart';
import 'package:toserba/widget/size_config.dart';

class ListBarangView extends StatefulWidget {
  const ListBarangView({super.key, required this.barangModels});

  final List<BarangModels> barangModels;

  @override
  State<ListBarangView> createState() => _ListBarangViewState();
}

class _ListBarangViewState extends State<ListBarangView> {
  TextEditingController searchController = TextEditingController();
  List<BarangModels> filteredBarangModels = [];
  final BarangApiController barangApiController = BarangApiController();
  final ListBarangController listBarangController = ListBarangController();

  @override
  void initState() {
    super.initState();
    listBarangController.loadItem(
        barangApiController, setState, widget.barangModels);
  }

  void deleteBarang(BarangModels barangModels) async {
    final response = await barangApiController.deleteBarang(barangModels);

    setState(() {
      widget.barangModels.remove(barangModels);
    });

    response;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Item'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                      widget.barangModels,
                      listBarangController,
                      barangApiController,
                      setState,
                      context));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
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
                          deleteBarang(widget.barangModels[index]),
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
                                    borderRadius: BorderRadius.circular(30),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                listBarangController.toCreateBarang(context,
                    barangApiController, widget.barangModels, setState);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFAD22),
                  fixedSize: Size(SizeConfig.blockSizeHorizontal! * 40,
                      SizeConfig.blockSizeVertical! * 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70))),
              child: Text(
                'create',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
