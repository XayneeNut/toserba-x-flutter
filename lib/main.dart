import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toserba/controller/admin_api_controller.dart';
import 'package:toserba/controller/jwt_api_controller.dart';
import 'package:toserba/controller/user_account_api_controller.dart';
import 'package:toserba/view/admin/auth_view.dart';
import 'package:toserba/view/admin/home_view.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:toserba/view/user/user_auth_view.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  JwtApiController jwtApiController = JwtApiController();
  AdminApiController adminApiController = AdminApiController();
  late Stream<dynamic> _token;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  void _validatingToken() async {
    final token = await storage.read(key: 'token');

    if (token != null) {
      if (JwtDecoder.isExpired(token)) {
        storage.deleteAll();
      }
    }
  }

  void _loadToken() {
    _token = storage.read(key: 'token').then(
      (token) {
        if (token != null) {
          return Stream.fromIterable([token]);
        } else if (token == null) {
          return null;
        }
      },
    ).asStream();
  }

  @override
  void initState() {
    super.initState();
    _loadToken();
    _validatingToken();
  }

  @override
  Widget build(BuildContext context) {
    var jwtApiController = JwtApiController();
    var userAccountController = UserAccountApiController();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserAuthView(
          jwtApiController: jwtApiController,
          userAccountApiController: userAccountController),
    );
  }
}
