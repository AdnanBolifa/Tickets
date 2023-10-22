import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_auth/data/api_config.dart';
import 'package:jwt_auth/data/comment_config.dart';
import 'package:jwt_auth/data/problem_config.dart';
import 'package:jwt_auth/data/report_config.dart';
import 'package:jwt_auth/data/solution_config.dart';
import 'package:jwt_auth/screens/login.dart';
import 'package:jwt_auth/services/auth_service.dart';

class ApiService {
  Future<void> addReport(String name, acc, phone, place, sector, List<int> problems, List<int> solution) async {
    final requestBody = {
      'name': name,
      'phone': phone,
      'account': acc,
      'place': place,
      'sector': sector,
      'note': 'xzxxxx',
      'problem': problems,
      'solutions': solution,
    };

    await _performPostRequest(APIConfig.addUrl, requestBody);
  }

  Future<void> updateReport(String name, acc, phone, place, sector, int? id) async {
    final requestBody = {
      'name': name,
      'phone': phone,
      'account': acc,
      'place': place,
      'sector': sector,
    };

    await _performPutRequest('${APIConfig.updateUrl}$id/edit', requestBody);
  }

  Future<List<Report>> getReports(context) async {
    final authService = AuthService();

    final response = await _performAuthenticatedGetRequest(APIConfig.reportsUrl, authService, context);

    if (response.statusCode == 200) {
      try {
        final responseMap = jsonDecode(utf8.decode(response.bodyBytes));
        final List<dynamic> data = responseMap['results'];

        final users = data.map((user) => Report.fromJson(user)).toList();
        return users;
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    } else {
      print('Request failed with status code: ${response.statusCode}');
      print('Response content: ${response.body}');
    }

    return [];
  }

  Future<List<Problem>> fetchProblems() async {
    final response = await _performGetRequest(APIConfig.problemsUrl);
    return _parseProblemsResponse(response);
  }

  Future<List<CommentData>> fetchComments() async {
    final authService = AuthService();
    final response = await _performAuthenticatedGetRequest(APIConfig.reportsUrl, authService);
    return _parseCommentsResponse(response);
  }

  Future<List<Solution>> fetchSolutions() async {
    final response = await _performGetRequest(APIConfig.solutionsUrl);
    return _parseSolutionsResponse(response);
  }


  //helper functions
  Future<http.Response> _performGetRequest(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  
  Future<void> _performPostRequest(String url, dynamic body) async {
    final accessToken = await AuthService().getAccessToken();
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      print("Data added successfully");
    } else {
      throw Exception('Failed to add data: ${response.statusCode}');
    }
  }

  Future<void> _performPutRequest(String url, dynamic body) async {
    final accessToken = await AuthService().getAccessToken();
    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print("Data updated successfully");
    } else {
      throw Exception('Failed to update data: ${response.statusCode}');
    }
  }

  Future<http.Response> _performAuthenticatedGetRequest(String url, AuthService authService, [BuildContext? context]) async {
    final accessToken = await authService.getAccessToken();
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 401) {
      await authService.getNewAccessToken();
      return _performAuthenticatedGetRequest(url, authService, context);
    } else if (response.statusCode != 200 && context != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ));
      authService.logout();
    }

    return response;
  }

  List<Problem> _parseProblemsResponse(http.Response response) {
    if (response.statusCode == 200) {
      final responseMap = jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> results = responseMap['results'];

      final problems = results.map((item) => Problem.fromJson(item)).toList();
      return problems;
    } else {
      throw Exception('Failed to fetch problems');
    }
  }

  List<CommentData> _parseCommentsResponse(http.Response response) {
    if (response.statusCode == 200) {
      final responseMap = jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> results = responseMap['results'];

      final comments = results.map((item) => CommentData.fromJson(item)).toList();
      return comments;
    } else {
      throw Exception('Failed to fetch comments');
    }
  }

  List<Solution> _parseSolutionsResponse(http.Response response) {
    if (response.statusCode == 200) {
      final responseMap = jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> results = responseMap['results'];

      final solutions = results.map((item) => Solution.fromJson(item)).toList();
      return solutions;
    } else {
      throw Exception('Failed to fetch solutions');
    }
  }
}
