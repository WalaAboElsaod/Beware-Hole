





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hol_loc_app/modyules/auth/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userSignUp({

    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(    "fffffffffff  $value.user!.email");
      print(value.user!.uid);

      emit(RegisterSuccessState(value.user!.uid));
    })
        .catchError((eror){
      print(eror);
      emit(RegisterErrorsState(eror.toString()));
    });

    // bool ispassword = true;
    // IconData suffix = Icons.visibility;
    // // ignore: non_constant_identifier_names
    // void ChangePasswordVisibility() {
    //   ispassword = !ispassword;
    //
    //   suffix = ispassword ? Icons.visibility : Icons.visibility_off_outlined;
    //   emit(SocialLoginPasswordVisibilityState());
    // }
  }
}
























//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hol_loc_app/modyules/auth/register/cubit/register_states.dart';
//
//
// class RegisterCubit extends Cubit<RegisterState> {
//   RegisterCubit() : super(RegisterInitialState());
//   static RegisterCubit get(context) => BlocProvider.of(context);
//
//
//   // late String email;
//   // late String password;
//   // late String name;
//   // late String phone;flutterfire configure
//
//   void userRegister(
//   {
//     required String email,
//     required  String password,
//     required  String name,
//     required  String phone,
// }
//       ) {
//     print('hello');
//     emit(RegisterLoadingState());
//     FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email, password: password).then((value) {
//       print(value.user!.email);
//       print(value.user!.uid);
//       emit(RegisterSuccessState());
//       // createUser(
//       //   email: email,
//       //   uId: value.user!.uid,
//       //   phone: phone,
//       //   name: name,
//       //
//       //
//       // );
//     }).catchError((erorr) {
//       print('erorrrrrrrrrr ${erorr}');
//       emit(RegisterErrorsState(erorr.toString()));
//     });
//   }
//
//   // void createUser({
//   //   required String email,
//   //   required String name,
//   //   required String phone,
//   //   required String uId,
//   //
//   // }) {
//     //   SocialUserModel model=SocialUserModel(
//     //     name: name,
//     //     email: email,
//     //     phone: phone,
//     //     uId: uId,
//     //     bio: 'write your bio ....',
//     //     image:'https://image.freepik.com/free-photo/smiling-girl-making-peace-gesture-with-painted-fingers-face-against-white-brick-wall_23-2148088490.jpg' ,
//     //     cover:'https://image.freepik.com/free-photo/smiling-girl-making-peace-gesture-with-painted-fingers-face-against-white-brick-wall_23-2148088490.jpg' ,
//     //     isEmailVerified:false,
//     //
//     //
//     //   );
//     //   FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
//     //     emit(SocialCreateUserSuccessState());
//     //   }).catchError((error){
//     //     print('erorr ${error}');
//     //
//     //     emit(SocialCreateUserErrorsState(error.toString()));
//     //
//     //   });
//     //
//     // }
//
//     // bool ispassword = true;
//     // IconData suffix = Icons.visibility;
//     // ignore: non_constant_identifier_names
//     // void ChangePasswordRegisterVisibility() {
//     //   ispassword = !ispassword;
//     //
//     //   suffix = ispassword ? Icons.visibility : Icons.visibility_off_outlined;
//     //   emit(SocialRegisterPasswordVisibilityState());
//     // }
//   }
// //}