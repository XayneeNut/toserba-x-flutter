import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:toserba/models/detail_pembelian_model.dart';

class DetailPembelianApiController {
  FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();

  Future<DetailPembelianModel> getDetailBarangById(int id) async {
    final url =
        Uri.parse("http://localhost:8127/api/v1/detail-pembelian/get-id/$id");
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    DetailPembelianModel detailPembelianModel =
        DetailPembelianModel.fromJson(responseData);
    return detailPembelianModel;
  }

  Future<http.Response> saveDetailPembelian({
    required int jumlahBarang,
    required int subtotal,
    required int hargaSatuan,
    required String catatan,
    required String alamatPengiriman,
  }) async {
    final url =
        Uri.parse("http://localhost:8127/api/v1/detail-pembelian/create");

    final body = json.encode({
      "jumlahBarang": jumlahBarang,
      "subtotal": subtotal,
      "hargaSatuan": hargaSatuan,
      "catatan": catatan,
      "alamatPengiriman": alamatPengiriman,
    });

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);
    final responseData = json.decode(response.body);
    try {
      if (response.statusCode == 200) {
        var detailPembelianId = responseData['detailPembelianId'];
        print(detailPembelianId);
        getDetailBarangById(detailPembelianId);
      } else if (response.statusCode == 400) {
        if (kDebugMode) {
          print(responseData);
          throw Exception("failed to save item");
        }
      } else {
        if (kDebugMode) {
          print(responseData);
          throw Exception("failed to save item");
        }
      }
    } catch (e) {
      throw Exception("problem on your server $e");
    }
    return response;
  }
}
