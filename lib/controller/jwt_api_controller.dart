import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class JwtApiController {
  late Stream token;

  Future<http.Response> getTokenJwt() async {
    var url = Uri.parse('http://10.0.2.2:8127/api/v1/jwt/admin-jwt');
    final response = await http.get(url);
    const storage = FlutterSecureStorage();

    await storage.write(key: 'token', value: response.body);
    var token = await storage.read(key: 'token');
    print("ini token $token");
    return response;
  }

    Future<http.Response> getUserTokenJwt() async {
    var url = Uri.parse('http://10.0.2.2:8127/api/v1/jwt/user-jwt');
    final response = await http.get(url);
    const storage = FlutterSecureStorage();

    await storage.write(key: 'user-token', value: response.body);
    var token = await storage.read(key: 'user-token');
    print("ini token $token");
    return response;
  }
}
