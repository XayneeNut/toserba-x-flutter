import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:toserba/models/barang_models.dart';

class BarangApiController {
  List<BarangModels> barangModels = [];
  FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();

  Future<http.Response> getAllBarang() async {
    final url = Uri.parse("http://10.0.2.2:8127/api/v1/barang/get-all");

    final response = await http.get(url);
    return response;
  }

  Future<List<BarangModels>> loadBarang() async {
    final response = await getAllBarang();
    final jsonData = json.decode(response.body);
    final currentAccountId =
        await flutterSecureStorage.read(key: 'admin_account_id');

    List<BarangModels> barangModels = [];

    for (var allData in jsonData) {
      final idBarang = allData['idBarang'];
      final namaBarang = allData['namaBarang'];
      final kodeBarang = allData['kodeBarang'];
      final hargaBarang = allData['hargaBarang'];
      final stokBarang = allData['stokBarang'];
      final imageBarang = allData['imageBarang'];
      final accountId = allData['adminAccountEntity']['accountId'];
      final unit = allData['unit'];
      final hargaJual = allData['hargaJual'];
      final barang = BarangModels(
          idBarang: idBarang,
          namaBarang: namaBarang,
          kodeBarang: kodeBarang,
          hargaBarang: hargaBarang,
          stokBarang: stokBarang,
          imageBarang: File(imageBarang as String),
          accountId: accountId,
          hargaJual: hargaJual,
          unit: unit);

      if (accountId == int.parse(currentAccountId!)) {
        barangModels.add(barang);
      }
    }
    print(jsonData);
    return barangModels;
  }

  Future<void> saveBarang({
    required String namaBarang,
    required int hargaBarang,
    required String kodeBarang,
    required int stokBarang,
    required String imageBarang,
    required int hargaJual,
    required String unit,
  }) async {
    final url = Uri.parse("http://10.0.2.2:8127/api/v1/barang/create");
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
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception("failed to save item");
      }
    } catch (e) {
      throw Exception("failed to connect to the server");
    }
  }

  Future<http.Response> getId(int id) async {
    final url = Uri.parse('http://10.0.2.2:8127/api/v1/barang/get/$id');
    final response = await http.get(url);
    return response;
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
    final url = Uri.parse("http://10.0.2.2:8127/api/v1/barang/update");
    final currentAccountId =
        await flutterSecureStorage.read(key: 'admin_account_id');

    final body = json.encode({
      "idBarang" : idBarang,
      "namaBarang": namaBarang,
      "hargaBarang": hargaBarang,
      "kodeBarang": kodeBarang,
      "stokBarang": stokBarang,
      "imageBarang": imageBarang,
      "hargaJual": hargaJual,
      "unit": unit,
      "adminAccountEntity": {
        "accountId": int.parse(currentAccountId!),
      },
    });

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        // Berhasil mengupdate data barang
        print("Data barang berhasil diupdate");
      } else {
        print(response.body);
        throw Exception("Gagal mengupdate data barang");
      }
    } catch (e) {
      print(e);
      throw Exception("Gagal terhubung ke server");
    }
  }

  Future<http.Response> deleteBarang(BarangModels barangModels) {
    final url = Uri.parse(
        'http://10.0.2.2:8127/api/v1/barang/delete/${barangModels.idBarang}');

    final deleteById = http.delete(url);
    return deleteById;
  }
}
