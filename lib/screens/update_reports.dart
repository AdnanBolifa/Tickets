import 'package:flutter/material.dart';
import 'package:jwt_auth/data/comment_config.dart';
import 'package:jwt_auth/data/problem_config.dart';
import 'package:jwt_auth/data/report_config.dart';
import 'package:jwt_auth/data/solution_config.dart';
import 'package:jwt_auth/screens/home.dart';
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
  late int id;

  TextEditingController nameController = TextEditingController();
  TextEditingController accController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  List<Problem> problemsCheckbox = [];
  List<Solution> solutionsCheckbox = [];
  List<String> textTrueProblem = [];
  List<String> textTrueSolution = [];
  late List<bool> problemCheckboxGroup;
  late List<bool> solutionCheckboxGroup;

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

    ApiService().fetchProblems().then((problems) {
      setState(() {
        problemsCheckbox = problems;
        problemCheckboxGroup =
            List.generate(problemsCheckbox.length, (index) => false);

        for (var item in widget.user.problems!) {
          for (var i = 0; i < problemsCheckbox.length; i++) {
            if (item == problemsCheckbox[i].id) {
              textTrueProblem.add(problemsCheckbox[i].name);
              problemCheckboxGroup[i] = true;
            }
          }
        }
      });
    });

    // Fetch solutions and update the state when done.
    ApiService().fetchSolutions().then((solutions) {
      setState(() {
        solutionsCheckbox = solutions;
        solutionCheckboxGroup =
            List.generate(solutionsCheckbox.length, (index) => false);

        for (var item in widget.user.solutions!) {
          for (var i = 0; i < solutionsCheckbox.length; i++) {
            if (item == solutionsCheckbox[i].id) {
              textTrueSolution.add(solutionsCheckbox[i].name);
              solutionCheckboxGroup[i] = true;
            }
          }
        }
      });
    });
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
                _submitReport();
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
          'تعديل بلاغ',
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

              ConstrainedBox(
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

              const SizedBox(height: 16.0),

              ConstrainedBox(
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
              //Card size Box
              const SizedBox(height: 16.0),

              SizedBox(
                child: Column(children: [
                  if (comments!.isEmpty)
                    const Center(
                      child: Text(
                        'لا يوجد تعليقات',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  else
                    for (var comment in comments!)
                      CommentCard(comment: comment),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          ApiService().updateReport(
                              comment: commentController.text, id: id);

                          setState(() {
                            comments?.add(CommentData(
                                ticket: 0,
                                comment: commentController.text,
                                createdAt: 'الأن',
                                createdBy: 'انت'));
                          });
                          commentController.clear();
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(50, 50)),
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
                        child:
                            textField('تعليق', 'اضف تعليق', commentController),
                      ),
                    ],
                  ),
                ]),
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

    ApiService().updateReport(
        name: nameController.text,
        acc: accController.text,
        phone: phoneController.text,
        place: placeController.text,
        sector: sectorController.text,
        id: id,
        problems: selectedProblemIds,
        solution: selectedSolutionIds);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    }));
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
