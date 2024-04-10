import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:toserba/models/pembelian_model.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/widget/s/search_order_widget.dart';

class DetailOrderDelegate extends SearchDelegate<String> {
  final UserAccountModel userAccountModel;

  final Function setState;
  final BuildContext parentContext;

  DetailOrderDelegate(this.userAccountModel, this.setState, this.parentContext);

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super.appBarTheme(context).copyWith(
          appBarTheme: super.appBarTheme(context).appBarTheme.copyWith(
            
                elevation: 3,
                shadowColor: const Color.fromARGB(255, 231, 231, 231),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
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
    List<PembelianModel> searchResults =
        userAccountModel.pembelianModel!.where((pembelian) {
      return pembelian.barangEntity!.namaBarang!
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return SizedBox(
          height: Get.width * 2,
          child: SearchOrderWidget(pembelianModel: searchResults),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PembelianModel> searchResults =
        userAccountModel.pembelianModel!.where((pembelian) {
      return pembelian.barangEntity!.namaBarang!
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return SizedBox(
          height: Get.width * 1,
          child: SearchOrderWidget(pembelianModel: searchResults),
        );
      },
    );
  }
}
