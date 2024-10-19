
abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final String uId;

  RegisterSuccessState(this.uId);

}

class RegisterErrorsState extends RegisterState {
  final String error;

  RegisterErrorsState(this.error);
}
class CreateUserSuccessState extends RegisterState {

}

class CreateUserErrorsState extends RegisterState {
  final String error;

  CreateUserErrorsState(this.error);
}

class RegisterPasswordVisibilityState extends RegisterState {}
