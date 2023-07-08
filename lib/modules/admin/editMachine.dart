
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../service/auth.dart';
import '../../service/store.dart';

class editMachine extends StatelessWidget {
  final String machineId;
   editMachine({ required this.machineId}) ;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Future<List<Map<dynamic, dynamic>>?> machines = store().getNewMachine();


  String _name='',_image='',_details='',_location='';


  int _slots=0;

  TextEditingController namecontroller = TextEditingController();

  TextEditingController detailscontroller = TextEditingController();

  TextEditingController slotscontroller = TextEditingController();

  TextEditingController latitudecontroller = TextEditingController();

  TextEditingController longitudecontroller = TextEditingController();

  TextEditingController imagecontroller = TextEditingController();

  final _store = store();

chackupdatedvalue(){
  if(_name.isNotEmpty){
    _store.updateMachineValue(machineId, {'name': _name});
  }
  if(_details.isNotEmpty){

    _store.updateMachineValue(machineId,{ 'details': _details});
  }
  if(_slots!=0){

    _store.updateMachineValue(machineId,{ 'slots': _slots});
  }
  if(_location!=0){

    _store.updateMachineValue(machineId,{ 'location': _location});
  }

  if(_image.isNotEmpty){
    _store.updateMachineValue(machineId,{ 'image': _image});
  }
}

  var showpassword=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditMachine'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key:_globalKey ,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextFormField(
                  controller: namecontroller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'name must not be empty';
                  //   }
                  //
                  //   return null;
                  // },
                  onChanged: (value) {
                    print(value);
                    _name=value!;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: detailscontroller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'details',
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'details must not be empty';
                  //   }
                  //
                  //   return null;
                  // },
                  onChanged: (value) {
                    print(value);
                    _details=value!;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: slotscontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'slots',
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'slots must not be empty';
                  //   }
                  //
                  //   return null;
                  // },
                  onChanged: (value) {
                    print(value);
                    if (value.isNotEmpty) {
                      _slots = int.parse(value);
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: latitudecontroller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'location',
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'latitude must not be empty';
                  //   }
                  //
                  //   return null;
                  // },
                  onChanged: (value) {
                    print(value);
                    if (value.isNotEmpty) {
                      _location = value;
                    }
                  },
                ),


                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: imagecontroller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter image URL',
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'image URL must not be empty';
                  //   }
                  //   return null;
                  // },
                  onChanged: (value) {
                    print(value);
                    _image=value!;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () async {
                    chackupdatedvalue();

                  },
                  child: Container(
                      width: 270,
                      height: 67,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),


                        color: Colors.red[700],

                      ),
                      child: Center(child: Text("edit machine",style: TextStyle(fontSize:30,color: Colors.white )))
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // FutureBuilder<List<dynamic>>(
                //   future: store().getNewMachine(),
                //   builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return CircularProgressIndicator(); // Show a loading indicator while waiting for the data
                //     } else if (snapshot.hasError) {
                //       return Text('Error: ${snapshot.error}');
                //     } else {
                //       var name = snapshot.data![0];
                //       return Text(
                //         name ?? '',
                //         style: TextStyle(
                //           fontSize: 25,
                //           fontWeight: FontWeight.w500,
                //           color: Colors.white,
                //         ),
                //       ); // Display the retrieved name
                //     }
                //   },
                // ),

              ],
            ) ,
          ),
        ),
      ),
    );
  }
}
