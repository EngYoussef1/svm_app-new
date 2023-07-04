import 'package:flutter/material.dart';

import '../../service/store.dart';
import '../Drawer/drawer.dart';
import '../My cart/my cart.dart';
import 'order details.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final Future<List<Map<dynamic, dynamic>>?> machines = store().getNewMachine();
  List products=[
    'agezy',
    'segar',
    'albahr',

  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon:Icon(Icons.arrow_back),),
        primary: true,


        title: Text('My Orders'),
        centerTitle: true,
      ),
      // drawer: Drawer(
      //   child: drawerview(),
      // ),
      body: FutureBuilder<List<Map<dynamic, dynamic>>?>(
        future: machines,
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
                  // Retrieve other properties as needed

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Orderdetails(machineId: machineIds,machineName:machineName)),
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
      ),
    );

  }
}