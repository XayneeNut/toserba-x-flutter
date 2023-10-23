import 'package:flutter/material.dart';
import 'package:toserba/controller/barang_api_controller.dart';
import 'package:toserba/controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/create_barang_view.dart';
import 'package:toserba/widget/active_page_widget.dart';
import 'package:toserba/widget/custom_search_delegate.dart';
import 'package:toserba/widget/size_config.dart';

class ListBarangView extends StatefulWidget {
  const ListBarangView({super.key, required this.barangModels});

  final List<BarangModels> barangModels;

  @override
  State<ListBarangView> createState() => _ListBarangViewState();
}

class _ListBarangViewState extends State<ListBarangView>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  List<BarangModels> filteredBarangModels = [];
  final BarangApiController barangApiController = BarangApiController();
  final ListBarangController listBarangController = ListBarangController();
  int _selectedPageIndex = 0;
  AnimationController? _controller;
  Animation<Offset>? _offsetAnimation;

  void _onSelectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));
    listBarangController.loadItem(
        barangApiController, setState, widget.barangModels);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
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
    var selectedPageTitle = 'your item';
    SizeConfig().init(context);
    Widget activePage = ActivePageWidget(
      barangModels: widget.barangModels,
      deleteData: (barangModels) => deleteBarang(barangModels),
    );

    if (_selectedPageIndex == 2) {
      selectedPageTitle = 'Add Item';
      activePage = CreateBarangView(
        barangApiController: barangApiController,
        toCreateBarang: (p0, p1, p2, p3) => listBarangController.toCreateBarang(
            context, barangApiController, widget.barangModels, setState),
      );
    }
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: _onSelectedPage,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'favorit'),
              BottomNavigationBarItem(icon: Icon(Icons.create), label: 'create')
            ],
            backgroundColor: const Color.fromRGBO(241, 243, 236, 1)),
        backgroundColor: const Color.fromRGBO(253, 255, 250, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(143, 194, 13, 1),
          title: Text(selectedPageTitle),
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
        body: activePage);
  }
}
