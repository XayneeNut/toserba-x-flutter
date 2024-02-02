import 'package:flutter/material.dart';
import 'package:toserba/controller/api%20controller/barang_api_controller.dart';
import 'package:toserba/controller/list_barang_controller.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/view/admin/detail_barang_view.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<BarangModels> barangModels;
  final ListBarangController listBarangController;
  final BarangApiController barangApiController;

  final Function setState;
  final BuildContext
      parentContext; // Add this variable to hold the parent context

  CustomSearchDelegate(this.barangModels, this.listBarangController,
      this.barangApiController, this.setState, this.parentContext);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, 'back');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<BarangModels> searchResults = barangModels.where((barang) {
      return barang.namaBarang!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].namaBarang!),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<BarangModels> suggestionList = query.isEmpty
        ? []
        : barangModels.where((barang) {
            return barang.namaBarang!
                .toLowerCase()
                .contains(query.toLowerCase());
          }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].namaBarang!),
          onTap: () {
            Navigator.push(
                parentContext,
                MaterialPageRoute(
                  builder: (context) => DetailBarangView(
                    barangModels: suggestionList[index],
                  ),
                ));
          },
        );
      },
    );
  }
}
