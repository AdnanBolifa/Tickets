import 'package:flutter/material.dart';
import 'package:jwt_auth/data/comment_config.dart';
import 'package:jwt_auth/data/report_config.dart';
import 'package:jwt_auth/services/api_service.dart';
import 'package:jwt_auth/theme/colors.dart';
import 'package:jwt_auth/widgets/comment_card.dart';
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
  List<CommentData>? comments;
  late int? id;

  TextEditingController nameController = TextEditingController();
  TextEditingController accController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    name = nameController.text = widget.user.userName;
    phone = phoneController.text = widget.user.mobile;
    place = placeController.text = widget.user.place!;
    sector = sectorController.text = widget.user.sector!;
    account = accController.text = widget.user.acc!;
    comments = widget.user.comments;
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
        actions: [
          Container(
            margin: const EdgeInsets.all(8.0), // Margin for spacing
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ElevatedButton(
              onPressed: () {
                ApiService()
                    .updateReport(name, account, phone, place, sector, id);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                'حفظ',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
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
                    child: textField(
                        'الهاتف', '09commentscommentsXX', phoneController),
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

              SizedBox(
                height: 400,
                child: comments!.isEmpty
                    ? const Center(
                        child: Text(
                        'لايوجد تعليقات',
                        style: TextStyle(fontSize: 16),
                      ))
                    : ListView.builder(
                        itemCount: comments!.length,
                        itemBuilder: (context, index) {
                          return CommentCard(comment: comments![index]);
                        },
                      ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {},
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(50, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.primaryColor),
                    ),
                    child: const Text(
                      'اضافة تعليق',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: textField('تعليق', 'اضف تعليق', commentController),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
