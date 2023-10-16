import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_auth/data/user.dart';

class ApiService {
  static Future<List<User>> getUsers() async {
    const baseUrl = 'https://reqres.in/api/users';
    int page = 1;
    final List<User> users = [];

    while (true) {
      final response = await http.get(Uri.parse('$baseUrl?page=$page'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseMap = jsonDecode(response.body);
        final List<dynamic> data = responseMap['data'];

        if (data.isEmpty) {
          break;
        }

        for (var user in data) {
          users.add(User(
            userName: user['first_name'],
            userEmail: user['email'],
          ));
        }

        page++;
      } else {
        // Handle error
        break;
      }
    }

    return users;
  }
}
