part of 'meal_cubit.dart';


sealed class MealState {}

final class MealInitial extends MealState {}

final class LoadingAddMealState extends MealState {}
final class SuccessfullyAddMealState extends MealState {}
final class ErrorAddMealState extends MealState {
  final String error ;
  ErrorAddMealState(this.error);
}

final class LoadingGetMealState extends MealState {}
final class SuccessfullyGetMealState extends MealState {}
final class ErrorGetMealState extends MealState {
  final String error ;
  ErrorGetMealState(this.error);
}

final class LoadingDeleteMealState extends MealState {}
final class SuccessfullyDeleteMealState extends MealState {}
final class ErrorDeleteMealState extends MealState {
  final String error ;
  ErrorDeleteMealState(this.error);
}
