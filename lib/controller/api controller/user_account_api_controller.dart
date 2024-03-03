import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/models/user_account_model.dart';

class UserAccountApiController {
  final jwtApiController = JwtApiController();
  final storage = const FlutterSecureStorage();
  final _appsController = AppsController();

  Future<http.Response> getById(int id) async {
    final url = Uri.parse("http://localhost:8127/api/v1/user-account/get/$id");
    final response = await http.get(url);
    return response;
  }

  Future<http.Response> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final url = Uri.parse(
        "http://localhost:8127/api/v1/user-account/get/$email/$password");

    final response = await http.get(url);
    final responseData = json.decode(response.body);
    final userAccountId = responseData['userAccountId'];

    await storage.write(
        key: 'user-account-id', value: userAccountId.toString());
    await storage.read(key: 'user-account-id');
    try {
      if (response.statusCode >= 400 || response.statusCode >= 499) {
        // ignore: use_build_context_synchronously
        _appsController.loginFailedAlertDialog(context);
        throw Exception("failed to save item");
      } else {
        throw Exception("failed to save item");
      }
    } catch (e) {}
    return response;
  }

  Future<UserAccountModel> saveUserDataToCache(
      UserAccountModel userAccountModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'user_account_data', json.encode(userAccountModel.toJson()));
    return userAccountModel;
  }

  Future<UserAccountModel> loadUserDataFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user_account_data');

    final jsonData = json.decode(jsonString!);
    UserAccountModel userAccountModel = UserAccountModel.fromJson(jsonData);
    return userAccountModel;
  }

  Future<UserAccountModel> loadUserData(int id) async {
    final url = Uri.parse("http://localhost:8127/api/v1/user-account/get/$id");
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    UserAccountModel userAccountModel = UserAccountModel.fromJson(jsonData);
    await saveUserDataToCache(userAccountModel);
    return userAccountModel;
  }

  Future<http.Response> signUp({
    required String email,
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    final url = Uri.parse("http://localhost:8127/api/v1/user-account/create");

    final body = json.encode({
      "email": email,
      "password": password,
      "username": username,
    });

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);
    final responseData = json.decode(response.body);
    final userAccountId = responseData['userAccountId'];
    await storage.write(
        key: 'user-account-id', value: userAccountId.toString());

    try {
      if (response.statusCode == 400) {
        // ignore: use_build_context_synchronously
        _appsController.loginFailedAlertDialog(context);
        print(response.body);
        throw Exception("failed to save item");
      } else {
        print(response.body);
        throw Exception("failed to save item");
      }
    } catch (e) {}
    return response;
  }
}
