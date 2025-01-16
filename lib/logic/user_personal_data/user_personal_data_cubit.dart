import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_coach_supabase/shared/constants/constants.dart';

part 'user_personal_data_state.dart';

class UserPersonalDataCubit extends Cubit<UserPersonalDataState> {
  UserPersonalDataCubit() : super(UserPersonalDataInitial());

  static UserPersonalDataCubit get(context) => BlocProvider.of(context);

  Future addPersonalData({required Map<String, dynamic> data}) async {
    emit(LoadingAddPersonalDataState());
    await supaBase.from("User_personal_data").insert(data).then((value) {
      emit(SuccessfullyAddPersonalDataState());
    }).catchError((error) {
      emit(ErrorAddPersonalDataState(error.toString()));
    });
  }

  List allPersonalData = [];

  Future getPersonalData({required int id}) async {
    allPersonalData = [];
    emit(LoadingGetPersonalDataState());
    supaBase
        .from("User_personal_data")
        .select()
        .eq("user_id", id)
        .then((value) {
      allPersonalData = value;
      emit(SuccessfullyGetPersonalDataState());
    }).catchError((error) {
      emit(ErrorGetPersonalDataState(error.toString()));
    });
  }

  Future clearPersonalData({required int id}) async {
    emit(LoadingClearPersonalDataState());
    await supaBase
        .from("User_personal_data")
        .delete()
        .eq("user_id", id)
        .then((value) {
      emit(SuccessfullyClearPersonalDataState());
    }).catchError((error){
      emit(ErrorClearPersonalDataState(error.toString()));
    });
  }
}
