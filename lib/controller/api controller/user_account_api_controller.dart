import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:toserba/controller/api%20controller/jwt_api_controller.dart';
import 'package:toserba/models/user_account_model.dart';

class UserAccountApiController {
  final jwtApiController = JwtApiController();
  final storage = const FlutterSecureStorage();

  Future<http.Response> getUserEmailById(int id) async {
    final url =
        Uri.parse("http://10.0.2.2:8127/api/v1/user-account/get-id/$id");
    final response = await http.get(url);
    return response;
  }

  Future<UserAccountModel> getUserAccountAndUserProfile(int id) async {
    final url = Uri.parse(
        "http://10.0.2.2:8127/api/v1/user-account/get-by-profile/$id");
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    UserAccountModel userAccountModel = UserAccountModel.fromJson(jsonData);
    return userAccountModel;
  }

  Future<http.Response> login(
      {required String email, required String password}) async {
    final url = Uri.parse(
        "http://10.0.2.2:8127/api/v1/user-account/get/$email/$password");

    final response = await http.get(url);
    final responseData = json.decode(response.body);
    final userAccountId = responseData['userAccountId'];
    print(response.statusCode);
    await storage.write(
        key: 'user-account-id', value: userAccountId.toString());
    final adminAccount = await storage.read(key: 'user-account-id');
    print("user id dari controller $adminAccount");
    try {
      if (response.statusCode == 400) {
        print(response.body);
        throw Exception("failed to save item");
      } else {
        print(response.body);
        throw Exception("failed to save item");
      }
    } catch (e) {}
    return response;
  }

  Future<http.Response> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    final url = Uri.parse("http://10.0.2.2:8127/api/v1/user-account/create");

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
