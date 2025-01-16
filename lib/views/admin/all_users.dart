import 'package:cached_network_image/cached_network_image.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_coach_supabase/views/admin/admin_home_page.dart';
import 'package:online_coach_supabase/views/admin/search.dart';
import 'package:online_coach_supabase/views/admin/show_personal_data.dart';
import 'package:online_coach_supabase/views/shared/update_data.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../logic/user_data/user_data_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataCubit()..getUsersData(),
      child: BlocConsumer<UserDataCubit, UserDataState>(
        listener: (context, state) {
          if(state is SuccessfullyRemoveUserState)
            {
              moveForwardAndRemove(context: context, page: AdminHomePage());
            }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        moveForward(context: context, page: Search());
                      },
                      icon: Icon(Icons.search))
                ],
              ),
              body: state is! LoadingGetUsersState
                  ? UserDataCubit.get(context).usersData.isNotEmpty
                      ? ListView.separated(
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  moveForward(
                                      context: context,
                                      page: ShowPersonalData(
                                        userId: UserDataCubit.get(context)
                                            .usersData[index]['id'],
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Stack(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              IconButton(onPressed: (){moveForward(context: context, page: UpdateData(id: UserDataCubit.get(
                                                  context)
                                                  .usersData[
                                              index]['id'], isAdmin: true));}, icon: Icon(Icons.edit)) ,
                                              IconButton(
                                                  onPressed: () async {
                                                    if (await confirm(
                                                      context,
                                                      title: text(
                                                          text: "Warning" , fontColor: Colors.red),
                                                      canPop: true,
                                                      content: text(
                                                        text:
                                                        "Are you sure to delete Client",
                                                        fontColor: Colors.black
                                                      ),
                                                    )) {
                                                      UserDataCubit.get(
                                                          context)
                                                          .removeClient(
                                                          id: UserDataCubit.get(
                                                              context)
                                                              .usersData[
                                                          index]['id']);
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .delete_forever_outlined,
                                                    color: Colors.red,
                                                  )),
                                            ],
                                          ) ,

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              text(
                                                fontColor: Colors.black,
                                                text:
                                                    UserDataCubit.get(context)
                                                            .usersData[index]
                                                        ['name'],
                                              ),
                                              text(
                                                  fontColor: Colors.black,
                                                  text: UserDataCubit.get(
                                                              context)
                                                          .usersData[index]
                                                      ['phone']),
                                              text(
                                                  fontColor: Colors.black,
                                                  text: UserDataCubit.get(
                                                              context)
                                                          .usersData[index]
                                                      ['email']),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    launchUrlString(
                                                        "tel:+2${UserDataCubit.get(context).usersData[index]['phone']}");
                                                  },
                                                  icon: Icon(Icons.call)),
                                              IconButton(
                                                  onPressed: () {
                                                    launchUrlString(
                                                        "whatsapp://send?text=&phone=+2${UserDataCubit.get(context).usersData[index]['phone']}");
                                                  },
                                                  icon: Icon(FontAwesomeIcons.whatsapp))

                                            ],
                                          ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) =>
                              verticalSpace(space: 10),
                          itemCount:
                              UserDataCubit.get(context).usersData.length)
                      : Column(
                          children: [
                            Image(
                                image: CachedNetworkImageProvider(
                                    "https://img.freepik.com/free-vector/glitch-error-404-page_23-2148105404.jpg?t=st=1735266602~exp=1735270202~hmac=ca600eb33b96958b9e0e41e8bdaffeab8505789aceaea46670f581cf7847408f&w=740")),
                            Center(
                              child: text(
                                  text: "There is no users yet!!",
                                  fontSize: 25,
                                  fontColor: secondaryColor),
                            ),
                          ],
                        )
                  : Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
