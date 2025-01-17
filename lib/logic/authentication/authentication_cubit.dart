import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_coach_supabase/shared/shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';

part 'authentication_state.dart';

class AUTHCubit extends Cubit<AUTHState>  {
  AUTHCubit() : super(LoginInitial());

  static AUTHCubit get(context) => BlocProvider.of(context);

  //    authentication function

  void loginCubitFunction(
      {required String email, required String password}) async {
    emit(LoadingLoginState());
    supaBase.auth.admin;
    await supaBase.auth
        .signInWithPassword(password: password, email: email)
        .then((value) async {
      await getSpecificUsersData(email: email);
      specificUsersData[0]["role"] == "user"
          ? SharedPrefs.saveData(key: "role", value: "user")
          : SharedPrefs.saveData(key: "role", value: "admin");
      SharedPrefs.saveData(key: "id", value: specificUsersData[0]["id"]);
      emit(SuccessfullyLoginState());
    }).catchError((error) {
      emit(ErrorLoginState(error.toString()));
    });
  }

  void updateUserPassword({required String newPassword}) {
    emit(LoadingUpdateUserPasswordData());
    supaBase.auth
        .updateUser(
      UserAttributes(
        password: newPassword,
      ),
    )
        .then((value) {
      emit(SuccessfulUpdateUserPasswordData());
    }).catchError((error) {
      emit(ErrorUpdateUserPasswordData(error.toString()));
    });
  }

  List specificUsersData = [];

  Future getSpecificUsersData({required String email}) async {
    specificUsersData = [];
    emit(LoadingGetSpecificUsersState());
    await supaBase.from("User_data").select().eq("email", email).then((value) {
      specificUsersData = value;
      emit(SuccessfullyGetSpecificUsersState());
    }).catchError((error) {
      emit(ErrorGetSpecificUsersState(error.toString()));
    });
  }

}
