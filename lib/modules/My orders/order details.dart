
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../service/store.dart';

class Orderdetails extends StatelessWidget {
  final String machineId;
  final String machineName;
 Orderdetails({required this.machineId, required this.machineName,}) ;
  String? Id = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon:Icon(Icons.arrow_back),),

        primary: true,

        title: Text('Order details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Order details
            FutureBuilder<List<Map<dynamic, dynamic>>?>(
              future: store().getUsreOrder(machineId, Id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Map<dynamic, dynamic>>? products = snapshot.data;
                  int totalPrice = 0;
                  if (products != null) {
                    return Column(
                      children: [
                        Container(
                          height: 600,
                          child: ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                Map<dynamic, dynamic> productsData = products[index];
                                int productdate = productsData['timestamp'];
                                String productID = productsData['id'];
                                return  Padding(
                                  padding: const EdgeInsets.only(top: 40,left:20,right: 20),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(35)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          //machine name
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text(machineName,style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold)),
                                          ),
                                          SizedBox(height: 15,),
                                          //Order ID
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${DateTime.fromMillisecondsSinceEpoch(productdate)}',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),)
                                          ),
                                          //Date
                                          SizedBox(height: 20,),
                                          FutureBuilder<List<Map<dynamic, dynamic>>?>(
                                            future: store().getUsreProductOrder(machineId, Id,productID),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                List<Map<dynamic, dynamic>>? products = snapshot.data;
                                                int totalPrice = 0;
                                                if (products != null) {
                                                  for (Map<dynamic, dynamic> product in products) {
                                                    int productPrice = product['price'] ?? 0;
                                                    int productAmount = product['amount'] ?? 0;
                                                    totalPrice += productPrice * productAmount;
                                                  }
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        height: 150,
                                                        child: ListView.builder(
                                                            itemCount: products.length,
                                                            itemBuilder: (context, index) {
                                                              Map<dynamic, dynamic> productsData =
                                                              products[index];
                                                              String productsName = productsData['name'];
                                                              String productsDetails = productsData['details'];
                                                              int productsamount = productsData['amount'];
                                                              int productsprice = productsData['price'];

                                                              return Column(
                                                                children: [
                                                                  ListTile(
                                                                    title: Text(
                                                                      productsName,
                                                                      style: TextStyle(
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.bold),
                                                                    ),
                                                                    subtitle: Text(
                                                                      productsDetails,
                                                                      style: TextStyle(fontSize: 20),
                                                                    ),
                                                                    trailing: Text(
                                                                      '\$${productsprice} * ${productsamount}',
                                                                      style: TextStyle(
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 10,),

                                                                ],
                                                              );
                                                            }),

                                                      ),

                                                      Container(
                                                        height: 100,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(
                                                                  horizontal: 10),
                                                              child: Divider(
                                                                thickness: 1,
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(
                                                                  horizontal: 15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text("Total:",
                                                                      style: TextStyle(
                                                                          fontSize: 25,
                                                                          fontWeight: FontWeight.bold)),
                                                                  Text("\$${totalPrice}",
                                                                      style: TextStyle(
                                                                          fontSize: 25,
                                                                          fontWeight: FontWeight.bold))
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                } else {
                                                  return Center(
                                                    child: Text('No products available'),
                                                  );
                                                }
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                  child: Text('Error loading products'),
                                                );
                                              } else {
                                                return Center(
                                                  child: CircularProgressIndicator(),
                                                  // child: Text('cart is empty'),
                                                );
                                              }
                                            },
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                );;
                              }),
                        ),

                      ],
                    );
                  } else {
                    return Center(
                      child: Text('No products available'),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading products'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                    // child: Text('cart is empty'),
                  );
                }
              },
            ),
            SizedBox(height: 30,),
            MaterialButton(onPressed: (){},
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
                  child: Center(child: Text("Buy Again",style: TextStyle(fontSize:30,color: Colors.white  )))
              ),
            ),

          ],
        ),
      ),
    );
  }
}
