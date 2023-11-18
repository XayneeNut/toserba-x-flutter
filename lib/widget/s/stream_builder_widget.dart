import 'package:flutter/material.dart';
import 'package:toserba/controller/admin_api_controller.dart';
import 'package:toserba/controller/jwt_api_controller.dart';
import 'package:toserba/controller/user_account_api_controller.dart';
import 'package:toserba/view/admin/auth_view.dart';
import 'package:toserba/view/admin/home_view.dart';
import 'package:toserba/view/user/home_user_view.dart';
import 'package:toserba/view/user/user_auth_view.dart';

class StreamBuilderWidget extends StatefulWidget {
  const StreamBuilderWidget(
      {super.key,
      required this.isAdmin,
      required this.token,
      required this.jwtApiController,
      required this.adminApiController,
      required this.userAccountApiController});

  final bool isAdmin;
  final Stream<dynamic> token;
  final JwtApiController jwtApiController;
  final AdminApiController adminApiController;
  final UserAccountApiController userAccountApiController;

  @override
  State<StreamBuilderWidget> createState() => _StreamBuilderWidgetState();
}

class _StreamBuilderWidgetState extends State<StreamBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isAdmin == true
        ? StreamBuilder(
            stream: widget.token,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final token = snapshot.data;
                if (token == null) {
                  return AuthView(
                      jwtApiController: widget.jwtApiController,
                      adminApiController: widget.adminApiController);
                }
                return const HomeView();
              }
              return AuthView(
                  jwtApiController: widget.jwtApiController,
                  adminApiController: widget.adminApiController);
            },
          )
        : StreamBuilder(
            stream: widget.token,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final token = snapshot.data;
                if (token == null) {
                  return UserAuthView(
                      jwtApiController: widget.jwtApiController,
                      userAccountApiController:
                          widget.userAccountApiController);
                }
                return const HomeUserView();
              }
              return UserAuthView(
                  jwtApiController: widget.jwtApiController,
                  userAccountApiController: widget.userAccountApiController);
            },
          );
  }
}
