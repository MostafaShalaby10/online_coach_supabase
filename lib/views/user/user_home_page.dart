import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:online_coach_supabase/main.dart';
import 'package:online_coach_supabase/shared/shared_preferences/shared_preferences.dart';
import 'package:online_coach_supabase/views/shared/no_internet.dart';
import 'package:online_coach_supabase/views/user/personal_data/personal_data.dart';
import 'package:online_coach_supabase/views/shared/settings.dart';
import 'package:online_coach_supabase/views/user/tips_page.dart';
import '../../shared/components/components.dart';
import '../shared/days.dart';
import '../shared/show_supplements.dart';

class UserHomePage extends StatefulWidget {
  // final int id ;
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  moveForward(
                      context: context,
                      page: Settings(
                        isAdmin: false,
                        id: SharedPrefs.getData(key: "id"),
                      ));
                },
                icon: const Icon(Icons.settings)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                homePageCard(context, function: () {
                  moveForward(
                      context: context,
                      page: PersonalData(
                        id: SharedPrefs.getData(key: "id"),
                      ));
                },
                    mainText: "Enter your data",
                    color: HexColor("#6ACCBC"),
                    description: "Enter your data to set the exercise and diet",
                    image: "assets/personal_data.png",
                    imageAlignment: Alignment.centerRight,
                    textAlignment: Alignment.centerLeft,
                    rightPadding: 0,
                    leftPadding: 20),
                homePageCard(context, function: () {
                  moveForward(context: context, page: const TipsPage());
                },
                    mainText: "Tips",
                    color: HexColor("#CDFB47"),
                    description:
                        "Use these tips in your daily life for better health",
                    image: "assets/tips_icon.png",
                    imageAlignment: Alignment.centerLeft,
                    textAlignment: Alignment.centerRight,
                    rightPadding: 0,
                    leftPadding: 0),
                homePageCard(context, function: () {
                  moveForward(
                      context: context,
                      page: Days(
                        isExercise: true,
                        uid: SharedPrefs.getData(key: "id"),
                        isAdmin: false,
                      ));
                },
                    mainText: "Exercise",
                    color: HexColor("#F6A010"),
                    description: "This is the exercises for the current week",
                    image: "assets/img.png",
                    imageAlignment: Alignment.centerRight,
                    textAlignment: Alignment.centerLeft,
                    rightPadding: 0,
                    leftPadding: 10),
                homePageCard(context, function: () {
                  moveForward(
                      context: context,
                      page: Days(
                        isExercise: false,
                        uid: SharedPrefs.getData(key: "id"),
                        isAdmin: false,
                      ));
                },
                    mainText: "Food",
                    color: HexColor("#29BFC9"),
                    description: "This is your diet for the current week",
                    image: "assets/foodImg.png",
                    imageAlignment: Alignment.centerLeft,
                    textAlignment: Alignment.centerRight,
                    rightPadding: 0,
                    leftPadding: 0),
                homePageCard(context, function: () {
                  moveForward(
                      context: context,
                      page: ShowSupplements(
                          id: SharedPrefs.getData(key: "id"), isAdmin: false));
                },
                    mainText: "Supplements",
                    color: HexColor("#FF805E"),
                    description: "This is your supplements",
                    image: "assets/supplements.png",
                    imageAlignment: Alignment.centerRight,
                    textAlignment: Alignment.centerLeft,
                    rightPadding: 0,
                    leftPadding: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
