import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/productClass.dart';

import '../../service/store.dart';
import '../../shared/cnstant/contant.dart';
import '../../shared/componant/counter_operations.dart';

import '../Drawer/drawer.dart';
import '../hold out/hold out.dart';

class MyCart extends StatefulWidget {
  final String machineId;
  const MyCart({ required this.machineId}) ;

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  String? Id =FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        primary: true,

        title: Text('My cart'),
        centerTitle: true,

      ),

      body: Stack(
        children: [
          FutureBuilder<List<Map<dynamic, dynamic>>?>(
            future: store().getCartInfo(widget.machineId,Id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Map<dynamic, dynamic>>? products = snapshot.data;
                if (products != null) {
                  return  ListView.builder(
                      itemCount:products.length ,
                      itemBuilder: (context,index){
                        Map<dynamic, dynamic> productsData = products[index];
                        String productsName = productsData['name'];
                        String productsDetails = productsData['details'];
                        int productsamount = productsData['amount'];
                        String productsimage = productsData['image'];
                        int productsprice = productsData['price'];
                        String productID =productsData['id'];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    //product image
                                    child: Container(
                                      width: 110,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(30)),

                                        // border: Border.all(color: Colors.black),
                                        image: DecorationImage(
                                          image: NetworkImage(productsimage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //name , close icon
                                      Container(
                                        margin: EdgeInsets.only(top: 15),
                                        height: 55,
                                        width: 200,
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 1),
                                          title: Text(productsName,style: TextStyle(fontSize: 25),),
                                          subtitle: Text(productsDetails,style: TextStyle(fontSize: 25 ,color: Colors.grey),),
                                          trailing: IconButton(
                                              onPressed: (){
                                                setState(() {
                                                  store().removeFromCart(productID,widget.machineId);
                                                });

                                              },
                                              icon:Icon(
                                                Icons.close,
                                                size: 30,
                                              )
                                          )

                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10,right: 10,top: 20),
                                        child: Container(
                                          width: 200,
                                          child: Divider(
                                            height: 3,
                                            thickness: 2,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              // width: 150,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: Text("amount",style: TextStyle(fontSize: 25),),
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(right: 10),
                                                child: Text('${productsamount}',style: TextStyle(fontSize: 25),)
                                            ),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              // width: 150,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: Text("total",style: TextStyle(fontSize: 25),),
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(right: 10),
                                                child: Text('${productsprice}',style: TextStyle(fontSize: 25),)
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
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
                  child: Text('cart is empty'),
                );
              }
            },
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MaterialButton(onPressed: (){},
                  child: Container(
                      width: 160,
                      height: 67,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),


                        color: Colors.red[700],

                      ),
                      child: Center(
                          child: InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return holdout();
                                    },
                                  ),
                                );
                              },
                              child: Text("hold out",style: TextStyle(fontSize:30,color: Colors.white  )))
                      )
                  ),
                ),
                MaterialButton(onPressed: (){},
                  child: Container(
                      width: 160,
                      height: 67,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),


                        color: Colors.red[700],

                      ),
                      child: Center(child: Text("Chekout",style: TextStyle(fontSize:30,color: Colors.white  )))
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );

  }
}