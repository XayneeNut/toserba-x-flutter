import 'package:flutter/material.dart';
import 'package:toserba/models/barang_models.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<BarangModels> barangModels;

  CustomSearchDelegate(this.barangModels);

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
    // Build the actual search results based on the query
    List<BarangModels> searchResults = barangModels.where((barang) {
      return barang.namaBarang.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].namaBarang),
          // Add other information as needed
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types (optional)
    List<BarangModels> suggestionList = query.isEmpty
        ? []
        : barangModels.where((barang) {
            return barang.namaBarang.toLowerCase().contains(query.toLowerCase());
          }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].namaBarang),
          onTap: () {
            query = suggestionList[index].namaBarang;
            showResults(context);
          },
        );
      },
    );
  }
}