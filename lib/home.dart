import 'package:flutter/material.dart';
import 'package:jwt_auth/auth_service.dart';
import 'package:jwt_auth/main.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Home Screen'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // You can customize the icon if needed
          onPressed: () async {
            await AuthService().logout();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            ); // Example: Navigate back
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home,
                size: 100,
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to My App!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your beautiful Flutter home screen',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add functionality for the button
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
