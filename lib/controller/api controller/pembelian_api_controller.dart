import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:toserba/models/pembelian_model.dart';

class PembelianApiController extends GetxController{
  final _pembelianList = <PembelianModel>[].obs;

  List<PembelianModel> get pembelianList => _pembelianList;

  Future<http.Response> savePembelian(
      {required int userAccountId,
      required int barangId,
      required int detailPembelianId}) async {
    final url = Uri.parse("http://localhost:8127/api/v1/pembelian/create");
    try {
      final body = json.encode({
        'userAccountEntity': userAccountId,
        'barangEntity': barangId,
        'detailPembelianEntity': detailPembelianId,
      });
      final response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      print(json.decode(response.body));
      return response;
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<http.Response> getAllPembelian(BuildContext context) async {
    final url = Uri.parse("http://localhost:8127/api/v1/pembelian/get-all");

    final response = await http.get(url);
    return response;
  }

  Future<List<PembelianModel>> loadPembelian(BuildContext context) async {
    final response = await getAllPembelian(context);
    final jsonData = json.decode(response.body);

    List<PembelianModel> pembelianModels = [];

    for (var allData in jsonData) {
      final pembelian = PembelianModel.fromJson(allData);
      pembelianModels.add(pembelian);
    }
    return pembelianModels;
  }
}
