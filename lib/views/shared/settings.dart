import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_coach_supabase/views/shared/update_data.dart';
import 'package:online_coach_supabase/views/shared/update_password.dart';

import 'package:url_launcher/url_launcher_string.dart';
import '../../logic/user_data/user_data_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/shared_preferences/shared_preferences.dart';
import '../authentication/login.dart';

class Settings extends StatelessWidget {
  final int id;

  final bool isAdmin;

  const Settings({super.key, required this.isAdmin, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataCubit()..getSpecificUsersDataById(id: id),
      child: BlocConsumer<UserDataCubit, UserDataState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  TextButton(
                      onPressed: () {
                        SharedPrefs.removeData(key: "role");
                        SharedPrefs.removeData(key: "id");
                        moveForwardAndRemove(context: context, page: Login());
                      },
                      child: text(text: "Logout", fontColor: Colors.red))
                ],
              ),
              body: state is! LoadingGetSpecificUsersState
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: text(text: "Contact Coach", fontSize: 24)),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: () {
                                        launchUrlString(
                                            "https://www.instagram.com/mostafa.gamal32?igsh=MWZzZDA3ZHN5ZW56MA==",
                                            mode:
                                                LaunchMode.externalApplication);
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.instagram,
                                        color: Colors.red,
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: () {
                                        launchUrlString(
                                            "whatsapp://send?text=&phone=+201093080663",
                                            mode:
                                                LaunchMode.externalApplication);
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Colors.green,
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: () {
                                        launchUrlString("tel:+201093080663",
                                            mode:
                                                LaunchMode.externalApplication);
                                      },
                                      icon: const Icon(
                                        Icons.call,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {
                                          moveForward(
                                              context: context,
                                              page: UpdateData(
                                                  id: id, isAdmin: isAdmin));
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ))),
                                text(
                                    text: UserDataCubit.get(context)
                                        .specificUsersDataById[0]["name"],
                                    fontSize: 25),
                                text(
                                    text: UserDataCubit.get(context)
                                        .specificUsersDataById[0]["phone"],
                                    fontSize: 20),
                                text(
                                    text: UserDataCubit.get(context)
                                        .specificUsersDataById[0]["email"],
                                    fontSize: 20),
                              ],
                            ),
                          ),
                          verticalSpace(space: 20),
                          InkWell(
                            onTap: () {
                              moveForward(
                                  context: context, page: UpdatePassword());
                            },
                            child: Container(
                              height: 50.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    text(
                                        text: "Change password",
                                        fontColor: Colors.black,
                                        fontSize: 17,
                                        textAlign: TextAlign.start),
                                    Spacer(),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 30,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            );
          },
          listener: (context, state) {}),
    );
  }
}
