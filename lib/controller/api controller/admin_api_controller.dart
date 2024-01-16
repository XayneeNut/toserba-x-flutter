import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';

class AdminApiController {
  final storage = const FlutterSecureStorage();
  final jwtController = JwtApiController();
  final _appsController = AppsController();

  Future<http.Response> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final url = Uri.parse(
        "http://localhost:8127/api/v1/admin-account/get/$email/$password");
    final response = await http.get(url);
    if (response.statusCode >= 400 && response.statusCode <= 499) {
      // ignore: use_build_context_synchronously
      _appsController.response400AlertDialog(
          context: context,
          title: 'Waduh...',
          content: 'email atau password kamu salah wleee >/<');
    }
    final responseData = json.decode(response.body);

    final adminId = responseData['accountId'];
    await storage.write(key: 'admin_account_id', value: adminId.toString());
    await storage.read(key: 'admin_account_id');
    return response;
  }

  Future<http.Response> createAdmin(
    String email,
    String username,
    String password,
  ) async {
    final url = Uri.parse("http://localhost:8127/api/v1/admin-account/create");

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
        if (kDebugMode) {
          print(response.body);
        }
        throw Exception('Failed to save item');
      } else {
        if (kDebugMode) {
          print(response.body);
        }

        throw Exception('Failed to save item');
      }
    } catch (e) {
      //handling error message
    }
    return response;
  }

  Future<http.Response> getEmailById(int id) async {
    final url =
        Uri.parse('http://localhost:8127/api/v1/admin-account/get-id/$id');
    final response = await http.get(url);
    return response;
  }
}
