import 'package:flutter/material.dart';
import 'package:jwt_auth/data/comment_config.dart';
import 'package:jwt_auth/data/report_config.dart';
import 'package:jwt_auth/services/api_service.dart';
import 'package:jwt_auth/theme/colors.dart';
import 'package:jwt_auth/widgets/text_field.dart';

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
  List<CommentData>? xxx;
  late int? id;

  TextEditingController nameController = TextEditingController();
  TextEditingController accController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    name = nameController.text = widget.user.userName;
    phone = phoneController.text = widget.user.mobile;
    place = placeController.text = widget.user.place!;
    sector = sectorController.text = widget.user.sector!;
    account = accController.text = widget.user.acc!;
    xxx = widget.user.comments;
    id = widget.user.id;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    placeController.dispose();
    sectorController.dispose();
    accController.dispose();
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
              textField('الاسم', 'خالد جمعة', nameController),

              Row(
                children: [
                  Expanded(
                    child: textField('الهاتف', '09XXXXXXXX', phoneController),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: textField('الحساب', 'HTIX00000', accController),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: textField('المكان', 'ش طرابلس', placeController),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: textField('البرج', 'ZXX-SECX', sectorController),
                  ),
                ],
              ),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () async {
                  ApiService()
                      .updateReport(name, account, phone, place, sector, id);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(80, 30)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.primaryColor),
                ),
                child: const Text(
                  'تحديث',
                  style: TextStyle(fontSize: 16),
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  for (var element in xxx!) {
                    print(
                        '${element.comment} created by: ${element.createdBy}');
                  }
                },
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(80, 30)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.primaryColor),
                ),
                child: const Text(
                  'xxx',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
