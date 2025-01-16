import 'package:online_coach_supabase/shared/shared_preferences/shared_preferences.dart';

import '../../model/user_data_model.dart';
import '../../shared/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  static UserDataCubit get(context) => BlocProvider.of(context);

  UserDataModel? userDataModel;

  void userSignUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  }) async {
    emit(LoadingUserSignUpState());
    await supaBase.auth
        .signUp(password: password, email: email)
        .then((value) async {
      await addUser(
        email: email,
        name: name,
        phone: phone,
        role: role,
      );
      emit(SuccessfullyUserSignUpState());
    }).catchError((error) {
      emit(ErrorUserSignUpState(error.toString()));
    });
  }

  Future addUser({
    required String email,
    required String phone,
    required String name,
    required String role,
  }) async {
    emit(LoadingAddUserState());
    userDataModel =
        UserDataModel(email: email, phone: phone, name: name, role: role);
    await supaBase
        .from("User_data")
        .insert(userDataModel!.toMap())
        .then((value) {
      emit(SuccessfullyAddUserState());
    }).catchError((error) {
      emit(ErrorAddUserState(error.toString()));
    });
  }

  List usersData = [];

  Future getUsersData() async {
    usersData = [];
    emit(LoadingGetUsersState());
    await supaBase.from("User_data").select().then((value) {
      for(var element in value)
        {
          if(element["id"]!=SharedPrefs.getData(key: "id"))
            {
              usersData.add(element);
              
            }
        }
      emit(SuccessfullyGetUsersState());
    }).catchError((error) {
      emit(ErrorGetUsersState(error.toString()));
    });
  }

  List specificUsersDataById = [];

  Future getSpecificUsersDataById({required int id}) async {
    specificUsersDataById = [];
    emit(LoadingGetSpecificUsersState());
    await supaBase.from("User_data").select().eq("id", id).then((value) {
      specificUsersDataById = value;
      emit(SuccessfullyGetSpecificUsersState());
    }).catchError((error) {
      emit(ErrorGetSpecificUsersState(error.toString()));
    });
  }

  Future updateUser({
    required String email,
    required String phone,
    required String name,
    required String role,
    required int id,
  }) async {
    emit(LoadingUpdateUserState());
    userDataModel =
        UserDataModel(email: email, phone: phone, name: name, role: role);
    await supaBase
        .from("User_data")
        .update(userDataModel!.toMap())
        .eq("id", id)
        .then((value) {
      emit(SuccessfullyUpdateUserState());
    }).catchError((error) {
      emit(ErrorUpdateUserState(error.toString()));
    });
  }

  List searchItems = [];

  Future searchClient({required String name}) async {
    searchItems = [];
    emit(LoadingSearchUserState());
    supaBase.from("User_data").select().ilike("name", "%$name%").then((value) {
      searchItems = value;
      emit(SuccessfullySearchUserState());
    }).catchError((error) {
      emit(ErrorSearchUserState(error.toString()));
    });
  }

  Future removeClient({required int id}) async {
    emit(LoadingRemoveUserState());
    await supaBase.from("User_data").delete().eq("id", id).then((value) {
      emit(SuccessfullyRemoveUserState());
    }).catchError((error) {
      emit(ErrorRemoveUserState(error.toString()));
    });
  }
}
