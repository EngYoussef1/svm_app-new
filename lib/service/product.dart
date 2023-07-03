
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svm_app/service/store.dart';
import 'package:svm_app/shared/cnstant/contant.dart';
import '../../shared/componant/counter_operations.dart';
import '../models/productClass.dart';
class products extends StatefulWidget {
  final String machineId;
  const products({ required this.machineId}) ;

  @override
  State<products> createState() => _productsState();
}

class _productsState extends State<products> {

  List<int> selectedItem = [];
  List<int> amounts = [];
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Map<dynamic, dynamic>>?>(
        future: store().getNewproduct(widget.machineId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map<dynamic, dynamic>>? products = snapshot.data;
            if (products != null) {
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Map<dynamic, dynamic> productsData = products[index];
                  String productsName = productsData['name'];
                  String productsDetails = productsData['details'];
                  int productsamount = productsData['amount'];
                  String productsimage = productsData['image'];
                  int productsprice = productsData['price'];
                  String productID=productsData['id'];
                  // Build your list item here using products[index]
                  if (amounts.length <= index) {
                    amounts.add(0);
                  }

                  // Build your list item here using products[index]
                  int amount = amounts[index];
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
                                      onPressed: () {
                                        String? Id =FirebaseAuth.instance.currentUser?.uid;
                                        dprf.child('cart').child(Id!).child(widget.machineId).child(productsData['id']).set({
                                          'name':productsName,
                                          'details':productsDetails,
                                          'price':productsprice,
                                          'image':productsimage,
                                          'amount':amounts[index],
                                        });

                                      },
                                      iconSize: 40,
                                      icon: Icon(Icons.add),
                                      color:  Colors.red,
                                    ),

                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 10,top: 10),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 90,
                                      ),
                                      IconButton(
                                          alignment: Alignment.centerRight,
                                          iconSize: 35,
                                          onPressed: (){
                                            setState(() {
                                              if (amount > 0) {
                                                amount -= 1;
                                              }
                                              amounts[index] = amount as int;
                                            });
                                          },
                                          icon:Icon(Icons.remove_circle_outline
                                          )
                                      ),
                                      Text(amount > 0 ? amount.toString() : '0',
                                        style: amount>9? TextStyle(fontSize: 30):TextStyle(fontSize: 40),),
                                      IconButton(
                                          iconSize: 35,
                                          onPressed: (){
                                            setState(() {
                                              if(amount< productsamount){
                                                amount += 1;
                                              }
                                              amounts[index] = amount as int;
                                            });
                                          },
                                          icon:Icon(Icons.add_circle_outline
                                          )
                                      )
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10,right: 10,top: 10),
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
                                          child: Text("price",style: TextStyle(fontSize: 25),),
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
                },
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
            );
          }
        },
      ),
    );
  }
  // void toggleIconView(int index) {
  //   if (selectedItem.contains(index)) {
  //     selectedItem.remove(index);
  //   } else {
  //     selectedItem.add(index);
  //   }
  //   setState(() {});
  // }
}
