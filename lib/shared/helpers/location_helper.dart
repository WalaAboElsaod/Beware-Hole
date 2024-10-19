import 'package:geolocator/geolocator.dart';

class LocationHelper{
 static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location login_cubit are disabled.');
    }

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }


    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    return await Geolocator.getCurrentPosition();
  }
  // static Future<Position>  getCurrentLocation() async{
  //     bool isLocationServiceEnabled = await  Geolocator.isLocationServiceEnabled();
  //     if(  !isLocationServiceEnabled){
  //       await Geolocator.requestPermission();
  //
  //     }
  //        return Geolocator.getCurrentPosition(
  //          desiredAccuracy: LocationAccuracy.high
  //        );
  // }



}