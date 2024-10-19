
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hol_loc_app/layout/map_screen.dart';
import 'package:hol_loc_app/modyules/auth/login/login_cubit/login_cubit.dart';
import 'package:hol_loc_app/modyules/auth/login/login_cubit/login_states.dart';

import 'package:hol_loc_app/modyules/auth/register/register_screen.dart';
import 'package:hol_loc_app/shared/network/local/cash_helper.dart';

import '../../../shared/componants/componants.dart';
import '../../../shared/styles/colors.dart';



class LoginScreen extends StatelessWidget {
  @override


  var formKey= GlobalKey<FormState>();

  var emailContrller = TextEditingController();

  var passwordContrller = TextEditingController();


  bool stc=false;
  bool ispass=false;

  @override


  Widget build(BuildContext context) {


    var size=MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor:stc?  HexColor('333739'): Colors.white,
      body:  SingleChildScrollView(
        child: BlocProvider( create: (context)=>LoginCubit(),

          child: BlocConsumer<LoginCubit,LoginState>(
            listener: (context,state){
              if (state is LoginErrorsState) {
                showToast(text: state.error, state: ToastState.ERROR);
              }
              if(state is LoginSuccessState){
                CashHelper.saveData(
                  key: 'uId', value: state.uId,)
                    .then((value) {
                        print('user uid :${state.uId}');
                  navigateAndFinish(context, MapScreen());
                });

              }


            },
            builder: (context,state)=> Container(
              width: size.width,
              height: size.height,
              child:
              Stack(
                children: [
                  const Positioned(
                    top: 0,
                    left: 0,
                    child:
                    const Image(image: AssetImage('assets/images/top1.png')),
                  ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    child:
                    const Image(image: AssetImage('assets/images/top2.png')),
                  )
                  ,
                  const Positioned(
                    top: 0,
                    right: 0,
                    child:
                    const Image(image: AssetImage('assets/images/main.png')),
                  ),


                  Positioned(
                    bottom: -20,
                    left: 0,
                    child:
                    Image(image: const AssetImage('assets/images/bb1.png'),
                      width: size.width * 1,

                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    child:
                    Image(image: const AssetImage('assets/images/bottom2.png'),


                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [


                          Row(

                              children:const [
                                Padding(padding: EdgeInsets.all(60)),

                                Text(

                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35,
                                      color: Colors.blueAccent
                                  ),
                                ),
                              ]
                          ),
                          // SizedBox(
                          //   height: 280,
                          // ),

                          defaultFormField(
                            // border:InputBorder,
                            iconcolor: Colors.blue,
                            onsaved: (value){
                              emailContrller.text = value;
                            },
                            controller: emailContrller,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return (' Please enter your email address');
                              }
                              return null;
                            },


                            label: 'Email address',

                            prefix: Icons.email_outlined,

                            // iconcolor: kPrimaryColor,
                            onSubmit: (String value) {
                              print(value);

                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          defaultFormField(
                            iconcolor: Colors.blue,
                            // suffix:ispass? Icons.visibility:Icons.visibility_off,
                            // isPassword: ispass,
                            // suffixpressed: (){
                            //   // setState(() {
                            //   //   ispass=! ispass;
                            //   // });
                            // },

                            controller: passwordContrller,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return (' Please enter your password');
                              }
                              return null;
                            },

                            label: 'Password',
                            onsaved: (value){
                              passwordContrller.text = value;
                            },
                            prefix: Icons.lock,
                            // iconcolor: kPrimaryColor,
                            onSubmit: (String value) {
                              print(value);
                            },

                          ),
                          // Row(
                          //
                          //     children:[
                          //       Padding(padding: EdgeInsets.all(70)),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:

                            // defultTextButton(
                            //   function: (){},
                            //   text: 'Do you forget your password?',

                            TextButton(
                              child:const Text
                                ( 'Do you forget your password?',
                                style: const TextStyle(
                                  // fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.blueAccent),


                              ),

                              onPressed: (){},
                            ),
                          ),
                          // ),
                          defultButtonlog(function: (){
                            formKey.currentState!.save();

                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin
                                (
                                  email: emailContrller.text,
                                  password: passwordContrller.text);

                            }
                                 print('yesssssssssssssssss');
                          }

                              ,

                              text: 'Login',radius: 10),


                          Row(
                            children: [
                              const Padding(padding: EdgeInsets.all(45)),

                              const Text('Don\'t have an account? ',style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15
                              ),),


                              GestureDetector(
                                  onTap: (){
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child:const Text('Sign up'
                                    ,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: defultColor),
                                  )
                              ),


                            ],

                          ),
                          const SizedBox(height: 40),


                        ]

                    ),
                  ),





                ],

              ),


              //  ],
            ),
           
          ),
        ),



      ),
      // ),
    );


  }
}
