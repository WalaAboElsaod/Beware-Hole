import 'package:flutter/material.dart';
import 'package:hol_loc_app/shared/widgets/custom_text.dart';

class CostumFormFieldCheck extends StatelessWidget {

  late String text;
  final Function? onsaved;
  final String? hint;
  final Function? validate;
  CostumFormFieldCheck(
      {
        required this.hint,
        required this.text,
        required this.validate,
        this.onsaved,



      });

  @override
  Widget build(BuildContext context) {
    return


      Container(
        child:Column(
          children: [
            CustomText(text: text, fontsize: 14,
            color: Colors.black,
            ),
            SizedBox(height: 10),
            TextFormField(
              style: TextStyle(color: Colors.black),
              onSaved: (value) {
                return onsaved!(value);

              },

              validator: (value) {
                return validate!(value);
              },

              decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: EdgeInsets.only(left: 20),
                  hintStyle:  TextStyle(color: Colors.grey),


                  fillColor: Colors.white,
                // focusedBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(30),
                //   borderSide: BorderSide(color: Colors.deepOrange, width: 0),
                ),
              ),


          //  ),
          ],
        ),
      );
  }
}
