import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_coach_supabase/shared/shared_preferences/shared_preferences.dart';
import 'package:online_coach_supabase/views/admin/admin_home_page.dart';
import 'package:online_coach_supabase/views/user/user_home_page.dart';

import '../../logic/authentication/authentication_cubit.dart';
import '../../shared/components/components.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPassword = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AUTHCubit(),
      child: BlocConsumer<AUTHCubit, AUTHState>(
          builder: (context, state) => Scaffold(
                body: SafeArea(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 15),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text(
                              text: "Welcome",
                              fontColor: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: text(
                                fontColor: Colors.grey,
                                text: "Login Page",
                                fontSize: 25,
                              ),
                            ),
                            verticalSpace(space: 30),
                            textField(
                              controller: emailController,
                              label: "E-mail",
                              prefixIcon: Icons.email_outlined,
                              type: TextInputType.emailAddress,
                            ),
                            verticalSpace(space: 15),
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
                            verticalSpace(space: 40),
                            state is! LoadingLoginState
                                ? defaultButton(context,
                                    label: "Login", fontSize: 20, function: () {
                                    if (formKey.currentState!.validate()) {
                                      AUTHCubit.get(context).loginCubitFunction(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  })
                                : Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
              ),
          listener: (context, state) {
            if (state is SuccessfullyLoginState) {

              SharedPrefs.getData(key: "role") == "user"
                  ? moveForwardAndRemove(context: context, page: UserHomePage())
                  : moveForwardAndRemove(
                      context: context, page: AdminHomePage());
              toastMSG(text: "Login successfully", color: Colors.green);
              emailController.clear();
              passwordController.clear();
            } else if (state is ErrorLoginState) {
              toastMSG(text: state.error.toString(), color: Colors.red);
            }
          }),
    );
  }
}
