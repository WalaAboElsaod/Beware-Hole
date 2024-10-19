import 'dart:typed_data';

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hol_loc_app/model/place_model.dart';
import 'package:hol_loc_app/modyules/cubit/state.dart';
import 'package:hol_loc_app/shared/constants/constants.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState()) {}

  static AppCubit get(context) => BlocProvider.of(context);
  Database? database;

  List<PlacesModel> newPlcesModel = [];

  List<Map> newPlaces = [];

  List<Marker> markers = [];

  late BitmapDescriptor customIcon;

  void createDatabase() {
    openDatabase(
      'maap.db',
      version: 1,
      onCreate: (database, version) {
        print('database is created');
        database
            .execute(
                'CREATE TABLE $tableHolesPlace ( $columnId INTEGER PRIMARY KEY,$columnName TEXT, $columnLat Double,  $columnLon Double, $columnImage TEXT)')
            .then((value) {
          print(' table created');
        }).catchError((error) {
          print('ERROR WHEN CREATING  TABLE ${error.toString()}');
        });
      },
      onOpen: (database) {
        // getDataFromDatabase(database)

        ;
        print('    شطاااااااا   database is opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase(PlacesModel model) async {
    await database!.insert(tableHolesPlace, model.toMap()).then((value) {
      print('$value inserted  successfully');
      emit(AppInsertDatabaseState());
      int id = value;
      getDataFromDatabase();
      print(newPlaces.length);
    }).catchError((error) {
      print('ERROR indsssssssssert ${error.toString()}');
    });
    // });
  }

  List hols = [];
  // Future<List<PlacesModel?>>
  Future<void> getDataFromDatabase() async {
    var value = await database?.query(tableHolesPlace);
    newPlaces = value ?? [];

    int here = markers.indexWhere((p) => p.markerId == MarkerId('currpos'));

    markers = [markers[here]];
    newPlcesModel = newPlaces.isNotEmpty
        ? newPlaces.map((holeplace) => PlacesModel.fromMap(holeplace)).toList()
        : [];
    emit(AppGetDatabaseState());
    for (PlacesModel p in newPlcesModel) {
      addMarker(p.lat, p.lon, p.id!.toString(), p.name);
    }
    markers = markers;
    hols = newPlcesModel;

    emit(AppAddMultiMarkersState());
  }

  // addPlace( PlacesModel placesModeL)async{
  //   var dbHelper=HolesDatabase.db;
  //   await dbHelper.insertPlaces(placesModeL);
  //   emit(AppAddPlaces());
  //
  // }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // void customMarker() {
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration(),'assets/images/b1.png').
  //   then((value) => {
  //     customIcon = value
  //   });
  // }
  addMarker(double lat, double long, String markerId, String markerTitle) {
    // markers =[];
    // List <Marker>
    final List<Marker> marker = [
      Marker(
          markerId: MarkerId(markerId),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(title: markerTitle),
          // onTap: (){
          //   print(" markerTitle : $markerId");
          //   markers.remove(markers.firstWhere((Marker marker) => marker.markerId.value == markerId));
          //   emit(AppAddMarkersState());
          // },
          icon: (markerId == 'currpos')
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
              : customIcon
          // BitmapDescriptor
          //     .defaultMarkerWithHue(BitmapDescriptor
          //     .hueRed)
          )
    ];

    markers.addAll(marker);

    markers = markers;
    print("markers.length  : ${markers.length}");
    print("markers  : $markers");
    emit(AppAddMarkersState());
    // setState(() {
    //   markers = markers;
    // });
  }

  void deleteData({
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM $tableHolesPlace WHERE id = ?', [id]).then(
        (value) {
      print("للا$value");
      getDataFromDatabase();
      emit(AppDeleteDatabaseState());
    });
  }

// Future  getMarkers()async{
//   List <PlacesModel> places =await getDataFromDatabase();
//   for (PlacesModel p in places ) {
//
//
//     addMarker(p.lat,  p.lon,
//
//         p.id!.toString()
//         , p.name!) ;
//   }
//   markers = markers;
//
//   emit(AppAddMultiMarkersState());
// }

}
