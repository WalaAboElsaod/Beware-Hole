






import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hol_loc_app/modyules/auth/login/login_cubit/login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(    "fffffffffff  $value.user!.email");
      print(value.user!.uid);

      emit(LoginSuccessState(value.user!.uid));
    })
        .catchError((eror){
          print(eror);
      emit(LoginErrorsState(eror.toString()));
    });

  }
}











