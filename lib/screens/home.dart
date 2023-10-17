import 'package:flutter/material.dart';
import 'package:jwt_auth/data/user.dart';
import 'package:jwt_auth/main.dart';
import 'package:jwt_auth/screens/add_reports.dart';
import 'package:jwt_auth/services/api_service.dart';
import 'package:jwt_auth/services/auth_service.dart';
import 'user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  List<User> userList = [];
  List<User> originalList = [];

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  void _fetchReports() async {
    final users = await ApiService().getReports(context);
    setState(() {
      userList = users;
      originalList = userList;
    });
  }

  void _filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        userList = List.from(originalList);
      } else {
        userList = userList.where((user) {
          return user.userName.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _showUserDetails(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'User Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Name: ${user.userName}'),
                Text('Phone: ${user.mobile}'),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  void _addUserDetails() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter User Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: jobController,
                  decoration: const InputDecoration(
                    labelText: 'Job',
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    ApiService.createUser(
                        nameController.text, jobController.text);
                    nameController.clear(); // Clear the name field
                    jobController.clear(); // Clear the job field
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => searchController.clear(),
            icon: const Icon(Icons.menu),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AuthService().logout();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LoginApp(),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterUsers,
              decoration: InputDecoration(
                labelText: 'Search Users',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: userList.isEmpty
                ? const Center(
                    child:
                        CircularProgressIndicator(), // Show a loading indicator
                  )
                : ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _showUserDetails(userList[index]);
                        },
                        child: UserCard(user: userList[index]),
                      );
                    },
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddReport(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
