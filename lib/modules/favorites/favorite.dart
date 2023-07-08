import 'package:flutter/material.dart';
import '../../service/store.dart';
import '../Drawer/drawer.dart';
import '../My machines/my machine.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

var productName = 'Chipsy';
var productDetail = 'Cheese';
var i = 1;


class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => FavouritePageState();
}

class FavouritePageState extends State<FavouritePage> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // backgroundColor: Colors.red[700],

            title: const Text(
              'My app',
              style: TextStyle(
                // color: Colors.white,
                // fontSize: 41,
                // fontWeight: FontWeight.bold,
                // fontStyle: FontStyle.italic,
              ),
            ),
            centerTitle: true,
            // elevation: 0.0,
            toolbarHeight: 60.0,
            // titleSpacing: 20.0,

          ),
          drawer: Drawer(
            child: drawerview(),
          ),
          body: FutureBuilder<List<Map<dynamic, dynamic>>?>(
            future: store().getUserFavorite(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Failed to fetch machine data'));
              } else if (snapshot.hasData) {
                List<Map<dynamic, dynamic>> machineList = snapshot.data!;
                // // Filter machineList to get only the items with isfavorite = true
                // List<Map<dynamic, dynamic>> favoriteMachineList = machineList.where((machineData) => machineData['isfavorite'] == true).toList();
                //
                // if (favoriteMachineList.isEmpty) {
                //   return Center(child: Text('No favorite machines found'));
                // }

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                    itemCount: machineList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 400 / (1850 / 4),
                    ),
                    itemBuilder: (context, index) {
                      // Access individual machine data using index
                      Map<dynamic, dynamic> machineData = machineList[index];
                      String machineName = machineData['name'];
                      String machineDetails = machineData['details'];
                      String machineimage =machineData['image'] ;
                      String machinelocation =machineData['location'] ;
                      String machineId = machineData['id'];

                      // Retrieve other properties as needed

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyMachine(machineId: machineId,location:machinelocation)),
                          );

                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            height: 400,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: SizedBox(
                              height: 300,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // machines image
                                  Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                      border: Border.all(color: Colors.black),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'images/firstentry.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // listtile
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  machineName,
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              machineDetails,
                                              style: TextStyle(fontSize: 17, color: Colors.grey),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  // rating icons
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(child: Text('No machines found'));
              }
            }
          ),
        ));
  }
}
