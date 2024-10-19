import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  double width=double.infinity;
      Color background ;
    final  Color textColor ;
  late double radius;
   Function? function;
  bool isUpperCase = true;
      late String text;
          CustomButton({
    required this.background,
            this.function,
             this.textColor=Colors.white,
            required this.isUpperCase,
            required this.radius,
            required this.text,
            required this.width,





  });
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      height: 50.00,
      child: MaterialButton(
        onPressed: () {
          function!();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: textColor),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      )
    );
  }
  
}
