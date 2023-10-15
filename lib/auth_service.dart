import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const apiUrl = 'https://reqres.in/api/login';

  Future<String> login(String email, String password) async {
    //Including the Token in Request Headers:
    //final headers = await AuthService().getHeaders();
    //final response = await http.get(Uri.parse(apiUrl), headers: headers);

    // Make an HTTP POST request to your API to authenticate the user.
    final response = await http.post(Uri.parse(apiUrl), body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      // Successfully logged in, return the JWT token.
      return response.body;
    } else {
      // Handle login failure.
      throw Exception('Failed to log in');
    }
  }

  final storage = const FlutterSecureStorage();

  Future<void> storeToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }

  Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    if (token != null) {
      return {'Authorization': 'Bearer $token'};
    }
    return {};
  }

  Future<void> logout() async {
    // Remove the token when the user logs out.
    await storage.delete(key: 'jwt_token');
  }
}
