// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/models/image_barang_model.dart';

class BarangApiController {
  List<BarangModels> barangModels = [];
  FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();

  Future<http.Response> getAllBarang(BuildContext context) async {
    final url = Uri.parse("http://localhost:8127/api/v1/barang/get-all");

    final response = await http.get(url);
    return response;
  }

  Future<List<BarangModels>> loadBarang(BuildContext context) async {
    final response = await getAllBarang(context);

    final jsonData = json.decode(response.body);

    final currentAccountId =
        await flutterSecureStorage.read(key: 'admin_account_id');

    List<BarangModels> barangModels = [];

    for (var allData in jsonData) {
      final accountId = allData['adminAccountEntity']['accountId'];
      List<dynamic> images = allData['imageBarang'];
      allData['imageBarang'] = images.map((imageData) {
        Uint8List bytes = base64Decode(imageData['gambar']);
        return ImageBarangModel(
          gambarId: imageData['gambarId'],
          gambar: bytes,
        );
      }).toList();
      final barang = BarangModels.fromJson(allData);

      if (accountId == int.parse(currentAccountId!)) {
        barangModels.add(barang);
      }
    }
    return barangModels;
  }

  Future<List<BarangModels>> loadAllUserBarang(BuildContext context) async {
    final response = await getAllBarang(context);
    final jsonData = json.decode(response.body);

    List<BarangModels> barangModels = [];

    for (var allData in jsonData) {
      // Ubah gambar menjadi List<ImageBarangModel>
      List<dynamic> images = allData['imageBarang'];
      allData['imageBarang'] = images.map((imageData) {
        Uint8List bytes = base64Decode(imageData['path']);
        return ImageBarangModel(
          gambarId: imageData['idImage'],
          gambar: bytes,
        );
      }).toList();

      final barang = BarangModels.fromJson(allData);
      barangModels.add(barang);
    }
    return barangModels;
  }

  Future<http.Response> saveBarang({
    required String namaBarang,
    required int hargaBarang,
    required String kodeBarang,
    required int stokBarang,
    required int hargaJual,
    required String unit,
    required String deskripsi,
  }) async {
    final url = Uri.parse("http://localhost:8127/api/v1/barang/create");
    final currentAccountId =
        await flutterSecureStorage.read(key: 'admin_account_id');

    try {
      final body = json.encode({
        'namaBarang': namaBarang,
        'hargaBarang': hargaBarang,
        'stokBarang': stokBarang,
        'kodeBarang': kodeBarang,
        'adminAccountEntity': currentAccountId,
        'hargaJual': hargaJual,
        'unit': unit,
        'deskripsi' : deskripsi,
      });
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);

      if (response.statusCode >= 400 || response.statusCode <= 499) {
        if (kDebugMode) {
          print(response.request);
        }
      }
      return response;
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<http.Response> getId(int id) async {
    final url = Uri.parse('http://localhost:8127/api/v1/barang/get/$id');
    final response = await http.get(url);
    return response;
  }

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
  }

  Future<void> updateBarang({
    required int idBarang,
    required String namaBarang,
    required int hargaBarang,
    required String kodeBarang,
    required int stokBarang,
    required String imageBarang,
    required int hargaJual,
    required String unit,
  }) async {
    final url = Uri.parse("http://localhost:8127/api/v1/barang/update");
    final currentAccountId =
        await flutterSecureStorage.read(key: 'admin_account_id');

    final body = json.encode({
      "namaBarang": namaBarang,
      "hargaBarang": hargaBarang,
      "kodeBarang": kodeBarang,
      "stokBarang": stokBarang,
      "imageBarang": imageBarang,
      "adminAccountEntity": int.parse(currentAccountId!),
      "hargaJual": hargaJual,
      "unit": unit,
    });
    try {
      final response = await http.put(
        url,
        body: body,
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Data barang berhasil diupdate");
        }
      } else {
        if (kDebugMode) {
          print(response.body);
          throw Exception("Gagal mengupdate data barang");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        throw Exception("Gagal terhubung ke server $e");
      }
    }
  }

  Future<http.Response> deleteBarang(BarangModels barangModels) {
    final url = Uri.parse(
        'http://localhost:8127/api/v1/barang/delete/${barangModels.idBarang}');

    final deleteById = http.delete(url);
    return deleteById;
  }
}
