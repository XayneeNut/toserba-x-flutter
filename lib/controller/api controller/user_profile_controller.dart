import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:toserba/models/user_address_model.dart';

class UserProfileController {
  FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();

  Future<UserAddressModel> getUserProfileModelById(int id) async {
    final url = Uri.parse("http://localhost:8127/api/v1/user-profile/get/$id");
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    UserAddressModel userProfileModel = UserAddressModel.fromJson(responseData);
    return userProfileModel;
  }

  Future<http.Response> saveUserProfile({
    required String alamatLengkap,
    required String patokan,
    required String posCode,
    required int userAccountId,
  }) async {
    final url = Uri.parse("http://localhost:8127/api/v1/user-profile/create");

    final body = json.encode({
      "alamatlengkap": alamatLengkap,
      "patokan": patokan,
      "posCode": posCode,
      "userAccountEntity": userAccountId
    });

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);
    return response;
  }
}
