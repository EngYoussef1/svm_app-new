
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:svm_app/service/store.dart';
import '../../models/productClass.dart';
import '../../service/product.dart';
import '../../shared/cnstant/contant.dart';
import '../My cart/my cart.dart';

class MyMachine extends StatelessWidget {
  final String machineId;
   MyMachine({ required this.machineId}) ;

  final double latitude = 37.7749;

  final double longitude = -122.4194;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         // store().updateMachineValue(machineId, {'isfavorite':false});
        },
        child: Icon(Icons.done),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon:Icon(Icons.arrow_back),),

        primary: true,

        title: Text('My Machine',style:  TextStyle(fontSize: 40),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 225,
              margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              image: DecorationImage(
                image: AssetImage(
                  'images/map.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Container(
          //   // width: double.infinity,
          //   height: 225,
          //   margin: EdgeInsets.all(15),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.black),
          //   ),
          //   child: GoogleMap(
          //     initialCameraPosition: CameraPosition(
          //       target: LatLng(latitude, longitude),
          //       zoom: 16.0,
          //     ),
          //     markers: Set<Marker>.of([
          //       Marker(
          //         markerId: MarkerId('myMarker'),
          //         position: LatLng(latitude, longitude),
          //         infoWindow: InfoWindow(
          //           title: 'My Marker',
          //           snippet: 'This is my location',
          //         ),
          //       ),
          //     ]),
          //   ),
          // ),
          products(machineId: machineId),
          // FloatingActionButton(
          //
          //   onPressed:(){},
          //   child: Icon(Icons.add),
          //
          // )

        ],
      ),

    );
  }
}
