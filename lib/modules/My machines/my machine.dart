
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../service/product.dart';

class MyMachine extends StatefulWidget {
  const MyMachine({Key? key}) : super(key: key);

  @override
  State<MyMachine> createState() => _MyMachineState();
}

class _MyMachineState extends State<MyMachine> {
  final double latitude = 37.7749;
  final double longitude = -122.4194;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // width: double.infinity,
            height: 225,
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 16.0,
              ),
              markers: Set<Marker>.of([
                Marker(
                  markerId: MarkerId('myMarker'),
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(
                    title: 'My Marker',
                    snippet: 'This is my location',
                  ),
                ),
              ]),
            ),
          ),
          products()
        ],
      ),
    );
  }
}
