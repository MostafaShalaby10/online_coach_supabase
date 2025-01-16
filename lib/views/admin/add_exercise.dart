import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/exercise/exercise_cubit.dart';
import '../../shared/components/components.dart';

class AddExercise extends StatelessWidget {
  final int id;
  final String day;

  AddExercise({super.key, required this.id, required this.day});

  final TextEditingController exerciseLabelController = TextEditingController();
  final TextEditingController exerciseSetController = TextEditingController();
  final TextEditingController exerciseRepsController = TextEditingController();
  final TextEditingController exerciseLinkController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExerciseCubit()..getExerciseCubit(userId: id, day: day),
      child:
          BlocConsumer<ExerciseCubit, ExerciseState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: text(text: "Add Exercise"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10.h,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textField(
                        type: TextInputType.text,
                        label: "Add exercise label",
                        prefixIcon: Icons.sports_gymnastics_outlined,
                        controller: exerciseLabelController),
                    textField(
                        type: TextInputType.number,
                        label: "Add the Sets",
                        prefixIcon: Icons.numbers_outlined,
                        controller: exerciseSetController),
                    textField(
                        type: TextInputType.number,
                        label: "Add the REPS",
                        prefixIcon: Icons.numbers_outlined,
                        controller: exerciseRepsController),
                    textField(
                        type: TextInputType.text,
                        label: "Add exercise link",
                        prefixIcon: Icons.link,
                        controller: exerciseLinkController),
                    state is! LoadingAddExerciseState
                        ? defaultButton(context, label: "Save", fontSize: 20,
                            function: () {
                            if (formKey.currentState!.validate()) {
                              ExerciseCubit.get(context).addExerciseCubit(
                                  userId: id,
                                  day: day,
                                  sets: int.parse(exerciseSetController.text),
                                  reps: int.parse(exerciseRepsController.text),
                                  label: exerciseLabelController.text,
                                  link: exerciseLinkController.text);
                            }
                          })
                        : Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is SuccessfullyAddExerciseState) {
          exerciseLinkController.clear();
          exerciseLabelController.clear();
          exerciseSetController.clear();
          exerciseRepsController.clear();
          toastMSG(text: "Added Exercise Successfully", color: Colors.green);
        } else if (state is ErrorAddExerciseState) {
          toastMSG(text: state.error.toString(), color: Colors.red);
        }
      }),
    );
  }
}
