import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_coach_supabase/logic/authentication/authentication_cubit.dart';

import '../../shared/components/components.dart';
import '../authentication/login.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}



class _UpdatePasswordState extends State<UpdatePassword> {
  bool isPassword = true;
  bool isCONFPassword = true;
  var formKey = GlobalKey<FormState>();
  TextEditingController confPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AUTHCubit(),
      child:
      BlocConsumer<AUTHCubit, AUTHState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    textField(
                        controller: passwordController,
                        label: "password",
                        prefixIcon: Icons.lock_outline,
                        type: TextInputType.visiblePassword,
                        isPass: isPassword,
                        suffixIcon: isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixIconFunction: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        }),
                    verticalSpace(space: 15),
                    textField(
                        controller: confPasswordController,
                        label: "CONF-password",
                        prefixIcon: Icons.lock_outline,
                        type: TextInputType.visiblePassword,
                        isPass: isCONFPassword,
                        suffixIcon: isCONFPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixIconFunction: () {
                          setState(() {
                            isCONFPassword = !isCONFPassword;
                          });
                        }),
                    verticalSpace(space: 25),
                    state is! LoadingUpdateUserPasswordData
                        ? defaultButton(context, label: "Confirm", fontSize: 20,
                        color: Colors.amber,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            if (passwordController.text.length > 5&&passwordController.text ==
                                confPasswordController.text) {
                              AUTHCubit.get(context).updateUserPassword(
                                  newPassword: passwordController.text);
                            } else {
                              passwordController.text.length < 5 ? toastMSG(text: "The password is less than 6 characters", color: Colors.red):toastMSG(
                                  text: "Passwords aren't match",
                                  color: Colors.red);
                            }
                          }
                        })
                        : const Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is SuccessfulUpdateUserPasswordData) {
          passwordController.clear();
          confPasswordController.clear();
          toastMSG(text: "Password changed successfully", color: Colors.green);
          moveForwardAndRemove(context: context, page: const Login());
        } else if (state is ErrorUpdateUserPasswordData) {
          toastMSG(text: state.error.toString(), color: Colors.red);
        }
      }),
    );
  }
}
