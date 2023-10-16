import 'package:flutter/material.dart';
import 'package:jwt_auth/screens/login.dart';
import 'package:jwt_auth/services/auth_service.dart';
import 'package:jwt_auth/screens/home.dart';

void main() async {
  // Ensure that the WidgetsBinding is initialized before checking for a token.
  WidgetsFlutterBinding.ensureInitialized();

  final token = await AuthService().getToken();
  print("start up $token");
  runApp(
    MaterialApp(
      home: token != null ? HomeScreen() : const LoginPage(),
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
