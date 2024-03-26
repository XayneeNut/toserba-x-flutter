import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toserba/controller/api%20controller/user_account_api_controller.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/view/user/home_user_view.dart';
import 'package:toserba/widget/s/search_bar_order_widget.dart';

class DetailAppbarWidget extends StatefulWidget {
  const DetailAppbarWidget({super.key, required this.user});
  final UserAccountModel user;

  @override
  State<DetailAppbarWidget> createState() => _DetailAppbarWidgetState();
}

class _DetailAppbarWidgetState extends State<DetailAppbarWidget> {
  final userAccountApiController = UserAccountApiController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Get.off(() => const HomeUserView());
            },
            icon: Icon(CupertinoIcons.back)),
        SearchBarOrderWidget(user: widget.user),
        IconButton(
            onPressed: () {}, icon: Icon(CupertinoIcons.ellipsis_vertical))
      ],
    );
  }
}
