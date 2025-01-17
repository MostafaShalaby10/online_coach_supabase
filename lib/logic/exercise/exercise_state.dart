part of 'exercise_cubit.dart';

sealed class ExerciseState {}

final class ExerciseInitial extends ExerciseState {}

final class LoadingAddExerciseState extends ExerciseState {}
final class SuccessfullyAddExerciseState extends ExerciseState {}
final class ErrorAddExerciseState extends ExerciseState {
  final String error ;
  ErrorAddExerciseState(this.error);
}

final class LoadingGetExerciseState extends ExerciseState {}
final class SuccessfullyGetExerciseState extends ExerciseState {}
final class ErrorGetExerciseState extends ExerciseState {
  final String error ;
  ErrorGetExerciseState(this.error);
}


final class LoadingDeleteExerciseState extends ExerciseState {}
final class SuccessfullyDeleteExerciseState extends ExerciseState {}
final class ErrorDeleteExerciseState extends ExerciseState {
  final String error ;
  ErrorDeleteExerciseState(this.error);
}
