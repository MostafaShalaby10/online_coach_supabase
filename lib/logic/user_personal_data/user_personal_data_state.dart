part of 'user_personal_data_cubit.dart';

sealed class UserPersonalDataState {}

final class UserPersonalDataInitial extends UserPersonalDataState {}

class LoadingAddPersonalDataState extends UserPersonalDataState {}

class SuccessfullyAddPersonalDataState extends UserPersonalDataState {}

class ErrorAddPersonalDataState extends UserPersonalDataState {
  final String error;

  ErrorAddPersonalDataState(this.error);
}

class LoadingGetPersonalDataState extends UserPersonalDataState {}

class SuccessfullyGetPersonalDataState extends UserPersonalDataState {}

class ErrorGetPersonalDataState extends UserPersonalDataState {
  final String error;

  ErrorGetPersonalDataState(this.error);
}
class LoadingClearPersonalDataState extends UserPersonalDataState {}

class SuccessfullyClearPersonalDataState extends UserPersonalDataState {}

class ErrorClearPersonalDataState extends UserPersonalDataState {
  final String error;

  ErrorClearPersonalDataState(this.error);
}