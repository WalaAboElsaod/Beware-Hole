import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:hol_loc_app/model/place_model.dart';
import 'package:hol_loc_app/modyules/cubit/cubit.dart';
import 'package:hol_loc_app/modyules/cubit/state.dart';

class ManageHoles extends StatelessWidget {
  const ManageHoles({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var cubit=AppCubit.get(context);
    return Scaffold(

      body: BlocConsumer<AppCubit,AppStates>(

        listener: (context,state){},

        builder: (context,state){

          return       Conditional.single(context: context,
            conditionBuilder: (BuildContext context)=>cubit.newPlcesModel.isNotEmpty,
            widgetBuilder: (BuildContext context)=>ListView.separated(
              itemBuilder: (context,index){
                return buildTaskItem(cubit.newPlcesModel[index], context);

              },
              separatorBuilder: (context,index)=>Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 2.0,
                  color: Colors.grey[300],

                ),
              ),
              itemCount:cubit.newPlcesModel.length,
            ),
            fallbackBuilder: (context)=>Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.menu,
                    size: 100.0,
                    color: Colors.grey,

                  ),
                  Text(
                    'لا توجد حفرة مسجلة الي الان',
                    style:TextStyle(
                      fontSize:20 ,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,

                    ),

                  ),
                ],
              ),
            ),
          );

        },
      ),
    );
  }

  Widget buildTaskItem (PlacesModel model,context)=>Dismissible(
    key: Key(model.id.toString()),
    onDismissed: (direction){
      AppCubit.get(context).deleteData(id: model.id!,);

    },
    child:   Padding(

      padding: const EdgeInsets.all(20.0),

      child:
      Row(

        children: [

          const CircleAvatar(

            radius: 40.0,

            backgroundColor: Colors.yellow,

            child: Image(
              image: AssetImage('assets/images/h5.png'),
            )

          ),

          SizedBox(

            width: 20.0,

          ),

          Expanded(

            child: Column(

              // mainAxisSize: MainAxisSize.min,

              // crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
model.name
                  ,

                  style: TextStyle(

                    fontSize: 30.0,

                    fontWeight: FontWeight.bold,
                    color: Colors.black

                  ),

                ),

                // SizedBox(
                //
                //   height: 5.0,
                //
                // ),



                Text(

                  "${model.lon
                  }"


                    // +
                    //
                    //
                    // model.lat!.toString()
                  ,

                  style: TextStyle(



                    color: Colors.black,

                  ),

                ),

              ],

            ),

          ),

          SizedBox(

            width: 20.0,

          ),

          // IconButton(icon: Icon(Icons.check_box),
          //
          //     color: Colors.green,
          //
          //     onPressed: (){
          //
          //
          //
          //       // AppCubit.get(context).updateData(status: 'done',id: model['id']);
          //
          //
          //
          //
          //
          //     }),

          // IconButton(icon: Icon(Icons.archive),
          //
          //     color: Colors.black45,
          //
          //     onPressed: (){
          //
          //       AppCubit.get(context).updateData(status: 'archived', id: model['id']);
          //       // ubdateData(id: model['id'], status:'archived');
          //
          //
          //
          //     })



        ],

      ),

    ),
  );





  // return ListView.builder(
  // itemCount: helper.places.length,
  // itemBuilder: (BuildContext context, int index) {
  // return Dismissible(
  // key: Key(helper.places[index].name),
  // onDismissed: (direction) {
  // String strName = helper.places[index].name;
  // helper.deletePlace(helper.places[index]);
  // setState(() {
  // helper.places.removeAt(index);
  // });
  // Scaffold.of(context)
  //     .showSnackBar(SnackBar(content: Text("$strName
  // deleted")));
  // },
  // ));

  }
