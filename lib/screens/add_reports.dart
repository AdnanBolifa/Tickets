import 'package:flutter/material.dart';
import 'package:jwt_auth/data/location_data.dart';
import 'package:jwt_auth/data/problem_config.dart';
import 'package:jwt_auth/data/solution_config.dart';
import 'package:jwt_auth/services/api_service.dart';
import 'package:jwt_auth/services/location_services.dart';
import 'package:jwt_auth/widgets/text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddReport extends StatefulWidget {
  const AddReport({Key? key}) : super(key: key);

  @override
  _AddReportScreenState createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReport> {
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

  TextEditingController location = TextEditingController();
  final LocationService locationService = LocationService();
  LocationData? locationData;

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
              textReports(
                'الاسم',
                'خالد جمعة',
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
                    child: textReports(
                      'الهاتف',
                      '091XXXXXXX',
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
                    child: textReports(
                      'الحساب',
                      'HTIX00000',
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
                    child: textReports(
                      'المكان',
                      'ش طرابلس',
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
                    child: textReports(
                      'البرج',
                      'س',
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
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        locationData = await locationService.getUserLocation();
                        location.text =
                            '${locationData!.latitude}, ${locationData!.longitude}';
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(60, 80),
                          backgroundColor: Colors.grey[300]),
                      child: const Center(
                        // Center the text
                        child: Text(
                          "جلب احداثيات الموقع",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        controller: location,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'احداثيات الموقع',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          hintText: '35.2345, 89.01234',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15.0),

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
