

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hol_loc_app/layout/map_screen.dart';
import 'package:hol_loc_app/modyules/auth/login/login%20_screen.dart';
import 'package:hol_loc_app/modyules/auth/register/cubit/register_cubit.dart';
import 'package:hol_loc_app/modyules/auth/register/cubit/register_states.dart';
import 'package:hol_loc_app/shared/network/local/cash_helper.dart';
import 'package:hol_loc_app/shared/styles/colors.dart';


import '../../../shared/componants/componants.dart';




class RegisterScreen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phonePasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    var size=MediaQuery.of(context).size;
    return Scaffold(
      body:  SingleChildScrollView(
        child:BlocProvider(create: (context)=>RegisterCubit(),
        child: BlocConsumer<RegisterCubit,RegisterState>(
            listener: (context,state){
              // if(
              // state is RegisterSuccessState
              // ){
              //   navigateAndFinish(context, MapScreen());
              // }


              if (state is RegisterErrorsState ) {
                showToast(text: state.error, state: ToastState.ERROR);
              }
              if(state is RegisterSuccessState){
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

                  Image(image: const AssetImage('assets/images/top1.png')),

                ),

                const Positioned(

                  top: 0,

                  left: 0,

                  child:

                  Image(image: AssetImage('assets/images/top2.png')),

                )

                ,

                const Positioned(

                  top: 0,

                  right: 0,

                  child:

                  Image(image: const AssetImage('assets/images/main.png')),

                )

                ,



                Positioned(

                  bottom: -20,

                  left: 0,

                  child:

                  Image(image: const AssetImage('assets/images/bb1.png')

                    , width: size.width * 1,



                  ),

                ),

                const Positioned(

                  bottom: 0,

                  left: 0,

                  child:

                  Image(image: const AssetImage('assets/images/bottom2.png')),

                ),

                Form(

                  key: formKey,



                  child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,

                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [





                        Row(



                            children:[

                              const Padding(padding: EdgeInsets.all(40)),



                              const Text(



                                'Sign Up',

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

                        SizedBox(height: 20,),



                        defaultFormField(


                          iconcolor: Colors.blue,



                          controller: nameController,

                          type: TextInputType.name,

                          validate: (String? value) {

                            if (value!.isEmpty) {

                              return (' Please enter your name address');

                            }

                          },



                          label: 'Name',



                          prefix: Icons.person,

                          onsaved: (value){

                            nameController.text = value;

                          },

                          // iconcolor: kPrimaryColor,

                          onSubmit: (String value) {

                            print(value);



                          },

                        ),defaultFormField(

                          // border:InputBorder

                          iconcolor: Colors.blue,



                          controller: emailController,

                          type: TextInputType.emailAddress,

                          validate: (String? value) {

                            if (value!.isEmpty) {

                              return (' Please enter your email address');

                            }

                          },



                          label: 'Email address',



                          prefix: Icons.email_outlined,

                          onsaved: (value){

                            emailController.text = value;

                          },

                          // iconcolor: kPrimaryColor,

                          onSubmit: (String value) {

                            print(value);



                          },

                        ),





                        defaultFormField(

                          iconcolor: Colors.blueAccent,


                          isPassword: true,

                          onsaved: (value){

                            passwordController.text = value;

                          },

                          controller: passwordController,

                          type: TextInputType.visiblePassword,

                          validate: (String? value) {

                            if (value!.isEmpty) {

                              return (' Please enter your password address');

                            }

                          },



                          label: 'Password',



                          prefix: Icons.lock,

                          // iconcolor: kPrimaryColor,

                          onSubmit: (String value) {

                            print(value);

                          },



                        ),defaultFormField(

                          iconcolor: Colors.blueAccent,


                          onsaved: (value){

                            phonePasswordController.text = value;

                          },

                          controller: phonePasswordController,

                          type: TextInputType.visiblePassword,

                          validate: (String? value) {

                            if (value!.isEmpty) {

                              return (' Please enter your phone');

                            }

                          },



                          label: 'Your Phone',



                          prefix: Icons.call,

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

                                style: TextStyle(

                                  // fontWeight: FontWeight.bold,

                                    fontSize: 15,

                                    color: Colors.blueAccent),





                              ),



                              onPressed: () {





                              }

                          ),

                        ),

                        // ),

                        defultButtonlog(function: (){

                          formKey.currentState!.save();

                          if(formKey.currentState!.validate()){
                            RegisterCubit.get(context).userSignUp(email:  emailController.text                       //     email: emailController.text, password: passwordController.text).then((value) {
                                , password:passwordController.text);
                            //
                            //
                            // FirebaseAuth.instance.createUserWithEmailAndPassword(
                            //
                            //     email: emailController.text, password: passwordController.text).then((value) {
                            //
                            //   print(value.user!.email);
                            //
                            //   print(value.user!.uid);
                            //
                            //
                            //
                            // }).catchError((erorr) {
                            //
                            //   print('erorrrrrrrrrr ${erorr}'
                            //   );
                            //
                            // });

                          }



                        }, text: 'Sign Up',radius: 10,),

                        Row(

                          children: [

                            const Padding(padding: const EdgeInsets.all(45)),



                            const Text('Do you have an account? ',style: TextStyle(

                                fontWeight: FontWeight.normal,

                                fontSize: 15

                            ),),



                            GestureDetector(

                                onTap: (){

                                  navigateTo(context, LoginScreen());

                                },

                                child:const Text('Log in'

                                  ,

                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: defultColor),

                                )

                            ),





                            // defultTextButton(function: (){

                            //

                            //   navigateTo(context, LoginScreen());

                            //

                            // }, text:'Login' ),

                            // //  ),



                          ],



                        ),

                        const SizedBox(height: 77),





                      ]



                  ),

                ),











              ],



            ),





            //  ],

          ),
            ),
        )




                ),



    );


  }
}
