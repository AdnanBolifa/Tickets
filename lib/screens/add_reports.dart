import 'package:flutter/material.dart';
import 'package:jwt_auth/data/location_config.dart';
import 'package:jwt_auth/data/problem_config.dart';
import 'package:jwt_auth/data/solution_config.dart';
import 'package:jwt_auth/services/api_service.dart';
import 'package:jwt_auth/services/location_services.dart';
import 'package:jwt_auth/theme/colors.dart';
import 'package:jwt_auth/widgets/text_field.dart';

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

  List<String> textTrueProblem = [];
  List<String> textTrueSolution = [];

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
              const SizedBox(height: 15),

              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 100, // Set the default minimum height to 100
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'المشاكل',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: textTrueProblem.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                dense: true,
                                leading: Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.fiber_manual_record,
                                    size: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                title: Text(
                                  textTrueProblem[index],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _showBottomSheetProblem(context);
                              },
                              icon: const Icon(Icons.edit, color: Colors.black),
                              iconSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Checkboxes - Group Solutions
              const SizedBox(height: 15.0),

              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 100, // Set the default minimum height to 100
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'الحلول',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: textTrueSolution.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                dense: true,
                                leading: Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.fiber_manual_record,
                                    size: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                title: Text(
                                  textTrueSolution[index],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _showBottomSheetSolution(context);
                              },
                              icon: const Icon(Icons.edit, color: Colors.black),
                              iconSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
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
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
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
                          hintText: 'xx.xxxx, xx.xxxx',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () async {
                  _submitReport();
                },
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(100, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.primaryColor),
                ),
                child: const Text(
                  'إضافة',
                  style: TextStyle(fontSize: 16),
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

  void _updateSelectedProblems() {
    textTrueProblem.clear();
    for (int index = 0; index < problemsCheckbox.length; index++) {
      if (problemCheckboxGroup[index]) {
        textTrueProblem.add(problemsCheckbox[index].name);
      }
    }
  }

  void _updateSelectedSolution() {
    textTrueSolution.clear();
    for (int index = 0; index < solutionsCheckbox.length; index++) {
      if (solutionCheckboxGroup[index]) {
        textTrueSolution.add(solutionsCheckbox[index].name);
      }
    }
  }

  void _showBottomSheetProblem(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return ListView.builder(
              itemCount: problemsCheckbox.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          problemsCheckbox[index].name,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  value: problemCheckboxGroup[index],
                  onChanged: (value) {
                    setState(() {
                      problemCheckboxGroup[index] = value!;
                    });
                  },
                );
              },
            );
          },
        );
      },
    ).then((result) {
      _updateSelectedProblems();
      setState(() {});
    });
  }

  void _showBottomSheetSolution(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return ListView.builder(
              itemCount: solutionsCheckbox.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          solutionsCheckbox[index].name,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  value: solutionCheckboxGroup[index],
                  onChanged: (value) {
                    setState(() {
                      solutionCheckboxGroup[index] = value!;
                    });
                  },
                );
              },
            );
          },
        );
      },
    ).then((result) {
      _updateSelectedSolution();
      setState(() {});
    });
  }
}
