import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toserba/models/barang_models.dart';

class BarangController {
  List<BarangModels> barangModels = [];

  Future<http.Response> getAllBarang() async {
    final url = Uri.parse("http://10.0.2.2:8127/api/v1/barang/get-all");

    final response = await http.get(url);
    return response;
  }

  Future<List<BarangModels>> loadBarang() async {
    final response = await getAllBarang();
    final jsonData = json.decode(response.body);

    List<BarangModels> barangModels = [];

    for (var allData in jsonData) {
      final idBarang = allData['idBarang'];
      final namaBarang = allData['namaBarang'];
      final kodeBarang = allData['kodeBarang'];
      final hargaBarang = allData['hargaBarang'];
      final stokBarang = allData['stokBarang'];

      final barang = BarangModels(
          idBarang: idBarang,
          namaBarang: namaBarang,
          kodeBarang: kodeBarang,
          hargaBarang: hargaBarang,
          stokBarang: stokBarang);

      barangModels.add(barang);
    }
    print(jsonData);
    return barangModels;
  }

  Future<void> saveBarang(
      {required String namaBarang,
      required int hargaBarang,
      required String kodeBarang,
      required int stokBarang}) async {
    final url = Uri.parse("http://10.0.2.2:8127/api/v1/barang/create");

    final body = json.encode({
      "namaBarang": namaBarang,
      "hargaBarang": hargaBarang,
      "kodeBarang": kodeBarang,
      "stokBarang": stokBarang,
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

  Future<http.Response> getId(int id) async{
    final url = Uri.parse('http://10.0.2.2:8127/api/v1/barang/get/$id');
    final response = await http.get(url);
    return response;
  }
}
