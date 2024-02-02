import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toserba/controller/api%20controller/admin_api_controller.dart';
import 'package:toserba/controller/apps%20controller/auth_manager_controller.dart';
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/controller/api%20controller/user_account_api_controller.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:toserba/view/admin/auth_view.dart';
import 'package:toserba/view/admin/home_view.dart';
import 'package:toserba/view/user/home_user_view.dart';
import 'package:toserba/view/user/user_auth_view.dart';
import 'package:toserba/widget/s/size_config.dart';
import 'package:toserba/widget/s/stream_builder_widget.dart';

void main() {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(child: MyApp()),
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  JwtApiController jwtApiController = JwtApiController();
  AdminApiController adminApiController = AdminApiController();
  UserAccountApiController userAccountApiController =
      UserAccountApiController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final AuthManagerController authManagerController = AuthManagerController();
  late Stream<dynamic> _token;
  bool isAdmin = false;

  void _loadToken() {
    _token = storage.read(key: 'token').then(
      (token) {
        if (token != null) {
          final tokenData = JwtDecoder.decode(token);
          final groups = tokenData['groups'];
          if (groups.contains('admin')) {
            setState(() {
              isAdmin = true;
            });
          } else if (groups.contains('user')) {
            setState(() {
              isAdmin = false;
            });
          }
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
    authManagerController.validatingToken(storage: storage);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/user-auth-view': (context) => UserAuthView(
            jwtApiController: jwtApiController,
            userAccountApiController: userAccountApiController),
        '/user-home-view': (context) => const HomeUserView(),
        '/authview': (context) => AuthView(
            jwtApiController: jwtApiController,
            adminApiController: adminApiController),
        '/homeview': (context) => const HomeView(),
      },
      home: StreamBuilderWidget(
          isAdmin: isAdmin,
          token: _token,
          jwtApiController: jwtApiController,
          adminApiController: adminApiController,
          userAccountApiController: userAccountApiController),
    );
  }
}
