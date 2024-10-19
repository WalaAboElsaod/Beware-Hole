import 'package:flutter/material.dart';

class CustomButtonFAndG extends StatelessWidget {
 final double width;
    final  double height;
 final Color background;
  final double radius;
      final Function function;
      bool isUpperCase = true;
  final String text;
  IconData? icon;
  CustomButtonFAndG({
required this.background,
    this.icon,
 required this.width,
  required  this.height,
   required this.radius,
   required this.function,
   required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Row(
            children:[
              Icon(icon,color: Colors.white,),
              SizedBox(width: 5,),


              Text(
                text,
                style: TextStyle(color: Colors.white,fontSize: 15),
              ),
              SizedBox(
                width: 5,
              ),
            ]
        ),



      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

  }
}
