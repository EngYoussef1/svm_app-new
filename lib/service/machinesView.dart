import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:svm_app/service/store.dart';
import 'package:svm_app/shared/cnstant/contant.dart';

import '../modules/My machines/my machine.dart';


class machines extends StatefulWidget {
   machines({Key? key}) : super(key: key);

  @override
  State<machines> createState() => _machinesState();
}

class _machinesState extends State<machines> {
   final Future<List<Map<dynamic, dynamic>>?> machine = store().getNewMachine();

   List<int> selectedItem = [];
   DatabaseReference cheackmachinefavorite(machineID){
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  DatabaseReference UserFavoriteRef = dprf.child('User_favorite') .child(userId!).child(machineID).child('isFavorite');
  return UserFavoriteRef;
}
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<dynamic, dynamic>>?>(
      future: machine,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to fetch machine data'));
        } else if (snapshot.hasData) {
          List<Map<dynamic, dynamic>> machineList = snapshot.data!;
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
                String machineIds =machineData['id'] ;
                bool isfavorite =machineData['isfavorite'];
                String machinelocation =machineData['location'] ;
                String machineimage =machineData['image'] ;
                // Retrieve other properties as needed

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyMachine(machineId: machineIds,location:machinelocation)),
                    );
                    print(machineData['id']);
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
                                  image: NetworkImage(
                                    machineimage,
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
                                          IconButton(
                                            onPressed: () {
                                              if (selectedItem.contains(index)) {
                                                selectedItem.remove(index);
                                                store().updateMachineValue(machineIds, {'isfavorite':false});
                                                store().removeFromUserFavorite(machineIds);
                                              } else {
                                                selectedItem.add(index);
                                                store().updateMachineValue(machineIds, {'isfavorite':true});
                                                store().creatUserFavorite(machineIds,{
                                                   'name' :machineName,
                                                  'details':machineDetails,
                                                  'location':machinelocation,
                                                  'image':machineimage,
                                                  'isFavorite':isfavorite
                                                });
                                              }
                                              setState(() {});
                                            },
                                            icon: Icon(selectedItem.contains(index)||isfavorite == true
                                                ? Icons.favorite
                                                : Icons.favorite_border),
                                            color: selectedItem.contains(index)||isfavorite == true  ? Colors.red : null,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        machineDetails,
                                        style: TextStyle(fontSize: 17,color:Colors.grey),
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
      },
    );

  }

   void toggleIconView(int index) {

   }
}
