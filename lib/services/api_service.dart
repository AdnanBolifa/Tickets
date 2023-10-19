// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_auth/data/api_config.dart';
import 'package:jwt_auth/data/problem_config.dart';
import 'package:jwt_auth/data/report_config.dart';
import 'package:jwt_auth/data/solution_config.dart';
import 'package:jwt_auth/main.dart';
import 'package:jwt_auth/services/auth_service.dart';

class ApiService {
  Future<void> addReport(String name, acc, phone, place, sector,
      List<int> problems, List<int> solution) async {
    // Create a map to represent the request body
    Map<String, dynamic> requestBody = {
      'name': name,
      'phone': phone,
      'account': acc,
      'place': place,
      'sector': sector,
      'note': 'xzxxxx',
      'problem': problems,
      'solutions': solution,
    };

    final accessToken = await AuthService().getAccessToken();

    final response = await http.post(Uri.parse(APIConfig.addUrl),
        body: jsonEncode(requestBody),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 201) {
      print("Report added successfully");
    } else {
      throw Exception('Failed to add report: ${response.statusCode}');
    }
  }

  Future<void> updateReport(String name, acc, phone, place, sector) async {
    // Create a map to represent the request body
    Map<String, dynamic> requestBody = {
      'name': name,
      'phone': phone,
      'account': acc,
      'place': place,
      'sector': sector,
      'note': 'xzxxxx',
    };

    final accessToken = await AuthService().getAccessToken();

    final response = await http.put(Uri.parse(APIConfig.updateUrl),
        body: jsonEncode(requestBody),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      print("Report added successfully");
    } else {
      throw Exception('Failed to add report: ${response.statusCode}');
    }
  }

  Future<List<Report>> getReports(context) async {
    final List<Report> users = [];
    final authService = AuthService();

    Future<http.Response> retryApiRequest() async {
      final accessToken = await authService.getAccessToken();
      final response =
          await http.get(Uri.parse(APIConfig.reportsUrl), headers: {
        'Authorization': 'Bearer $accessToken',
      });

      if (response.statusCode == 401) {
        // If the response is 401, attempt to get a new access token and retry.
        await authService.getNewAccessToken();
        return retryApiRequest();
      } else if (response.statusCode != 200) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginApp(),
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
          users.add(Report(
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
    }

    return users;
  }

  Future<List<Problem>> fetchProblems() async {
    List<Problem> problems = [];
    final response = await http.get(Uri.parse(APIConfig.problemsUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseMap =
          jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> results = responseMap['results'];

      for (var item in results) {
        problems.add(Problem.fromJson(item));
      }

      return problems;
    } else {
      throw Exception('Failed to fetch item names');
    }
  }

  Future<List<Solution>> fetchSolutions() async {
    List<Solution> solutions = [];
    final response = await http.get(Uri.parse(APIConfig.solutionsUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseMap =
          jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> results = responseMap['results'];

      for (var item in results) {
        solutions.add(Solution.fromJson(item));
      }

      return solutions;
    } else {
      throw Exception('Failed to fetch item names');
    }
  }

  Future<List<String>> getItemNames() async {
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
}
