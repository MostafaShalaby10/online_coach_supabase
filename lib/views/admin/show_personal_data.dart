import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_coach_supabase/logic/user_personal_data/user_personal_data_cubit.dart';
import 'package:online_coach_supabase/views/admin/admin_home_page.dart';

import '../../shared/components/components.dart';
import '../shared/days.dart';
import '../shared/show_supplements.dart';

class ShowPersonalData extends StatelessWidget {
  final int userId;

  const ShowPersonalData({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserPersonalDataCubit()..getPersonalData(id: userId),
      child: BlocConsumer<UserPersonalDataCubit, UserPersonalDataState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: state is! LoadingGetPersonalDataState?Column(
                    spacing: 10.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserPersonalDataCubit.get(context)
                              .allPersonalData
                              .isNotEmpty
                          ? Column(
                        spacing: 10.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (await confirm(
                                      context,
                                      title: text(text: "Warning" , fontColor: Colors.red),
                                      canPop: true,
                                      content: text(
                                        text: "Are you sure to delete clinic",
                                        fontColor: Colors.black
                                      ),
                                    )) {
                                      UserPersonalDataCubit.get(context)
                                          .clearPersonalData(
                                              id: UserPersonalDataCubit.get(
                                                          context)
                                                      .allPersonalData[0]
                                                  ["user_id"]);
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      text(text: "Clear data"),
                                      Icon(Icons.delete_forever_outlined , color: Colors.red,),
                                    ],
                                  ),
                                ),
                                text(text: "Weight"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["weight"]
                                            .toString(),
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Tall"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["height"]
                                            .toString(),
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Goal"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["goal"],
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Gender"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["gender"],
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Gym History"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["gymhistory"],
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Age"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["age"]
                                            .toString(),
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "History of gym"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                                        .allPersonalData[0]
                                                    ["period"] ==
                                                ""
                                            ? "No History"
                                            : UserPersonalDataCubit.get(context)
                                                .allPersonalData[0]["period"],
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Times per week"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["weekly"],
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Training time"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["trainingtime"],
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Meal Number"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["mealnumber"]
                                            .toString(),
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "First Meal time"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                                .allPersonalData[0]
                                            ["firstmealtime"],
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Forbidden Food"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                                .allPersonalData[0]
                                            ["forbiddenfood"],
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Breakfast FAV Food"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["favbreakfast"]
                                            .toString(),
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Lunch FAV Food"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["favlunch"]
                                            .toString(),
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Fruit FAV Food"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["favfruit"]
                                            .toString(),
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Vegetables FAV Food"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["favvegetables"]
                                            .toString(),
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                text(text: "Snacks FAV Food"),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20),
                                    child: text(
                                        fontColor: Colors.black,
                                        text: UserPersonalDataCubit.get(context)
                                            .allPersonalData[0]["favsnacks"]
                                            .toString(),
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                              ],
                            )
                          : text(
                              text: "There is no data for this user",
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                      verticalSpace(space: 20),
                      defaultButton(context, label: "Exercise", fontSize: 20,
                          function: () {
                        moveForward(
                          context: context,
                          page: Days(
                            isExercise: true,
                            uid: userId,
                            isAdmin: true,
                          ),
                        );
                      }),
                      defaultButton(context, label: "Food", fontSize: 20,
                          function: () {
                        moveForward(
                          context: context,
                          page: Days(
                            isExercise: false,
                            uid: userId,
                            isAdmin: true,
                          ),
                        );
                      }),
                      defaultButton(context, label: "Supplements", fontSize: 20,
                          function: () {
                        moveForward(
                            context: context,
                            page: ShowSupplements(
                              id: userId,
                              isAdmin: true,
                            ));
                      }),
                    ],
                  ):Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is SuccessfullyClearPersonalDataState) {
              moveForwardAndRemove(context: context, page: AdminHomePage());
            }
          }),
    );
  }
}
