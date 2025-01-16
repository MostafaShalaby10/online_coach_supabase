import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../logic/meal/meal_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';
import '../admin/add_food.dart';

class ShowFood extends StatefulWidget {
  final String day;
  final bool isAdmin;

  final int id;

  const ShowFood(
      {super.key, required this.day, required this.id, required this.isAdmin});

  @override
  State<ShowFood> createState() => _ShowFoodState();
}

bool breakfastFlag = true;
bool lunchFlag = false;
bool dinnerFlag = false;

class _ShowFoodState extends State<ShowFood> {
  bool breakfastFlag = true;
  bool lunchFlag = false;
  bool dinnerFlag = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MealCubit()..getFoodCubit(userId: widget.id, day: widget.day),
      child: BlocConsumer<MealCubit, MealState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              color: breakfastFlag
                                  ? HexColor("#CDFB47")
                                  : Colors.grey[700],
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      breakfastFlag = true;
                                      lunchFlag = false;
                                      dinnerFlag = false;
                                      // FoodCubit.get(context).getFoodCubit(userId: widget.id, day: widget.day, type: "breakfast");
                                    });
                                  },
                                  child: text(
                                      text: "Breakfast",
                                      fontColor: breakfastFlag
                                          ? Colors.black
                                          : Colors.white))),
                        ),
                        horizontalSpace(space: 5),
                        Expanded(
                          child: Container(
                              color: lunchFlag
                                  ? HexColor("#CDFB47")
                                  : Colors.grey[700],
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      lunchFlag = true;

                                      breakfastFlag = false;

                                      dinnerFlag = false;
                                      // FoodCubit.get(context).getFoodCubit(userId: widget.id, day: widget.day, type: "lunch");
                                    });
                                  },
                                  child: text(
                                      text: "Lunch",
                                      fontColor: lunchFlag
                                          ? Colors.black
                                          : Colors.white))),
                        ),
                        horizontalSpace(space: 5),
                        Expanded(
                          child: Container(
                              color: dinnerFlag
                                  ? HexColor("#CDFB47")
                                  : Colors.grey[700],
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      dinnerFlag = true;

                                      lunchFlag = false;

                                      breakfastFlag = false;
                                    });
                                  },
                                  child: text(
                                      text: "Dinner",
                                      fontColor: dinnerFlag
                                          ? Colors.black
                                          : Colors.white))),
                        ),
                      ],
                    ),
                    state is! LoadingGetMealState
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  if (breakfastFlag)
                                    Expanded(
                                      child: MealCubit.get(context)
                                              .breakfastMealData
                                              .isNotEmpty
                                          ? Expanded(
                                              child: ListView.separated(
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              if (MealCubit.get(context)
                                                                          .breakfastMealData[index]
                                                                      [
                                                                      "type"] ==
                                                                  "breakfast")
                                                                text(
                                                                    text: MealCubit.get(context).breakfastMealData[index]
                                                                        [
                                                                        "meal"])
                                                            ],
                                                          ),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          verticalSpace(
                                                              space: 10),
                                                  itemCount:
                                                      MealCubit.get(context)
                                                          .breakfastMealData
                                                          .length),
                                            )
                                          : SingleChildScrollView(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image(
                                                      image: CachedNetworkImageProvider(
                                                          "https://img.freepik.com/free-psd/lying-down-watching-movies-home-3d-illustration_1419-2560.jpg?t=st=1735255085~exp=1735258685~hmac=41e4cc0ba502404ceb06ec0afb4ef2435f353087805de89f7404edc1df9ea25b&w=740")),
                                                  Center(
                                                    child: text(
                                                        text:
                                                            "There is no breakfast yet\n Waittttt!!",
                                                        fontSize: 25,
                                                        fontColor:
                                                            secondaryColor),
                                                  ),
                                                ],
                                              ),
                                          ),
                                    ),
                                  if (lunchFlag)
                                    Expanded(
                                      child: MealCubit.get(context)
                                              .lunchMealData
                                              .isNotEmpty
                                          ? Expanded(
                                              child: ListView.separated(
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              text(
                                                                  text: MealCubit.get(context)
                                                                          .lunchMealData[index]
                                                                      [
                                                                      "meal"])
                                                            ],
                                                          ),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          verticalSpace(
                                                              space: 10),
                                                  itemCount:
                                                      MealCubit.get(context)
                                                          .lunchMealData
                                                          .length),
                                            )
                                          : SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                              children: [
                                                Image(
                                                    image: CachedNetworkImageProvider(
                                                        "https://img.freepik.com/free-psd/lying-down-watching-movies-home-3d-illustration_1419-2560.jpg?t=st=1735255085~exp=1735258685~hmac=41e4cc0ba502404ceb06ec0afb4ef2435f353087805de89f7404edc1df9ea25b&w=740")),
                                                Center(
                                                  child: text(
                                                      text:
                                                          "There is no lunch yet\n Waittttt!!",
                                                      fontSize: 25,
                                                      fontColor:
                                                          secondaryColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                    ),
                                  if (dinnerFlag)
                                    Expanded(
                                      child: MealCubit.get(context)
                                              .dinnerMealData
                                              .isNotEmpty
                                          ? Expanded(
                                              child: ListView.separated(
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              text(
                                                                  text: MealCubit.get(context)
                                                                          .dinnerMealData[index]
                                                                      [
                                                                      "meal"])
                                                            ],
                                                          ),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          verticalSpace(
                                                              space: 10),
                                                  itemCount:
                                                      MealCubit.get(context)
                                                          .dinnerMealData
                                                          .length),
                                            )
                                          : SingleChildScrollView(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image(
                                                      image: CachedNetworkImageProvider(
                                                          "https://img.freepik.com/free-psd/lying-down-watching-movies-home-3d-illustration_1419-2560.jpg?t=st=1735255085~exp=1735258685~hmac=41e4cc0ba502404ceb06ec0afb4ef2435f353087805de89f7404edc1df9ea25b&w=740")),
                                                  Center(
                                                    child: text(
                                                        text:
                                                            "There is no dinner yet\n Waittttt!!",
                                                        fontSize: 25,
                                                        fontColor:
                                                            secondaryColor),
                                                  ),
                                                ],
                                              ),
                                          ),
                                    ),
                                  ////Error here when keyboard is Enabled
                                  if (widget.isAdmin)
                                    defaultButton(context,
                                        label: "Add Food",
                                        color: Colors.grey[700],
                                        fontSize: 20, function: () {
                                      moveForward(
                                          context: context,
                                          page: AddFood(
                                            id: widget.id,
                                            day: widget.day,
                                          ));
                                    }),
                                ],
                              ),
                            ),
                          )
                        : Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
}
