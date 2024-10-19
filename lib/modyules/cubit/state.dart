import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class AppStates {}
class AppIntialState extends AppStates {}
class AppChangeBottomNavBarState extends AppStates {}
class AppCreateDatabaseState extends AppStates{}
class AppGetDatabaseState extends AppStates{}
//  ``  class AppGetDatabaseLoadingState extends AppStates{}

class AppInsertDatabaseState extends AppStates{}
class AppUpdateDatabaseState extends AppStates{}
class AppDeleteDatabaseState extends AppStates{}
class AppAddMarkersState extends AppStates{
  // final List  <Marker> addmarkers;

  // AppAddMarkersState( this.addmarkers);

}
class AppAddMultiMarkersState extends AppStates{
// final List  <Marker> newmarkers;

// AppAddMultiMarkersState(this.newmarkers);
}
class AppGetMyCurrentLocation extends AppStates{}
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