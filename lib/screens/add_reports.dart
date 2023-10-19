import 'package:flutter/material.dart';
import 'package:jwt_auth/data/problem_config.dart';
import 'package:jwt_auth/data/solution_config.dart';
import 'package:jwt_auth/services/api_service.dart';
import 'package:jwt_auth/widgets/text_field.dart';

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
              buildTextField(
                label: 'الأسم',
                hint: 'ادخل اسم العميل',
                value: name,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),

              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  textDirection: TextDirection.rtl,
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

              const SizedBox(height: 16.0),

              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    labelText: 'الهاتف',
                    hintText: 'ادخل رقم الهاتف',
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

              const SizedBox(height: 16.0),

              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    labelText: 'المكان',
                    hintText: ' ادخل مكان العميل',
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

              const SizedBox(height: 16.0),

              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    labelText: 'البرج',
                    hintText: 'ادخل البرج',
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
                  // List<int> checkbox = [];
                  // for (int i = 0; i < solutionCheckboxGroup.length; i++) {
                  //   if (solutionCheckboxGroup[i]) {
                  //     checkbox.add(solutionsCheckbox[i].id);
                  //   }
                  // }
                  ApiService()
                      .addReport(name, account, phone, place, sector);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
