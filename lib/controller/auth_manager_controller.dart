import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthManagerController {
  void validatingToken({
    required FlutterSecureStorage storage,
  }) async {
    final token = await storage.read(key: 'token');

    if (token != null) {
      if (JwtDecoder.isExpired(token)) {
        storage.deleteAll();
      }
    }
  }
}
