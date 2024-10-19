import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hol_loc_app/layout/map_screen.dart';
import 'package:hol_loc_app/model/place_model.dart';
import 'package:hol_loc_app/modyules/auth/login/login%20_screen.dart';
import 'package:hol_loc_app/modyules/auth/register/register_screen.dart';
import 'package:hol_loc_app/modyules/cubit/cubit.dart';
import 'package:hol_loc_app/shared/bloc_observer.dart';
import 'package:hol_loc_app/shared/network/local/cash_helper.dart';
// Import the generated file
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  Widget widget;

  await CashHelper.init();
  var uId = CashHelper.getData(key: 'uId');
  if (uId != null) {
    widget = MapScreen();
  } else {
    widget = LoginScreen();
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  late Widget startWidget;
  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'BeWareHole',

  home:             startWidget,
   //     home: Home(),
      ),
    );
  }
}


