import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:toserba/controller/jwt_api_controller.dart';

class AdminApiController {
  final storage = const FlutterSecureStorage();
  final jwtController = JwtApiController();
  Future<http.Response> login(
      {required String email, required String password}) async {
    final url = Uri.parse(
        "http://10.0.2.2:8127/api/v1/admin-account/get/$email/$password");
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    final adminId = responseData['accountId'];
    await storage.write(key: 'admin_account_id', value: adminId.toString());
    return response;
  }

  Future<http.Response> createAdmin(
    String email,
    String username,
    String password,
  ) async {
    final url = Uri.parse("http://10.0.2.2:8127/api/v1/admin-account/create");

    final body = json
        .encode({'email': email, 'username': username, 'password': password});
    jwtController.getTokenJwt();
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);
    final responseData = json.decode(response.body);
    final adminAccountId = responseData['accountId'];
    await storage.write(
        key: 'admin_account_id', value: adminAccountId.toString());
    try {
      if (response.statusCode == 400) {
        print(response.body);
        throw Exception('Failed to save item');
      } else {
        print(response.body);
        throw Exception('Failed to save item');
      }
    } catch (e) {
      //handling error message
    }
    return response;
  }
}
