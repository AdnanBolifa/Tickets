import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const apiLogin = 'http://10.255.255.15/api/vip/login';
  static const apiRefresh = 'http://165.16.36.4:8015/api/vip/refresh';

  Future<String> login(String email, String password) async {
    // Make an HTTP POST request to your API to authenticate the user.
    final response = await http.post(Uri.parse(apiLogin), body: {
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

  Future<void> storeTokens(String apiResponse) async {
    final Map<String, dynamic> tokens = jsonDecode(apiResponse);
    final String? refreshToken = tokens['refresh'];
    final String? accessToken = tokens['access'];

    if (refreshToken != null) {
      await storage.write(key: 'refresh_token', value: refreshToken);
    }

    if (accessToken != null) {
      await storage.write(key: 'access_token', value: accessToken);
    }
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'refresh_token');
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<void> getNewAccessToken() async {
    final response = await http.post(Uri.parse(apiRefresh), body: {
      'refresh': await getRefreshToken(),
    });

    if (response.statusCode == 200) {
      storeTokens(response.body);
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<void> logout() async {
    // Remove both the access and refresh tokens when the user logs out.
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }
}
