part of 'authentication_cubit.dart';


 class AUTHState {}

final class LoginInitial extends AUTHState {}


final class LoadingLoginState extends AUTHState {}
final class SuccessfullyLoginState extends AUTHState {}
final class ErrorLoginState extends AUTHState {
  final String error ;
  ErrorLoginState(this.error);
}


final class LoadingUpdateUserPasswordData extends AUTHState{}
final class SuccessfulUpdateUserPasswordData extends AUTHState{}
final class ErrorUpdateUserPasswordData extends AUTHState{
  final String error;
  ErrorUpdateUserPasswordData(this.error);
}


final class LoadingGetSpecificUsersState extends AUTHState {}
final class SuccessfullyGetSpecificUsersState extends AUTHState {}
final class ErrorGetSpecificUsersState extends AUTHState {
  final String error ;
  ErrorGetSpecificUsersState(this.error);
}


final class SuccessfullyCheckConnection extends AUTHState {}
