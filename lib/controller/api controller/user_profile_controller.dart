import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:toserba/models/user_profile_model.dart';

class UserProfileController {
  FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();

  Future<UserProfileModel> getUserProfileModelById(int id) async {
    final url = Uri.parse("http://10.0.2.2:8127/api/v1/user-profile/get/$id");
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    UserProfileModel userProfileModel = UserProfileModel.fromJson(responseData);
    return userProfileModel;
  }

  Future<http.Response> saveUserProfile({
    required String patokanAlamat,
    required File userPoto,
    required String codePos,
    required String alamatLengkap,
    required int userAccountId,
  }) async {
    final url = Uri.parse("http://10.0.2.2:8127/api/v1/user-profile/create");

    final body = json.encode({
      "patokanAlamat": patokanAlamat,
      "userPoto": userPoto,
      "kodePos": codePos,
      "alamatLengkap": alamatLengkap,
      "userAccountId": userAccountId
    });

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);
    return response;
  }
}
