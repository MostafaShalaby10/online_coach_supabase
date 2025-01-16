import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../logic/meal/meal_cubit.dart';
import '../../shared/components/components.dart';

class AddFood extends StatefulWidget {
  final int id;

  final String day;

  const AddFood({super.key, required this.id, required this.day});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController mealController = TextEditingController();
  String dropdownValue = 'breakfast';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      MealCubit(),
      child: BlocConsumer<MealCubit, MealState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: text(text: "Add Food"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(spacing: 20.h,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      dropdownColor: Colors.black,
                      value: dropdownValue,
                      items: <String>['breakfast', 'lunch', 'dinner']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(

                            value,
                            style: const TextStyle(fontSize: 24 , color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                    textField(
                        type: TextInputType.text,
                        label: "Add the meal",
                        prefixIcon: Icons.fastfood_outlined,
                        controller: mealController),
                    verticalSpace(space: 20),
                    state is! LoadingAddMealState? defaultButton(context,
                            label: "Save",
                            fontSize: 20,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                MealCubit.get(context).addMealCubit(
                                  userId: widget.id,
                                  day: widget.day, meal: mealController.text, type: dropdownValue,
                                );
                              }
                            }):
                        const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is SuccessfullyAddMealState) {
          toastMSG(text: "Added meal successfully", color: Colors.green);
          mealController.clear();
        } else if (state is ErrorAddMealState) {
          toastMSG(text: state.error.toString(), color: Colors.red);
        }
      }),
    );
  }
}
