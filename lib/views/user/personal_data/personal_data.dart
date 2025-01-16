import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_coach_supabase/logic/user_personal_data/user_personal_data_cubit.dart';
import 'package:online_coach_supabase/shared/shared_preferences/shared_preferences.dart';

import '../../../shared/components/components.dart';
import '../../../shared/constants/constants.dart';
import 'gym_history.dart';


class PersonalData extends StatefulWidget {
  final int id;

  const PersonalData({super.key, required this.id});

  @override
  State<PersonalData> createState() => _PersonalDataState();

}


class _PersonalDataState extends State<PersonalData> {
  String? _selectedGender;
  TextEditingController ageController = TextEditingController();
  TextEditingController tallController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      UserPersonalDataCubit()
        ..getPersonalData(id: SharedPrefs.getData(key: "id")),
      child: BlocConsumer<UserPersonalDataCubit, UserPersonalDataState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: state is! LoadingGetPersonalDataState ?Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
          child: UserPersonalDataCubit.get(context).allPersonalData.isEmpty?SingleChildScrollView(
          child: Form(
          key: formKey,
          child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          text(
          text: "Personal Data",
          fontSize: 40,
          fontWeight: FontWeight.w900),
          Expanded(
          flex: 1,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          textField(
          controller: ageController,
          type: TextInputType.number,
          label: "Age",
          prefixIcon: Icons.person_rounded,
          ),
          verticalSpace(space: 20),
          textField(
          controller: tallController,
          type: TextInputType.number,
          label: "Tall",
          prefixIcon: Icons.height,
          ),
          verticalSpace(space: 20),
          textField(
          controller: weightController,
          type: TextInputType.number,
          label: "Weight",
          prefixIcon: Icons.numbers,
          ),
          verticalSpace(space: 20),
          Row(
          children: [
          text(text: "Gender"),
          Expanded(
          child: ListTile(
          leading: Radio<String>(
          value: 'male',
          groupValue: _selectedGender,
          onChanged: (value) {
          setState(() {
          _selectedGender = value!;
          });
          },
          activeColor: secondaryColor,
          ),
          horizontalTitleGap: 0,
          title: const Text('Male' , style: TextStyle(color: Colors.white),),
          ),
          ),
          Expanded(
          child: ListTile(
          leading: Radio<String>(
          value: 'female',
          groupValue: _selectedGender,
          onChanged: (value) {
          setState(() {
          _selectedGender = value!;
          });
          },
          activeColor: secondaryColor,
          ),
          horizontalTitleGap: 0,
          title: const Text('Female',style: TextStyle(color: Colors.white , fontSize: 17)) ,
          ),
          ),
          ],
          ),
          verticalSpace(space: 40),
          defaultButton(context,
          label: "Next",
          fontSize: 20,
          function: () {
          if (formKey.currentState!.validate()) {
          if (_selectedGender!=null) {
          setPersonalData.addAll({
          "user_id" : widget.id ,
          "weight" : weightController.text ,
          "height" : tallController.text ,
          "age" : ageController.text ,
          "gender" : _selectedGender ,
          });

          moveForward(context: context, page:const GymHistory());
          } else{
          toastMSG(text: "Please enter gender", color: Colors.red);
          }
          }
          }),
          ],
          ),
          )
          ],
          ),
          ),
          ),
          ):Column(children: [Center(child: text(text: "You already enter your data..." , fontSize: 20 , fontWeight: FontWeight.w600)) , Center(child: text(text: "Ask admin to clear your data")) ],),
          ):Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
