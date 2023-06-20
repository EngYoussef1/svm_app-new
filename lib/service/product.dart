
import 'package:flutter/material.dart';
import 'package:svm_app/shared/cnstant/contant.dart';
import '../../shared/componant/counter_operations.dart';
import '../models/productClass.dart';
class products extends StatefulWidget {
  const products({Key? key}) : super(key: key);

  @override
  State<products> createState() => _productsState();
}

class _productsState extends State<products> {
  List<CardItem> products = [
    CardItem(name: "Chipsy" , details: "chease"),
    CardItem(name: "Domty", details: "mango" ),
    CardItem(name: "Tiger" , details: "chease"),
  ];

  List<int> selectedItem = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView.builder(
            itemCount:products.length ,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
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
                                image: AssetImage(
                                  'images/firstentry.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            //name , close icon
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              height: 55,
                              width: 200,
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 1),
                                title: Text(products[index].name,style: TextStyle(fontSize: 25),),
                                subtitle: Text(products[index].details,style: TextStyle(fontSize: 25 ,color: Colors.grey),),
                                trailing: IconButton(
                                  onPressed: () {
                                    dprf.child("cart").push().set({
                                      'name':products[index].name,
                                      'amount':products[index].amount,
                                      'price':products[index].price,
                                    });
                                  },
                                  iconSize: 40,
                                  icon: Icon(Icons.add),
                                  color:  Colors.red,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10),
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
                                          products[index].amount -= 1;
                                        });


                                      },
                                      icon:Icon(Icons.remove_circle_outline
                                      )
                                  ),
                                  Text(products[index].amount > 0 ? products[index].amount.toString() : '0',
                                    style: products[index].amount>9? TextStyle(fontSize: 30):TextStyle(fontSize: 40),),
                                  IconButton(
                                      iconSize: 35,
                                      onPressed: (){
                                        setState(() {
                                          products[index].amount += 1;
                                        });
                                      },
                                      icon:Icon(Icons.add_circle_outline
                                      )
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10,right: 10),
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
                                      child: Text("Total",style: TextStyle(fontSize: 25),),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text('${products[index].price}',style: TextStyle(fontSize: 25),)
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
        ),
      ),

    );
  }
  void toggleIconView(int index) {
    if (selectedItem.contains(index)) {
      selectedItem.remove(index);
    } else {
      selectedItem.add(index);
    }
    setState(() {});
  }
}
