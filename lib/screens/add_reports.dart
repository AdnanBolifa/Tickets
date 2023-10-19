import 'package:flutter/material.dart';
import 'package:jwt_auth/data/problem_config.dart';
import 'package:jwt_auth/data/solution_config.dart';
import 'package:jwt_auth/services/api_service.dart';
import 'package:jwt_auth/widgets/text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddReport extends StatefulWidget {
  const AddReport({super.key});

  @override
  _AddReportScreenState createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReport> {
  // Declare variables to store user input
  String name = '';
  String account = '';
  String phone = '';
  String place = '';
  String sector = '';

  List<Problem> problemsCheckbox = [];
  List<Solution> solutionsCheckbox = [];

  late List<bool> problemCheckboxGroup;
  late List<bool> solutionCheckboxGroup;

  @override
  void initState() {
    super.initState();

    // Fetch problems and update the state when done.
    ApiService().fetchProblems().then((problems) {
      setState(() {
        problemsCheckbox = problems;
        problemCheckboxGroup =
            List.generate(problemsCheckbox.length, (index) => false);
      });
    });

    // Fetch solutions and update the state when done.
    ApiService().fetchSolutions().then((solutions) {
      setState(() {
        solutionsCheckbox = solutions;
        solutionCheckboxGroup =
            List.generate(solutionsCheckbox.length, (index) => false);
      });
    });
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
              textWidget(
                'الاسم',
                'ادخل الاسم',
                name,
                (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),

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

              const SizedBox(height: 15.0),

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Text(
                    'المشاكل',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              /// Checkboxes - Group Problems
              const SizedBox(height: 15.0),

              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Gray background color
                  border: Border.all(color: Colors.grey), // Border color
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: problemsCheckbox.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        height: 200, // Adjust the height as needed
                        child: ListView.builder(
                          itemCount: problemsCheckbox.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              title: Text(problemsCheckbox[index].name),
                              value: problemCheckboxGroup[index],
                              onChanged: (value) {
                                setState(() {
                                  problemCheckboxGroup[index] = value!;
                                });
                              },
                            );
                          },
                        ),
                      ),
              ),

              // Checkboxes - Group Solutions
              const SizedBox(height: 15.0),

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Text(
                    'الحلول',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 15.0),

              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Gray background color
                  border: Border.all(color: Colors.grey), // Border color
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: solutionsCheckbox.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: solutionsCheckbox.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              title: Text(solutionsCheckbox[index].name),
                              value: solutionCheckboxGroup[index],
                              onChanged: (value) {
                                setState(() {
                                  solutionCheckboxGroup[index] = value!;
                                });
                              },
                            );
                          },
                        ),
                      ),
              ),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  if (name.isNotEmpty) {
                    _submitReport();
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

  void _submitReport() {
    List<int> selectedSolutionIds = solutionCheckboxGroup
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => solutionsCheckbox[entry.key].id)
        .toList();

    List<int> selectedProblemIds = problemCheckboxGroup
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => problemsCheckbox[entry.key].id)
        .toList();

    ApiService().addReport(name, account, phone, place, sector,
        selectedProblemIds, selectedSolutionIds);
    Navigator.pop(context);
  }
}
