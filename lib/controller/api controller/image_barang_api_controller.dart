import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ImageBarangApiController {
  Future<void> saveImage({
    required int barangId,
    required File gambar,
  }) async {
    final url = Uri.parse('http://localhost:8127/api/v1/image/create');
    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['barang'] = barangId.toString();
      var file = await http.MultipartFile.fromPath('file', gambar.path);
      request.files.add(file);

      var response = await request.send();

      if (response.statusCode >= 400 || response.statusCode <= 499) {
        if (kDebugMode) {
          print(response.request);
        }
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
}
