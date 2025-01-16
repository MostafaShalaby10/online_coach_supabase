import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_coach_supabase/shared/shared_preferences/shared_preferences.dart';
import 'package:online_coach_supabase/views/admin/add_user.dart';
import 'package:online_coach_supabase/views/authentication/login.dart';

import '../../shared/components/components.dart';
import '../shared/settings.dart';
import 'all_users.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  moveForward(
                      context: context,
                      page: Settings(
                        isAdmin: true,
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
          child: Column(
            spacing: 15.h,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              homePageCard(context,
                  mainText: "All users",
                  description:
                      "See all users, their data, add exercise , diet and supplements ",
                  image: "assets/all_users.png",
                  imageAlignment: Alignment.centerRight,
                  textAlignment: Alignment.centerLeft,
                  rightPadding: 0,
                  color: Colors.lime, function: () {
                moveForward(context: context, page: const AllUsers());
              }, leftPadding: 10),
              homePageCard(
                context,
                mainText: "Add client",
                description: "Add new client",
                image: "assets/add_user.png",
                imageAlignment: Alignment.centerLeft,
                textAlignment: Alignment.centerRight,
                rightPadding: 10,
                leftPadding: 0,
                color: Colors.cyan,
                function: () {
                  moveForward(context: context, page: const AddUser());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
