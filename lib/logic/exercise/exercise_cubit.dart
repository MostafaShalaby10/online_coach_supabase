import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/exercise_model.dart';
import '../../shared/constants/constants.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit() : super(ExerciseInitial());

  static ExerciseCubit get(context) => BlocProvider.of(context);

  ExerciseModel? exerciseModel;

  void addExerciseCubit({
    required int userId,
    required String day,
    required String label,
    required String link,
    required int reps,
    required int sets,
  }) async {
    emit(LoadingAddExerciseState());
    exerciseModel = ExerciseModel(
        label: label,
        link: link,
        reps: reps,
        sets: sets,
        userId: userId,
        day: day);
    await supaBase
        .from("Exercise")
        .insert(exerciseModel!.toMap())
        .then((value) {
      emit(SuccessfullyAddExerciseState());
    }).catchError((error) {
      emit(ErrorAddExerciseState(error.toString()));
    });
  }

  List<dynamic> exerciseData = [];

  Future? getExerciseCubit({
    required int userId,
    required String day,
  }) async {
    emit(LoadingGetExerciseState());
    exerciseData = [];
    await supaBase
        .from("Exercise")
        .select()
        .eq("user_id", userId)
        .eq("day", day)
        .then((value) {
      exerciseData = value;
      emit(SuccessfullyGetExerciseState());
    }).catchError((error) {
      emit(ErrorGetExerciseState(error.toString()));
    });
  }

  void deleteExercise({required int id}) {
    emit(LoadingDeleteExerciseState());
    supaBase.from("Exercise").delete().eq("id", id).then((value) {
      emit(SuccessfullyDeleteExerciseState());
    }).catchError((error) {
      emit(ErrorDeleteExerciseState(error.toString()));
    });
  }
}
