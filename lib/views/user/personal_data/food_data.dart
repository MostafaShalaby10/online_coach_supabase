import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_coach_supabase/logic/user_personal_data/user_personal_data_cubit.dart';
import 'package:online_coach_supabase/shared/components/components.dart';
import 'package:online_coach_supabase/shared/constants/constants.dart';
import 'package:online_coach_supabase/views/user/user_home_page.dart';

class FoodData extends StatefulWidget {
  const FoodData({super.key});

  @override
  State<FoodData> createState() => _FoodDataState();
}

class _FoodDataState extends State<FoodData> {
  var forbiddenFoodController = TextEditingController();
  var mealsNumberController = TextEditingController();
  var firstMealTimeController = TextEditingController();
  var trainingTimeController = TextEditingController();
  List breakfastFood = [];
  List lunchFood = [];
  List fruitFood = [];
  List snacksFood = [];
  List vegetablesFood = [];

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => UserPersonalDataCubit(),
  child: BlocConsumer<UserPersonalDataCubit, UserPersonalDataState>(
        builder: (context, state) => Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child:
                      Form(
                          key: formKey,
                          child: Column(
                            spacing: 20,
                            children: [
                              textField(
                                  type: TextInputType.text,
                                  label: "عندك حساسيه من اكل معين",
                                  prefixIcon: Icons.no_food,
                                  controller: forbiddenFoodController),
                              textField(
                                  type: TextInputType.number,
                                  label: "تقدر تاكل كام وجبه في اليوم",
                                  prefixIcon: Icons.fastfood_outlined,
                                  controller: mealsNumberController),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: InkWell(
                                  onTap: () async {
                                    final TimeOfDay? result =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now());
                                    firstMealTimeController.text =
                                        result!.format(context);
                                  },
                                  child: textField(
                                      enabled: false,
                                      type: TextInputType.text,
                                      label: "عايز اول وجبه الساعه كام",
                                      prefixIcon: Icons.timer_sharp,
                                      controller: firstMealTimeController),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: InkWell(
                                  onTap: () async {
                                    final TimeOfDay? result =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now());
                                    trainingTimeController.text =
                                        result!.format(context);
                                  },
                                  child: textField(
                                      enabled: false,
                                      type: TextInputType.text,
                                      label: "عايز التمرين يبقي الساعه كام",
                                      prefixIcon: Icons.timer_sharp,
                                      controller: trainingTimeController),
                                ),
                              ),
                              text(text: "Breakfast and Dinner Options :)"),
                              DropdownMenu(
                                  hintText: "Choose your favorite food",
                                  width: MediaQuery.of(context).size.width,
                                  textStyle: TextStyle(color: Colors.white),
                                  onSelected: (value) {
                                    setState(() {
                                      if (!(breakfastFood.contains(value))) {
                                        breakfastFood.add(value);
                                      }
                                    });
                                  },
                                  dropdownMenuEntries: [
                                    DropdownMenuEntry(
                                        value: "لبن", label: "لبن"),
                                    DropdownMenuEntry(
                                        value: "جبنه قريش",
                                        label: "جبنه قريش"),
                                    DropdownMenuEntry(
                                        value: "بيض", label: "بيض"),
                                    DropdownMenuEntry(
                                        value: "شوفان", label: "شوفان"),
                                    DropdownMenuEntry(
                                        value: "بطاطس", label: "بطاطس"),
                                    DropdownMenuEntry(
                                        value: "بطاطا", label: "بطاطا"),
                                    DropdownMenuEntry(
                                        value: "صفار بيض", label: "صفار بيض"),
                                    DropdownMenuEntry(
                                        value: "فول", label: "فول"),
                                  ]),
                              if (breakfastFood.isNotEmpty)
                                SizedBox(
                                  height: 50.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: breakfastFood.length,
                                      itemBuilder: (context, index) =>
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                  border: Border.all(
                                                      color: Colors.white24)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 8.0),
                                                child: Row(
                                                  children: [
                                                    text(
                                                        text: breakfastFood[
                                                            index]),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            breakfastFood
                                                                .removeAt(
                                                                    index);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color:
                                                              Colors.red[400],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                ),
    
                              //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                              text(text: "Lunch Options :)"),
                              DropdownMenu(
                                  hintText: "Choose your favorite food",
                                  width: MediaQuery.of(context).size.width,
                                  textStyle: TextStyle(color: Colors.white),
                                  onSelected: (value) {
                                    setState(() {
                                      if (!(lunchFood.contains(value))) {
                                        lunchFood.add(value);
                                      }
                                    });
                                  },
                                  dropdownMenuEntries: [
                                    DropdownMenuEntry(
                                        value: "فراخ", label: "فراخ"),
                                    DropdownMenuEntry(
                                        value: "لحمه", label: "لحمه"),
                                    DropdownMenuEntry(
                                        value: "سمك", label: "سمك"),
                                    DropdownMenuEntry(
                                        value: "كبده", label: "كبده"),
                                    DropdownMenuEntry(
                                        value: "حمص", label: "حمص"),
                                    DropdownMenuEntry(
                                        value: "رز", label: "رز"),
                                    DropdownMenuEntry(
                                        value: "مكرونه", label: "مكرونه"),
                                  ]),
                              if (lunchFood.isNotEmpty)
                                SizedBox(
                                  height: 50.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: lunchFood.length,
                                      itemBuilder: (context, index) =>
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                  border: Border.all(
                                                      color: Colors.white24)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 8.0),
                                                child: Row(
                                                  children: [
                                                    text(
                                                        text:
                                                            lunchFood[index]),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            lunchFood
                                                                .removeAt(
                                                                    index);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color:
                                                              Colors.red[400],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                ),
    
                              //////////////////////////////////////////////////////////
    
                              text(text: "Fruit Options :)"),
                              DropdownMenu(
                                  hintText: "Choose your favorite food",
                                  width: MediaQuery.of(context).size.width,
                                  textStyle: TextStyle(color: Colors.white),
                                  onSelected: (value) {
                                    setState(() {
                                      if (!(fruitFood.contains(value))) {
                                        fruitFood.add(value);
                                      }
                                    });
                                  },
                                  dropdownMenuEntries: [
                                    DropdownMenuEntry(
                                        value: "بطيخ", label: "بطيخ"),
                                    DropdownMenuEntry(
                                        value: "اناناس", label: "اناناس"),
                                    DropdownMenuEntry(
                                        value: "تفاح", label: "تفاح"),
                                    DropdownMenuEntry(
                                        value: "فراوله", label: "فراوله"),
                                    DropdownMenuEntry(
                                        value: "موز", label: "موز"),
                                    DropdownMenuEntry(
                                        value: "تين شوكي", label: "تين شوكي"),
                                    DropdownMenuEntry(
                                        value: "برقوق", label: "برقوق"),
                                    DropdownMenuEntry(
                                        value: "توت", label: "توت"),
                                  ]),
                              if (fruitFood.isNotEmpty)
                                SizedBox(
                                  height: 50.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: fruitFood.length,
                                      itemBuilder: (context, index) =>
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                  border: Border.all(
                                                      color: Colors.white24)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 8.0),
                                                child: Row(
                                                  children: [
                                                    text(
                                                        text:
                                                            fruitFood[index]),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            fruitFood
                                                                .removeAt(
                                                                    index);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color:
                                                              Colors.red[400],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                ),
                              /////////////////////////////////////////////////////////////////////////////////////
    
                              text(text: "Vegetables Options :)"),
                              DropdownMenu(
                                  hintText: "Choose your favorite food",
                                  width: MediaQuery.of(context).size.width,
                                  textStyle: TextStyle(color: Colors.white),
                                  onSelected: (value) {
                                    setState(() {
                                      if (!(vegetablesFood.contains(value))) {
                                        vegetablesFood.add(value);
                                      }
                                    });
                                  },
                                  dropdownMenuEntries: [
                                    DropdownMenuEntry(
                                        value: "فلفل بجميع الالوان ",
                                        label: "فلفل بجميع الالوان "),
                                    DropdownMenuEntry(
                                        value: "طماطم", label: "طماطم"),
                                    DropdownMenuEntry(
                                        value: "خس", label: "خس"),
                                    DropdownMenuEntry(
                                        value: "بروكلي", label: "بروكلي"),
                                    DropdownMenuEntry(
                                        value: "خيار", label: "خيار"),
                                    DropdownMenuEntry(
                                        value: "فاصوليا", label: "فاصوليا"),
                                    DropdownMenuEntry(
                                        value: "بسله", label: "بسله"),
                                    DropdownMenuEntry(
                                        value: "كوسه", label: "كوسه"),
                                  ]),
                              if (vegetablesFood.isNotEmpty)
                                SizedBox(
                                  height: 50.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: vegetablesFood.length,
                                      itemBuilder: (context, index) =>
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                  border: Border.all(
                                                      color: Colors.white24)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 8.0),
                                                child: Row(
                                                  children: [
                                                    text(
                                                        text: vegetablesFood[
                                                            index]),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            vegetablesFood
                                                                .removeAt(
                                                                    index);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color:
                                                              Colors.red[400],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                ),
                              ///////////////////////////////////////////////////////////////////////////////////////////
    
                              text(text: "Snack Options :)"),
                              DropdownMenu(
                                  hintText: "Choose your favorite food",
                                  width: MediaQuery.of(context).size.width,
                                  textStyle: TextStyle(color: Colors.white),
                                  onSelected: (value) {
                                    setState(() {
                                      if (!(snacksFood.contains(value))) {
                                        snacksFood.add(value);
                                      }
                                    });
                                  },
                                  dropdownMenuEntries: [
                                    DropdownMenuEntry(
                                        value: "افوكادو", label: "افوكادو"),
                                    DropdownMenuEntry(
                                        value: "زبده فول سوداني",
                                        label: "زبده فول سوداني"),
                                    DropdownMenuEntry(
                                        value: "مكسرات بشكل عام",
                                        label: "مكسرات بشكل عام"),
                                  ]),
                              if (snacksFood.isNotEmpty)
                                SizedBox(
                                  height: 50.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snacksFood.length,
                                      itemBuilder: (context, index) =>
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                  border: Border.all(
                                                      color: Colors.white24)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 8.0),
                                                child: Row(
                                                  children: [
                                                    text(
                                                        text: snacksFood[
                                                            index]),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            snacksFood
                                                                .removeAt(
                                                                    index);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color:
                                                              Colors.red[400],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                ),
                              state is! LoadingAddPersonalDataState
                                  ? defaultButton(context,
                                      label: "Save",
                                      fontSize: 20, function: () {
                                      if (formKey.currentState!.validate()) {
                                        setPersonalData.addAll({
                                          "forbiddenfood":
                                              forbiddenFoodController.text,
                                          "mealnumber":
                                              mealsNumberController.text,
                                          "firstmealtime":
                                              firstMealTimeController.text,
                                          "trainingtime":
                                              trainingTimeController.text,
                                          "favbreakfast": breakfastFood,
                                          "favlunch": lunchFood,
                                          "favfruit": fruitFood,
                                          "favsnacks": snacksFood,
                                          "favvegetables": vegetablesFood,
                                        });
                                        UserPersonalDataCubit.get(context)
                                            .addPersonalData(
                                                data: setPersonalData);
                                      }
                                    })
                                  : Center(
                                      child: CircularProgressIndicator()),
                            ],
                          ),
                        )
                ),
              ),
            ),
        listener: (context, state) {
          if (state is SuccessfullyAddPersonalDataState) {
            toastMSG(text: "Added data successfully", color: Colors.green);
            moveForwardAndRemove(context: context, page: UserHomePage());
          } else if (state is ErrorAddPersonalDataState) {
            toastMSG(text: state.error.toString(), color: Colors.red);
          }
        }),
);
  }
}