import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../../logic/exercise/exercise_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';
import '../admin/add_exercise.dart';

class ShowExercise extends StatelessWidget {
  final String day;
  final bool isAdmin;

  final int id;

  const ShowExercise(
      {super.key, required this.id, required this.day, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ExerciseCubit()..getExerciseCubit(userId: id, day: day);
      },
      child: BlocConsumer<ExerciseCubit, ExerciseState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
              ),
              body: state is! LoadingGetExerciseState? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            if (ExerciseCubit.get(context)
                                .exerciseData
                                .isNotEmpty)
                              Expanded(
                                child: Column(
                                  children: [
                                    Image(
                                        image: NetworkImage(
                                            "https://i.pinimg.com/736x/6d/41/a9/6d41a94822d76e4af100c2e5ac80787b.jpg")),
                                    verticalSpace(space: 20),
                                    Expanded(
                                      child: ListView.separated(
                                          itemBuilder: (context, index) =>
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          HexColor("#292929"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              text(
                                                                  text: ExerciseCubit.get(context)
                                                                              .exerciseData
                                                                          [
                                                                          index]
                                                                      ["label"],
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              text(
                                                                  fontColor:
                                                                      Colors
                                                                          .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  text:
                                                                      'Set : ${ExerciseCubit.get(context).exerciseData[index]["Set"]}   .     REPS : ${ExerciseCubit.get(context).exerciseData[index]["reps"]}'),
                                                            ],
                                                          ),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              launchUrlString(ExerciseCubit
                                                                          .get(
                                                                              context)
                                                                      .exerciseData
                                                                  [
                                                                  index]["link"]);
                                                            },
                                                            icon: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.grey,
                                                              child: const Icon(
                                                                FontAwesomeIcons.youtube,
                                                                color: Colors
                                                                    .white,
                                                                size: 24,
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          separatorBuilder: (context, index) =>
                                              verticalSpace(space: 10),
                                          itemCount: ExerciseCubit.get(context)
                                              .exerciseData
                                              .length),
                                    ),
                                  ],
                                ),
                              ),
                            if (ExerciseCubit.get(context).exerciseData.isEmpty)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      image: CachedNetworkImageProvider(
                                          "https://i.pinimg.com/736x/dd/d6/27/ddd62790a7a8be6b4bd4fa4160574eb4.jpg")),
                                  Center(
                                    child: text(
                                        text:
                                            "There is no exercises yet\n Waittttt!!",
                                        fontSize: 25,
                                        fontColor: secondaryColor),
                                  ),
                                ],
                              ),
                            if (isAdmin)
                              defaultButton(context,
                                  label: "Add Exercise",
                                  fontSize: 20, function: () {
                                moveForward(
                                    context: context,
                                    page: AddExercise(
                                      id: id,
                                      day: day,
                                    ));
                              }),
                          ],
                        ),
                      ):Center(child: CircularProgressIndicator()),
            );
          },
          listener: (context, state) {}),
    );
  }
}
