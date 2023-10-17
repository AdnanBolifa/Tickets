import 'package:flutter/material.dart';
import 'package:jwt_auth/screens/login.dart';
import 'package:jwt_auth/services/auth_service.dart';
import 'package:jwt_auth/screens/home.dart';

void main() async {
  // Ensure that the WidgetsBinding is initialized before checking for a token.
  WidgetsFlutterBinding.ensureInitialized();

  final accesstoken = await AuthService().getAccessToken();
  print("start up $accesstoken");
  runApp(
    MaterialApp(
      home: accesstoken != null ? const HomeScreen() : const LoginPage(),
    ),
  );
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
