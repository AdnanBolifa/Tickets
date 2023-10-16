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

  static Future<void> createUser(String name, String job) async {
    final url = Uri.parse('https://reqres.in/api/users');

    final response = await http.post(
      url,
      body: {'name': name, 'job': job}, // Fix the syntax error here
    );

    if (response.statusCode == 201) {
      // User creation successful
      // You can handle the response or return any necessary data here
      print(response.body);
    } else {
      // Handle the error case appropriately
      throw Exception('Failed to create user');
    }
  }
}
