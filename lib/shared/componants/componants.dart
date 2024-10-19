import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:shop_app_app/modules/web_view/webview_screen.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 2.0,
        color: Colors.grey[300],
      ),
    );

// Widget buildArticalItem(article, context) => InkWell(
//       onTap: () {
//         navigateTo(
//           context,
//           WebViewScreen(article['url']),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Container(
//               width: 120.0,
//               height: 120.0,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 image: DecorationImage(
//                   image: NetworkImage('${article['urlToImage']}'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 20.0,
//             ),
//             Expanded(
//               child: Container(
//                 height: 120.0,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         '${article['title']}',
//                         style: Theme.of(context).textTheme.bodyText1,
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Text(
//                       '${article['publishedAt']}',
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

Widget defultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ));
//    Size size = MediaQuery.of(context).size;
Widget defultButtonlog({
  double width=double.infinity,
  Color background = Colors.orangeAccent,
 required double radius,
  required Function function,
  bool isUpperCase = true,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.00,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );
Widget defultButtonFandG({
  double width=double.infinity,
  double height=40,
  Color background = Colors.orangeAccent,
 required double radius,
  required Function function,
  bool isUpperCase = true,
  required String text,
  IconData? icon,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
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

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
           Function? onsaved,   Function(String)? onSubmit,


        bool isPassword = false,
        Function? onTap,
        Function? suffixpressed,
        Function? validate,
        required String label,
         IconData? prefix,
        IconData? suffix,
        Color? iconcolor}) =>
    TextFormField(
      style: TextStyle(color: Colors.orangeAccent),
      controller: controller,
      keyboardType: type,


      onSaved: (value) {
        return onsaved!(value);

      },

      obscureText: isPassword,
      // onTap: (value) {
      //   return onTap!(value) ;
      // },



      onFieldSubmitted: (value) {
return onSubmit!(value);
      },

      validator: (value) {
        return validate!(value);
      },
      // obscureText: isPassword,
      // onTap: () {
      //   onTap!();
      // },
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
        // labelText: label,
         // enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
         //   gapPadding: 4.0,
         // ),

        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.zero,
        //   // borderSide: BorderSide(color: Colors.deepOrange, width: 0
        //   ),

      ),
  //  ),
);
Widget roundedFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onSubmit,
        bool isPassword = false,
        Function? onChange,
        Function? onTap,
        Function? suffixpressed,
        Function? validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        Color? iconcolor}) =>
    TextFormField(
      style: TextStyle(color: Colors.blue),
      controller: controller,
      keyboardType: type,
      onChanged: (s) {
        onChange!(s);
      },
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      validator: (value) {
        return validate!(value);
      },
      obscureText: isPassword,
      onTap: () {
        onTap!();
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
            borderSide: BorderSide(color: Colors.blue,width: 1),

          ),
        ) ,
      );


// ignore: non_constant_identifier_names
void navigateTo(context, Widget, {isSearch}) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

// ignore: non_constant_identifier_names
void navigateAndFinish(
        context,
        // ignore: non_constant_identifier_names
        Widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Widget),
        (Route<dynamic> route) => false);

// Widget articleBuilder(list, context, {isSearch = false}) => Conditional.single(
//       context: context,
//       conditionBuilder: (BuildContext context) => list.length > 0,
//       widgetBuilder: (BuildContext context) => ListView.separated(
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) => buildArticalItem(list[index], context),
//         separatorBuilder: (context, index) => myDivider(),
//         itemCount: list.length,
//       ),
//       fallbackBuilder: (BuildContext context) =>
//           isSearch ? Container() : Center(child: CircularProgressIndicator()),
//     );

void showToast({required String text, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);
enum ToastState { SUCCESS, ERROR, WARNING }
Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.grey;
      break;
  }
  return color;
}

Widget containerField(color, child, {width}) => Container(
      height: 65,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: width,
      //* .8,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(29)),
      child: child,
    );
