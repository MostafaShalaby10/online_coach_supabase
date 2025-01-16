import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_coach_supabase/views/user/personal_data/food_data.dart';

import '../../../shared/components/components.dart';
import '../../../shared/constants/constants.dart';

class GymHistory extends StatefulWidget {

  const GymHistory({super.key});

  @override
  State<GymHistory> createState() => _GymHistoryState();
}

class _GymHistoryState extends State<GymHistory> {
  bool less3 = true;

  bool between = false;

  bool more5 = false;

  TextEditingController goalController = TextEditingController();
  TextEditingController periodController = TextEditingController();
  TextEditingController workingController = TextEditingController();
  String weekly = "less 3";

  String? _gymHistory;

  String? _working;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                spacing: 10.h,
                children: [
                  textField(
                      type: TextInputType.text,
                      label: "What is your goal",
                      prefixIcon: Icons.person,
                      controller: goalController),
                  text(text: "Did you go th the gym before  ?"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Radio<String>(
                            value: 'yes',
                            groupValue: _gymHistory,
                            onChanged: (value) {
                              setState(() {
                                _gymHistory = value!;
                              });
                            },
                            activeColor: secondaryColor,
                          ),
                          horizontalTitleGap: 0,
                          title: const Text('Yes',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: Radio<String>(
                            value: 'No',
                            groupValue: _gymHistory,
                            onChanged: (value) {
                              setState(() {
                                _gymHistory = value!;
                              });
                            },
                            activeColor: secondaryColor,
                          ),
                          horizontalTitleGap: 0,
                          title: const Text('No',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  if (_gymHistory == "yes")
                    textField(
                        type: TextInputType.text,
                        label: "How long are you training",
                        prefixIcon: Icons.sports_gymnastics_rounded,
                        controller: periodController),
                  text(text: "Are you working ?"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Radio<String>(
                            value: 'yes',
                            groupValue: _working,
                            onChanged: (value) {
                              setState(() {
                                _working = value!;
                              });
                            },
                            activeColor: secondaryColor,
                          ),
                          horizontalTitleGap: 0,
                          title: const Text('Yes',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: Radio<String>(
                            value: 'No',
                            groupValue: _working,
                            onChanged: (value) {
                              setState(() {
                                _working = value!;
                              });
                            },
                            activeColor: secondaryColor,
                          ),
                          horizontalTitleGap: 0,
                          title: const Text('No',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  if (_working == "yes")
                    textField(
                        type: TextInputType.text,
                        label: "What's your job",
                        prefixIcon: Icons.work_outline,
                        controller: workingController),
                  text(text: "How many times can you go to the gym weekly"),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              weekly = "less 3";
                              less3 = true;
                              between = false;
                              more5 = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  less3 ? Colors.grey[500] : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: text(text: "<3"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              weekly = "between 3-5";
                              between = true;
                              less3 = false;
                              more5 = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: between
                                  ? Colors.grey[500]
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: text(text: "3-5"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              weekly = "more5";
                              more5 = true;
                              less3 = false;
                              between = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  more5 ? Colors.grey[500] : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: text(text: ">5"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(space: 10),
                  defaultButton(context, label: "Next", fontSize: 20,
                      function: () {
                    if (formKey.currentState!.validate()) {
                      if (_working != null && _gymHistory != null) {
                        setPersonalData.addAll({
                          "goal": goalController.text,
                          "period": periodController.text,
                          "working": workingController.text,
                          "weekly": weekly,
                          "gymhistory": _gymHistory,
                          "isworking": _working,
                        });
                        moveForward(context: context, page: FoodData());
                      } else {
                        _working == null
                            ? toastMSG(
                                text: "Please enter working", color: Colors.red)
                            : toastMSG(
                                text: "Please enter gym history",
                                color: Colors.red);
                      }
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
