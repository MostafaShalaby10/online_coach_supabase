import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_coach_supabase/logic/user_data/user_data_cubit.dart';
import 'package:online_coach_supabase/shared/components/components.dart';
import 'package:online_coach_supabase/views/admin/show_personal_data.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataCubit(),
      child: BlocConsumer<UserDataCubit, UserDataState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      UserDataCubit.get(context).searchClient(name: value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white)),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: UserDataCubit.get(context).searchItems.length,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                moveForward(
                                    context: context,
                                    page: ShowPersonalData(
                                      userId: UserDataCubit.get(context)
                                          .searchItems[index]['id'],
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              text(
                                                fontColor: Colors.black,
                                                text: UserDataCubit.get(context)
                                                    .searchItems[index]['name'],
                                              ),
                                              text(
                                                  fontColor: Colors.black,
                                                  text:
                                                      UserDataCubit.get(context)
                                                              .searchItems[index]
                                                          ['phone']),
                                              text(
                                                  fontColor: Colors.black,
                                                  text:
                                                      UserDataCubit.get(context)
                                                              .searchItems[index]
                                                          ['email']),
                                            ],
                                          ),
                                        ),
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
                                            icon: Icon(Icons.call)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
