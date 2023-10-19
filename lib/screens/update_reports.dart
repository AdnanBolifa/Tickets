import 'package:flutter/material.dart';
import 'package:jwt_auth/services/api_service.dart';
import 'package:jwt_auth/widgets/text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateReport extends StatefulWidget {
  const UpdateReport({Key? key}) : super(key: key);

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
  TextEditingController nameController = TextEditingController(text: 'عدنان');

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
                    child: textWidget(
                      'الهاتف',
                      'ادخل رقم الهاتف',
                      name,
                      (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: textWidget(
                      'الحساب',
                      'ادخل الحساب',
                      account,
                      (value) {
                        setState(() {
                          account = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: textWidget(
                      'المكان',
                      'ادخل مكان العميل',
                      place,
                      (value) {
                        setState(() {
                          place = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: textWidget(
                      'البرج',
                      'ZXX-SECX...',
                      sector,
                      (value) {
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
                  if (name.isNotEmpty) {
                    ApiService()
                        .updateReport(name, account, phone, place, sector);
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(
                      msg: 'يرجى ادخال الاسم',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                  }
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
