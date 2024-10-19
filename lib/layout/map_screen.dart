import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hol_loc_app/model/place_model.dart';
import 'package:hol_loc_app/modyules/cubit/cubit.dart';
import 'package:hol_loc_app/modyules/cubit/state.dart';
import 'package:hol_loc_app/modyules/manage_holes/manage_holes_screen.dart';
import 'package:hol_loc_app/modyules/place_dialog/place_dialog.dart';
import 'package:hol_loc_app/shared/componants/componants.dart';
import 'package:hol_loc_app/shared/helpers/db_helper.dart';
import 'package:hol_loc_app/shared/helpers/location_helper.dart';
import 'package:vibration/vibration.dart';

class MapScreen extends StatefulWidget {
  MapScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double? latituded;
  double? longituded;

  @override
  initState() {
    super.initState();

    AppCubit.get(context)
        .getBytesFromAsset('assets/images/g7.png', 120)
        .then((onValue) {
      AppCubit.get(context).customIcon = BitmapDescriptor.fromBytes(onValue);
    });

    getMyCurrentLocation().then((pos) {
      AppCubit.get(context)
          .addMarker(pos.latitude, pos.longitude, 'currpos', 'You are here!');
      setState(() {
        latituded = pos.latitude;
        longituded = pos.longitude;
      });
      AppCubit.get(context).getDataFromDatabase();

      // setMyCurrentLocationData(pos);
    }).catchError((eror) {
      print(" ابنلتانتااااااا    $eror");
    });
    // AppCubit.get(context).getMarkers();

    // void  loadData(){
    //    for(int i=0;i<list.length;i++){
    //      markrsss.add(Marker(markerId: MarkerId(i.toString()),icon: BitmapDescriptor.defaultMarkerWithHue
    //        (BitmapDescriptor.hueRed)),);66666666666666
    //    }
    //  }
  }
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
  var distances = "0";
  double? distance;
  double? getDistance(lat, long) {
    final data = AppCubit.get(context).hols;
    AppCubit.get(context).hols.forEach((element) {
      distance =    calculateDistance(lat, long, element.lat, element.lon);/*Geolocator.distanceBetween(
          lat ?? 0.5, long ?? 0.2, element.lat, element.lon);*/
      if (distances != null) {
        if (double.parse(distances) < .01) {
          print('yes---------------------> $distance');
          Vibration.vibrate(duration: 100, amplitude: 128);
        } else {
          // distances = distance.toString();
          print('not---------------------> $distance');
        }
      }
    });


    setState(() {
      distances = distance != null ? distance!.toStringAsFixed(2) : "0";
    });
    return distance;
  }


  static Position? position;
  static Position? pose;
  Completer<GoogleMapController> _mapController = Completer();

// make sure to initialize before map loading

  // BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
  // 'assets/images/car-icon.png')
  //     .then((d) {
  // customIcon = d;
  // });

  // List<Marker> markers = [];

// var dbHelper =HolesDatabase.db;
//   List <PlacesModel?>  _placesModel =[];

  // DbHelper? helper;

  Future<Position> getMyCurrentLocation() async {
    await LocationHelper.determinePosition();
    // .getCurrentLocation();

    return position =
        await Geolocator.getCurrentPosition().whenComplete(() async {

      // StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      ).listen((Position? position) {
        getDistance(position?.latitude, position?.longitude);
        print(position == null
            ? 'Unknown'
            : '${position.latitude.toString()}, ${position.longitude.toString()}');
      });

      /*     Geolocator.getPositionStream().listen((Position? position) {
        getDistance(position?.latitude, position?.longitude);
      });*/
    });
  }

  static final CameraPosition myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    zoom: 17,
    tilt: 0.0,
  );
  GoogleMapController? _googleMapController;
  Widget buildMap() {
    getMyCurrentLocation();
    return GoogleMap(
        mapType: MapType.normal,
        markers: Set<Marker>.of(AppCubit.get(context).markers),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        initialCameraPosition: myCurrentLocationCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _mapController.complete(controller);

            /*          showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Column(
                      children: [
                        Text(markrsss.length.toString()),
                        Text(markrsss.toString()),
                      ],
                    ),
                  );
                });*/
          });
        });
  }


  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(myCurrentLocationCameraPosition));
  }

  // await helper.openDb();
  // // await helper.testDb();
  // List <Place> _places = await helper.getPlaces();
  // for (Place p in _places) {
  // addMarker(Position(latitude: p.lat, longitude: p.lon),
  // p.id.toString(), p.name) ;
  // }
  // setState(() {
  // markers = markers;
  // });}

  //  addMarker(double lat,double long, String markerId, String markerTitle )
  //  {
  //    // List <Marker>
  // final   marker =
  //    // [
  //      Marker(
  //        markerId: MarkerId(markerId),
  //    position: LatLng(lat, long),
  //  infoWindow: InfoWindow(title: markerTitle),
  //  icon: (markerId=='currpos') ?
  //  BitmapDescriptor.defaultMarkerWithHue
  //  (BitmapDescriptor.hueAzure):BitmapDescriptor
  //      .defaultMarkerWithHue(BitmapDescriptor
  //      .hueRed)
  //    )
  //    // ]
  //    ;
  // // addPlace(placesModeL(
  // //
  // // ));
  //    // addPlace(_placesModel
  //      // long:long,
  //      // lat:lat,
  //      // markerId:markerId,
  //      // markerTitle:markerTitle
  //
  //  //  );
  //    markers.add(marker);
  //    setState(() {
  //      markers = markers;
  //    });
  //  }
  ///insert new hole

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppInsertDatabaseState) {
          showToast(
              text:
                  ' قد تم اضافة عنوان الحفرة بنجاح ..شكرا لحسن تعاونكم مع المسؤلين لرفع مستوي سلامة الطرق',
              state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) => Scaffold(
        body: Stack(
          children: [
            position != null
                ? buildMap()
                : Center(
                    child: Container(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                  ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    distances.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  distances == null || distances == '0'
                      ? SizedBox()
                      : double.parse(distances) < .01 && distances != null
                          ? const Text(
                              "تحذير هناك حفره قريبة",
                              style: TextStyle(fontSize: 25, color: Colors.red),
                            )
                          : const SizedBox(),
                ],
              ),
            ),
            const Positioned(
              bottom: 180,
              right: 25,
              // left: 88,
              child: Text(
                'اضغط هنا لتحديد موقعك الحالي ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Positioned(
              bottom: 100,
              right: 25,
              // left: 88,
              child: Text(
                'اضغط هنا لاضافة حفرة ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //),
            ),
            Positioned(
              bottom: 130,
              right: 25,
              // left: 88,
              child: GestureDetector(
                  onTap: _goToMyCurrentLocation,
                  child: Icon(
                    Icons.place,
                    size: 50,
                    color: Colors.orange,
                  )),
              // Image(image: const AssetImage('assets/images/bottom2.png'),

              //),
            ),
          ],
//21.4369959,21.4369959
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
          child: FloatingActionButton(
            backgroundColor: Colors.orange,
            child: const Image(image: AssetImage('assets/images/b1.png')),
            onPressed: () {
              //           int here = AppCubit.get(context).markers.indexWhere((p)=> p.markerId ==
              //           MarkerId('currpos'));
              //         PlacesModel? place;
              //         if (here == -1) {
              //       //the current position is not available
              //       place = PlacesModel( '', 0, 0, '');
              //     }
              //     else {
              //
              // // Position? pos=pose;
              // //AppCubit.get(context).markers[here].position;
              // place = PlacesModel( '', pose!.latitude, pose!.longitude, '');
              // }
              //     PlaceDialog dialog = PlaceDialog(place, true);
              // showDialog(
              //     context: context,
              //     builder: (context) =>
              //         dialog.buildAlert(context));

              showDialog(
                  context: context,
                  builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: AlertDialog(
// contentTextStyle: ,
                          title: const SizedBox(
                            width: 30,
                            child: Text(
                              'اضافة مكان الحفرة',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text(
                                  'هذا يعتبر تعهد منك بأن مكان الحفرة الذي ادخلته صحيح وعدم صحة هذه المعلومات يعتبر مخالفة لقواعد وشروط وقد يعرضك لغرامة مالية كبيرة وان  كنت متاكد من معلوماتك اضغط علي زر الاضافة غير ذلك اضغط علي زر الغاء ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        var markersCount = AppCubit.get(context)
                                            .markers
                                            .length;
                                        print(
                                            "marker after load : $markersCount");

                                        int here = AppCubit.get(context)
                                            .markers
                                            .indexWhere((p) =>
                                                p.markerId ==
                                                MarkerId('currpos'));
                                        PlacesModel? place;
                                        if (here == -1) {
                                          //the current position is not available
                                          place = PlacesModel(0, '', 0, 0, '');
                                        } else {
                                          // LatLng pos = markers[here].position;

                                          // Position? pos=pose;
                                          LatLng pos = AppCubit.get(context)
                                              .markers[here]
                                              .position;
                                          place = PlacesModel(0, '',
                                              pos.latitude, pos.longitude, '');
                                        }
                                        PlaceDialog dialog =
                                            PlaceDialog(place, true);
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                dialog.buildAlert(context));
                                      },
                                      child: const Text('اضافة'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('الغاء'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
            },

            //           int here = AppCubit.get(context).markers.indexWhere((p)=> p.markerId ==
            //           MarkerId('currpos'));
            //         PlacesModel? place;
            //         if (here == -1) {
            //       //the current position is not available
            //       place = PlacesModel( '', 0, 0, '');
            //     }
            //     else {
            //
            // // Position? pos=pose;
            // //AppCubit.get(context).markers[here].position;
            // place = PlacesModel( '', pose!.latitude, pose!.longitude, '');
            // }
            //     PlaceDialog dialog = PlaceDialog(place, true);
            // showDialog(
            //     context: context,
            //     builder: (context) =>
            //         dialog.buildAlert(context));

            // AppCubit.get(context).insertToDatabase(PlacesModel(
            //    66, 'yaf',21.436032,39.270156, "bbbbbbbb"),
            //
            //   // name: "wala", lat: 12.0, lon: 12.0, image: "fh"
            // );

            //},
            //_goToMyCurrentLocation,
            //  child: Icon(Icons.place,color: Colors.blue,),
          ),
        ),
      ),
    );
  }

  // void setMyCurrentLocationData(Position pos) async {
  //   AppCubit.get(context).addMarker(pos.latitude,pos.longitude,'currpos', 'You are here!');
  //   await AppCubit.get(context).getDataFromDatabase();
  //   print( "${pos.latitude} ${pos.longitude}");
  //   for(Marker marker in AppCubit.get(context).markers){
  //     print( "getMyCurrentLocation length is :  ${marker.position}");
  //   }
  //
  //
  // }

}
