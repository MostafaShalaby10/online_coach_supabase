import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_coach_supabase/views/user/user_home_page.dart';

import '../../logic/user_data/user_data_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';

class UpdateData extends StatefulWidget {
  final bool isAdmin;
  final int id;

  UpdateData({super.key, required this.id, required this.isAdmin});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final phoneController = TextEditingController();

  final nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late String _selectRole;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserDataCubit()..getSpecificUsersDataById(id: widget.id),
      child:
          BlocConsumer<UserDataCubit, UserDataState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: state is! LoadingGetSpecificUsersState
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        textField(
                            type: TextInputType.name,
                            label: "Name",
                            prefixIcon: Icons.person,
                            controller: nameController),
                        verticalSpace(space: 20),
                        textField(
                            type: TextInputType.phone,
                            label: "Phone",
                            prefixIcon: Icons.phone,
                            controller: phoneController),
                        if(widget.isAdmin)
                        Row(
                          children: [
                            text(text: "Gender"),
                            Expanded(
                              child: ListTile(
                                leading: Radio<String>(
                                  value: 'user',
                                  groupValue: _selectRole,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectRole = value!;
                                    });
                                  },
                                  activeColor: secondaryColor,
                                ),
                                horizontalTitleGap: 0,
                                title: const Text(
                                  'User',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                leading: Radio<String>(
                                  value: 'admin',
                                  groupValue: _selectRole,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectRole = value!;
                                    });
                                  },
                                  activeColor: secondaryColor,
                                ),
                                horizontalTitleGap: 0,
                                title: const Text('Admin',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(space: 30),
                        state is! LoadingUpdateUserState
                            ? defaultButton(context,
                                label: "Update", fontSize: 24, function: () {
                                if (formKey.currentState!.validate()) {
                                  if (phoneController.text.length > 10) {
                                    UserDataCubit.get(context).updateUser(
                                        email: UserDataCubit.get(context)
                                            .specificUsersDataById[0]["email"],
                                        phone: phoneController.text,
                                        name: nameController.text,
                                        role: _selectRole,
                                        id: UserDataCubit.get(context)
                                            .specificUsersDataById[0]["id"]);
                                  } else {
                                    toastMSG(
                                        text: "Enter valid phone number",
                                        color: Colors.red);
                                  }
                                }
                              })
                            : const Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      }, listener: (context, state) {
        if (state is SuccessfullyGetSpecificUsersState) {
          _selectRole = UserDataCubit.get(context).specificUsersDataById[0]["role"];
          nameController.text = UserDataCubit.get(context)
              .specificUsersDataById[0]["name"] ;
          phoneController.text = UserDataCubit.get(context)
              .specificUsersDataById[0]["phone"];
        }
        if (state is SuccessfullyUpdateUserState) {
          toastMSG(text: "Updated Successfully", color: Colors.green);
          moveForwardAndRemove(
              context: context,
              page: UserHomePage());
        } else if (state is ErrorUpdateUserState) {
          toastMSG(text: state.error.toString(), color: Colors.red);
        }
      }),
    );
  }
}
