import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_auth/data/user.dart';
import 'package:jwt_auth/main.dart';
import 'package:jwt_auth/services/auth_service.dart';

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
            mobile: user['email'],
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

  static Future<void> addReport(String name, acc, phone, place, status) async {
    final url = Uri.parse('http://165.16.36.4:8877/api/ticket/add');
    final accessToken = await AuthService().getAccessToken();

    final response = await http.post(url, body: {
      'name': name,
      'phone': phone,
      'account': acc,
      'place': place,
      'sector': status,
    }, headers: {
      'Authorization': 'Bearer $accessToken'
    });

    if (response.statusCode == 201) {
      print("Added successfully");
    } else {
      // Handle the error case appropriately
      throw Exception('Failed to create user');
    }
  }

  static Future<List<String>> getItemNames() async {
    const baseUrl = 'http://10.255.255.15/api/ticket/problems/list';

    final List<String> itemNames = [];

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseMap =
          jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> results = responseMap['results'];

      for (var item in results) {
        itemNames.add(item['name']);
      }

      return itemNames;
    } else {
      // Handle error
      throw Exception('Failed to fetch item names');
    }
  }

  Future<List<User>> getReports(context) async {
    const baseUrl = 'http://165.16.36.4:8877/api/ticket/list';
    final List<User> users = [];
    final authService = AuthService(); // Create an instance of the AuthService

    Future<http.Response> retryApiRequest() async {
      final accessToken = await authService.getAccessToken();
      final response = await http.get(Uri.parse(baseUrl), headers: {
        'Authorization': 'Bearer $accessToken',
      });

      if (response.statusCode == 401) {
        // If the response is 401, attempt to get a new access token and retry.
        await authService.getNewAccessToken();
        return retryApiRequest();
      } else if (response.statusCode != 200) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginApp(),
          ),
        );
        authService.logout();
      }

      return response;
    }

    final response = await retryApiRequest();

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> responseMap =
            jsonDecode(utf8.decode(response.bodyBytes));
        final List<dynamic> data = responseMap['results'];

        for (var user in data) {
          final userName = user['name'] as String;
          final mobile = user['phone'] as String;
          users.add(User(
            userName: userName,
            mobile: mobile,
          ));
        }
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    } else {
      print('Request failed with status code: ${response.statusCode}');
      print('Response content: ${response.body}');
      // Handle error
    }

    return users;
  }
}
