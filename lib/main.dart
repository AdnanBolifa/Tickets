import 'package:flutter/material.dart';
import 'package:jwt_auth/screens/login.dart';
import 'package:jwt_auth/services/auth_service.dart';
import 'package:jwt_auth/screens/home.dart';
import 'package:jwt_auth/theme/colors.dart';
import 'package:flutter/services.dart';
import 'package:jwt_auth/theme/theme.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryColor,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  final accesstoken = await AuthService().getAccessToken();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: accesstoken != null ? const HomeScreen() : const LoginPage(),
      theme: customTheme, // Apply the custom theme here
    ),
  );
}
