// import 'package:hol_loc_app/model/place_model.dart';
// import 'package:hol_loc_app/shared/constants/constants.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
//
// class DbHelper{
//   final int version = 1;
//   Database? db;
//   List<PlacesModel> places = [];
//
//   Future<Database?> openDb() async {
//     db ??= await openDatabase(join(await getDatabasesPath(),
//           'mapp.db'),
//           onCreate: (database, version) async {
//             await    database.execute(
//                           'CREATE TABLE $tableHolesPlace ( $columnId INTEGER PRIMARY KEY,$columnName TEXT, $columnLat DOUBLE ,$columnLon DOUBLE,  $columnImage TEXT)');
//
//                 }, version: version);
//     print('ننننجاااح');
//
//     print(db!.path);
//
//     return db;
//
//   }
//
//
//   static final DbHelper _dbHelper = DbHelper._internal();
//   DbHelper._internal();
//   factory DbHelper() {
//     return _dbHelper;
//   }
//
//   Future insertMockData() async {
//     db = await openDb();
//     await db!.execute('INSERT INTO $tableHolesPlace VALUES(2,"Best Pizza in the world", 21.437114,39.270609, "")'
//
//
//     );
//     // await db!.execute('INSERT INTO $tableHolesPlace VALUES(3, "Best Pizza in the world",  41.9349061, 12.5339831, "")'
//
//
//     // );
//
//     List placesHoles = await db!.rawQuery('select * from $tableHolesPlace');
//     print(      "اهووووووه التابل      $placesHoles[0].toString()");
//
//   }
//
//
//   Future<List<PlacesModel>> getPlaces() async {
//     // final List<Map<String, dynamic>>
//     List<Map>    maps = await
//     db!.query('$tableHolesPlace');
//     this.places=
//     // List<PlacesModel> list= maps.map((plce)=>PlacesModel.fromJson(plce).toList();
//       //  List list =
//         maps.isNotEmpty
//         ? maps.map((placess) =>  PlacesModel.fromMap(placess)).toList()
//         : [];
//
//     //     maps.length, (i) {
//     //   return Place(
//     //     maps[i]['id'],
//     //     maps[i]['name'],
//     //     maps[i]['lat'],
//     //     maps[i]['lon'],
//     //     maps[i]['image'],
//     //   );
//     // });
//     return places;
//   }
//
//
// }