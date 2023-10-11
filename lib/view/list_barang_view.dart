import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/controller/barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/update_barang_widget.dart';
import 'package:toserba/widget/barang_text_widget.dart';
import 'package:toserba/view/create_barang_view.dart';
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
  final BarangController barangController = BarangController();

  @override
  void initState() {
    super.initState();
    filteredBarangModels.addAll(widget.barangModels);
    _loadItem();
  }

  void toCreateBarang() async {
    final newBarang = await Navigator.push<BarangModels>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CreateBarangView(newBarangController: barangController),
      ),
    );

    if (newBarang != null) {
      setState(() {
        widget.barangModels.add(newBarang);
      });
    }
  }

  void _loadItem() async {
    List<BarangModels> barang = await barangController.loadBarang();

    setState(() {
      widget.barangModels.clear();
      widget.barangModels.addAll(barang);
    });
  }

  void toUpdateBarang(int index) async {
    if (widget.barangModels.isNotEmpty) {
      final updateBarang = await Navigator.push<BarangModels>(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateBarangWidget(
              newBarangController: barangController,
              newBarangModels: widget.barangModels[index]),
        ),
      );
      if (updateBarang != null) {
        setState(() {
          _loadItem();
        });
      }
    }
  }

  void filterSearchResults(String query) {
    List<BarangModels> searchResults = [];
    if (query.isNotEmpty) {
      searchResults = widget.barangModels.where((barang) {
        return barang.namaBarang.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      searchResults.addAll(widget.barangModels);
    }
    setState(() {
      filteredBarangModels.clear();
      filteredBarangModels.addAll(searchResults);
    });
  }

  void deleteBarang(BarangModels barangModels) async {
    final response = await barangController.deleteBarang(barangModels);

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
                  delegate: CustomSearchDelegate(widget.barangModels));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.barangModels.length,
              itemBuilder: (context, index) => Dismissible(
                direction: DismissDirection.endToStart,
                onDismissed: (direction) =>
                    deleteBarang(widget.barangModels[index]),
                key: ValueKey(widget.barangModels[index].idBarang),
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
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                  onPressed: () => toUpdateBarang(index),
                                  child: const Text('edit'))),
                        ),
                      ),
                      BarangTextWidget(
                          index: index, barangModels: widget.barangModels),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: toCreateBarang,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFAD22),
                  fixedSize: Size(SizeConfig.blockSizeHorizontal! * 70,
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
