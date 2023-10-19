import 'package:flutter/material.dart';
import 'package:jwt_auth/data/report_config.dart';
import 'package:jwt_auth/services/api_service.dart';

class UpdateReport extends StatefulWidget {
  final Report user;

  const UpdateReport({Key? key, required this.user}) : super(key: key);

  @override
  _UpdateReportScreenState createState() => _UpdateReportScreenState();
}

class _UpdateReportScreenState extends State<UpdateReport> {
  // Declare variables to store user input
  String name = '';
  String account = '';
  String phone = '';
  String place = '';
  String sector = '';
  late int? id;

  TextEditingController nameController = TextEditingController();
  TextEditingController accController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the value from the 'user' object
    name = nameController.text = widget.user.userName;
    phone = phoneController.text = widget.user.mobile;
    place = placeController.text = widget.user.place!;
    sector = sectorController.text = widget.user.sector!;
    account = accController.text = widget.user.acc!;
    id = widget.user.id;
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed to avoid memory leaks.
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إضافة بلاغ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Text Fields
              TextField(
                controller: nameController,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  labelText: 'الاسم',
                  hintText: 'ادخل اسم العميل',
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
              const SizedBox(height: 16.0),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        labelText: 'الهاتف',
                        hintText: 'ادخل هاتف العميل',
                        labelStyle:
                            const TextStyle(fontSize: 16, color: Colors.blue),
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
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
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: accController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        labelText: 'الحساب',
                        hintText: 'ادخل الحساب',
                        labelStyle:
                            const TextStyle(fontSize: 16, color: Colors.blue),
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
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
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: placeController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        labelText: 'المكان',
                        hintText: 'ش. طرابلس',
                        labelStyle:
                            const TextStyle(fontSize: 16, color: Colors.blue),
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
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
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: sectorController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        labelText: 'البرج',
                        hintText: 'ZXX-SECX...',
                        labelStyle:
                            const TextStyle(fontSize: 16, color: Colors.blue),
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
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
                          sector = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  ApiService()
                      .updateReport(name, account, phone, place, sector, id);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                child: const Text(
                  'إرسال',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
