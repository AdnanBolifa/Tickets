import 'package:flutter/material.dart';
import 'package:jwt_auth/screens/home.dart';
import 'package:jwt_auth/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final email = emailController.text;
                  final password = passwordController.text;

                  try {
                    // ignore: unused_local_variable
                    final token = await AuthService().login(email, password);
                    await AuthService().storeToken(token);
                    print('Login successed $token');

                    // Handle successful login, e.g., store the token and navigate to another screen.
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  } catch (e) {
                    // Handle login failure, e.g., show an error message.
                    print('Login failed: $e');
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
