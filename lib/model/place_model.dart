


import 'package:hive/hive.dart';
import 'package:hol_loc_app/shared/constants/constants.dart';



class PlacesModel{



 late double lat;
 late double lon;
  int? id;
 late String name;

  String? image;

  PlacesModel(
      this.id,
      this.name, this.lat, this.lon, this.image);



  PlacesModel.fromMap(Map <dynamic,dynamic> map)
  {
    if (map == null){
      return;
    }
    name=map[columnName];
    id=map[columnId];
    image=map[columnImage];
    lat=map[columnLat];
    lon=map[columnLon];
  }

  Map<String, dynamic> toMap() {
    return {
     columnId: (id==0)?null:id,
     columnName: name,
      columnLat: lat,
      columnLon: lon,
      columnImage: image

    };
  }
}