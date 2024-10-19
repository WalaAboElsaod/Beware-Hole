import 'package:flutter/material.dart';

class CostumFormField extends StatelessWidget {
   TextEditingController? controller;
  late TextInputType type;
  void Function(String)? onSubmit;
  final bool isPassword ;
  final Function onChange;
  final Function? onsaved;
  final Function? onTap;
   Function? suffixpressed;
  final Function? validate;
  late String label;
  IconData? prefix;
  IconData? suffix;
  Color? iconcolor;
  CostumFormField(
      {
     required this.onChange,
      this.onsaved,
         this.onTap,
          this.suffixpressed,
        required  this.validate,
        this.controller,
       required this.label,
       required this.type,
         this.isPassword=false,
        this.iconcolor,
        this.onSubmit,
        this.prefix,
     this.suffix,



      });

  @override
  Widget build(BuildContext context) {
    return


//
// Widget roundedFormField(
//         {required TextEditingController controller,
//         required TextInputType type,
//         Function? onSubmit,
//         bool isPassword = false,
//         Function? onChange,
//         Function? onTap,
//         Function? suffixpressed,
//         Function? validate,
//         required String label,
//         required IconData prefix,
//         IconData? suffix,
//         Color? iconcolor}) =>
    TextFormField(
      style: TextStyle(color: Colors.blue),
      controller: controller,
      keyboardType: type,
      onChanged: (value) {
        onChange(value);

      }, onSaved: (value) {

      },
      onFieldSubmitted: (value) {

      },
      validator: (value) {
        return validate!(value);
      },
      obscureText: isPassword,
      onTap: () {
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: iconcolor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixpressed!();
                },
                icon: Icon(
                  suffix,
                  color: iconcolor,
                ),
              )
            : null,
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blue, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),

      ),
    );
}
}
