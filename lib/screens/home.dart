import 'package:flutter/material.dart';
import 'package:jwt_auth/data/report_config.dart';
import 'package:jwt_auth/screens/add_reports.dart';
import 'package:jwt_auth/screens/login.dart';
import 'package:jwt_auth/screens/update_reports.dart';
import 'package:jwt_auth/services/api_service.dart';
import 'package:jwt_auth/services/auth_service.dart';
import 'package:jwt_auth/theme/colors.dart';
import '../widgets/ticket_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Report> userList = [];
  List<Report> originalList = [];

  @override
  void initState() {
    super.initState();
    _fetchReports();
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

  bool isRefreshing = false;
  Future<void> _fetchReports() async {
    setState(() {
      isRefreshing = true;
    });

    try {
      final users = await ApiService().getReports(context);
      setState(() {
        userList = users;
        originalList = userList;
      });
    } catch (e) {
      print('Error while refreshing data: $e');
    } finally {
      setState(() {
        isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الرئيسية"),
        centerTitle: true,
        leading: PopupMenuButton(
          icon: const Icon(Icons.menu),
          onSelected: (value) {
            if (value == 'logout') {
              searchController.clear();
              AuthService().logout();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'logout',
              child: Text('تسجيل الخروج'),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchReports,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                onChanged: _filterUsers,
                decoration: InputDecoration(
                  hintText: 'البحث عن كل شيء',
                  labelText: 'بحث',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: userList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateReport(user: userList[index]),
                              ),
                            );
                          },
                          child: TicketCard(user: userList[index]),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddReport(),
            ),
          );
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
