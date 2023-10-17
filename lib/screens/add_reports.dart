import 'package:flutter/material.dart';
import 'package:jwt_auth/services/api_service.dart';

class AddReport extends StatefulWidget {
  @override
  _AddReportScreenState createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReport> {
  // Declare variables to store user input
  String name = '';
  String account = '';
  String phone = '';
  String place = '';
  String status = '';
  String city = '';
  List<bool> checkboxGroup1 = List.generate(30, (index) => false);
  List<bool> checkboxGroup2 = List.generate(30, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Report'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Text Fields
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  labelStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  contentPadding: const EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              const SizedBox(height: 16.0), // Add spacing
              TextField(
                decoration: InputDecoration(
                  labelText: 'Account',
                  hintText: 'Enter your account',
                  labelStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  contentPadding: const EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    account = value;
                  });
                },
              ),
              const SizedBox(height: 16.0), // Add spacing
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                  hintText: 'Enter your phone number',
                  labelStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  contentPadding: const EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
              ),
              const SizedBox(height: 16.0), // Add spacing
              TextField(
                decoration: InputDecoration(
                  labelText: 'Place',
                  hintText: 'Enter the place',
                  labelStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  contentPadding: const EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    place = value;
                  });
                },
              ),
              const SizedBox(height: 16.0), // Add spacing
              TextField(
                decoration: InputDecoration(
                  labelText: 'Status',
                  hintText: 'Enter the status',
                  labelStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  contentPadding: const EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    status = value;
                  });
                },
              ),
              const SizedBox(height: 16.0), // Add spacing
              TextField(
                decoration: InputDecoration(
                  labelText: 'City',
                  hintText: 'Enter the city',
                  labelStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  contentPadding: const EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    city = value;
                  });
                },
              ),

              const SizedBox(height: 15.0), // Add spacing
              const Text('Checkbox Group 1'),
              const SizedBox(height: 15.0),

              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Gray background color
                  border: Border.all(color: Colors.grey), // Border color
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: Container(
                  height: 200, // Adjust the height as needed
                  child: ListView(
                    children: List.generate(30, (index) {
                      return CheckboxListTile(
                        title: Text('Checkbox ${index + 1}'),
                        value: checkboxGroup1[index],
                        onChanged: (value) {
                          setState(() {
                            checkboxGroup1[index] = value!;
                          });
                        },
                      );
                    }),
                  ),
                ),
              ),

              // Add spacing between the checkbox groups

              // Checkboxes - Group 2
              const SizedBox(height: 15.0), // Add spacing
              const Text('Checkbox Group 2'),
              const SizedBox(height: 15.0),

              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Gray background color
                  border: Border.all(color: Colors.grey), // Border color
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: Container(
                  height: 200, // Adjust the height as needed
                  child: ListView(
                    children: List.generate(30, (index) {
                      return CheckboxListTile(
                        title: Text('Checkbox ${index + 1}'),
                        value: checkboxGroup2[index],
                        onChanged: (value) {
                          setState(() {
                            checkboxGroup2[index] = value!;
                          });
                        },
                      );
                    }),
                  ),
                ),
              ),

              // Add Report Button
              const SizedBox(height: 16.0), // Add spacing
              ElevatedButton(
                onPressed: () {
                  // You can access the input values from the variables (name, account, phone, etc.)
                  ApiService.addReport(name, account, phone, place, status);
                },
                child: const Text('Add Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
