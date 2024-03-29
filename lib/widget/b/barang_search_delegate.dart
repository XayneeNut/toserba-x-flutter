import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/widget/a/admin_item_widget.dart';

class BarangSearchDelegate extends SearchDelegate<String> {
  final List<BarangModels> barangModels;

  final Function setState;
  final BuildContext parentContext;

  BarangSearchDelegate(this.barangModels, this.setState, this.parentContext);

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super.appBarTheme(context).copyWith(
          appBarTheme: super.appBarTheme(context).appBarTheme.copyWith(
              elevation: 3,
              shadowColor: const Color.fromARGB(255, 231, 231, 231),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              )),
        );
  }

  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => GoogleFonts.ubuntu();

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'search your item';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
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
        return AdminItemWidget(
          barangModels: suggestionList,
          itemTextStyle: GoogleFonts.ubuntu(),
        );
      },
    );
  }
}
