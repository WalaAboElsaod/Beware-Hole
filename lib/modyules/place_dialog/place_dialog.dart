import 'package:flutter/material.dart';
import 'package:hol_loc_app/model/place_model.dart';
import 'package:hol_loc_app/modyules/cubit/cubit.dart';
class PlaceDialog{
  PlaceDialog(this.place, this.isNew);

// class PlaceDialog extends StatelessWidget {
  final txtName = TextEditingController();
  final txtLat = TextEditingController();
  final txtLon = TextEditingController();
  final txtType = TextEditingController();
   bool? isNew;
 late  PlacesModel place;

  // @override
  // Widget build(BuildContext context) {
  //   return Container();
  // }


  Widget buildAlert(BuildContext context) {

    txtName.text = place.name;
    txtLat.text = place.lat.toString();
    txtLon.text = place.lon.toString();
    return
      Directionality(
        textDirection: TextDirection.rtl,

        child: AlertDialog(
        title: const Text("اضافة مكان الحفرة",),


          content: SingleChildScrollView(
            child: Column(children: <Widget>[
              TextField(
                controller: txtName,
                decoration: const InputDecoration(
                    hintText: '  نوع الحفرة(حفرة,بئر) ووصف لها'
                ),
              ),
              // TextField(
              //   controller: txtType,
              //   decoration: const InputDecoration(
              //       hintText: 'وصف الحفرة'
              //   ),
              // ),
              TextField(
                controller: txtLat,
                decoration: const InputDecoration(
                    hintText: 'Latitude'
                ),
              ),
              TextField(
                controller: txtLon,
                decoration: InputDecoration(
                    hintText: 'Longitude'
                ),
              ),
    RaisedButton(
    child: const Text('OK'),
    onPressed: () {
        AppCubit.get(context).insertToDatabase(place);

        place.name = txtName.text;
        place.lat = double.tryParse(txtLat.text)!;
        place.lon = double.tryParse(txtLon.text)!;

        Navigator.pop(context);


    }
    ),


    ]),

          )

    ),
      );

  }


}
