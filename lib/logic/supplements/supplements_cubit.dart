import '../../model/supplements_model.dart';
import '../../shared/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'supplements_state.dart';

class SupplementsCubit extends Cubit<SupplementsState> {
  SupplementsCubit() : super(SupplementsInitial());

  static SupplementsCubit get(context) => BlocProvider.of(context);
  List<dynamic> supplementsData = [];

  Map<String, dynamic>? supplementsDataSingle = {};

  SupplementsModel? supplementsModel;

  void addSupplementsCubit({
    required int userId,
    required String times,
    required String supplementsName,
  }) async {
    emit(LoadingAddSupplementsState());
    supplementsModel = SupplementsModel(
        times: times, supplementsName: supplementsName, userId: userId);
    await supaBase
        .from("Supplements")
        .insert(supplementsModel!.toMap())
        .then((value) {
      emit(SuccessfullyAddSupplementsState());
    }).catchError((error) {
      emit(ErrorAddSupplementsState(error));
    });
  }

  Future getSupplementsCubit({
    required int userId,
  }) async {
    supplementsData = [];
    emit(LoadingGetSupplementsState());
    await supaBase
        .from("Supplements")
        .select()
        .eq("user_id", userId)
        .then((value) {
      supplementsData = value;
      emit(SuccessfullyGetSupplementsState());
    }).catchError((error) {
      emit(ErrorGetSupplementsState(error.toString()));
    });
  }


  void deleteSupplements({required int id}) {
    emit(LoadingDeleteSupplementsState());
    supaBase.from("Supplements").delete().eq("id", id).then((value) {
      emit(SuccessfullyDeleteSupplementsState());
    }).catchError((error) {
      emit(ErrorDeleteSupplementsState(error.toString()));
    });
  }
}
