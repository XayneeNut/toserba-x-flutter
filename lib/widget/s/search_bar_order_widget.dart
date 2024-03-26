import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/widget/d/detail_order_delegate.dart';

class SearchBarOrderWidget extends StatefulWidget {
  const SearchBarOrderWidget({super.key, required this.user});
  final UserAccountModel user;

  @override
  State<SearchBarOrderWidget> createState() => _SearchBarOrderWidgetState();
}

class _SearchBarOrderWidgetState extends State<SearchBarOrderWidget> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          constraints: BoxConstraints(
              minHeight: Get.width * 0.12, maxWidth: Get.width * 0.67),
          controller: controller,
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          onTap: () {
            showSearch(
                context: context,
                delegate: DetailOrderDelegate(widget.user, setState, context));
          },
          onChanged: (_) {
            controller.openView();
          },
          hintText: 'Cari pesanan anda',
          leading: const Icon(Icons.search),
        );
      }, suggestionsBuilder:
              (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(5, (int index) {
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              setState(() {
                controller.closeView(item);
              });
            },
          );
        });
      }),
    );
  }
}
