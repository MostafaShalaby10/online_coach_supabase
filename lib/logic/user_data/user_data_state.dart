part of 'user_data_cubit.dart';

class UserDataState {}

final class UserDataInitial extends UserDataState {}


final class LoadingAddUserState extends UserDataState {}
final class SuccessfullyAddUserState extends UserDataState {}
final class ErrorAddUserState extends UserDataState {
  final String error ;
  ErrorAddUserState(this.error);
}

final class LoadingGetUsersState extends UserDataState {}
final class SuccessfullyGetUsersState extends UserDataState {}
final class ErrorGetUsersState extends UserDataState {
  final String error ;
  ErrorGetUsersState(this.error);
}

final class LoadingGetSpecificUsersState extends UserDataState {}
final class SuccessfullyGetSpecificUsersState extends UserDataState {}
final class ErrorGetSpecificUsersState extends UserDataState {
  final String error ;
  ErrorGetSpecificUsersState(this.error);
}

final class LoadingUpdateUserState extends UserDataState {}
final class SuccessfullyUpdateUserState extends UserDataState {}
final class ErrorUpdateUserState extends UserDataState {
  final String error ;
  ErrorUpdateUserState(this.error);
}


final class LoadingUserSignUpState extends UserDataState {}
final class SuccessfullyUserSignUpState extends UserDataState {}
final class ErrorUserSignUpState extends UserDataState {
  final String error ;
  ErrorUserSignUpState(this.error);
}

final class LoadingSearchUserState extends UserDataState {}
final class SuccessfullySearchUserState extends UserDataState {}
final class ErrorSearchUserState extends UserDataState {
  final String error ;
  ErrorSearchUserState(this.error);
}
final class LoadingRemoveUserState extends UserDataState {}
final class SuccessfullyRemoveUserState extends UserDataState {}
final class ErrorRemoveUserState extends UserDataState {
  final String error ;
  ErrorRemoveUserState(this.error);
}