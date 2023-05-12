import 'package:flutter/material.dart';
import '../../shared/componant/counter_operations.dart';

import '../Drawer/drawer.dart';

class HoldingDetails extends StatefulWidget {
  const HoldingDetails({Key? key}) : super(key: key);

  @override
  State<HoldingDetails> createState() => _HoldingDetailsState();
}

class _HoldingDetailsState extends State<HoldingDetails> {
  List products=[
    'Chipsy',
    'fayrouz',
    'Cocacola',
    'Cocacola',
    'fayrouz',


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon:Icon(Icons.arrow_back),),

        primary: true,


        title: Text('Holding Details'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount:products.length ,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      height: 180,
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //name , close icon
                              Container(
                                height: 40,
                                child: Row(

                                  children: [
                                    Container(
                                      width: 180,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20,top:10),
                                        child: Text('${products[index]}',style: TextStyle(fontSize: 25),),
                                      ),
                                    ),

                                    IconButton(
                                        onPressed: (){},
                                        icon:Icon(
                                          Icons.close,
                                          size: 30,
                                        )
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                // color: Colors.red,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 90,
                                    ),
                                    IconButton(
                                        iconSize: 40,
                                        onPressed: (){
                                          setState(() {
                                            decrementCounter();
                                          });
                                        },
                                        icon:Icon(Icons.remove_circle_outline
                                        )
                                    ),
                                    Text('$counter',style: TextStyle(fontSize: 40),),
                                    IconButton(
                                        iconSize: 40,
                                        onPressed: (){
                                          setState(() {
                                            incrementCounter();
                                          });
                                        },
                                        icon:Icon(Icons.add_circle_outline
                                        )
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5,bottom: 10),
                                child: Container(
                                  width: 200,
                                  child: Divider(
                                    height: 3,
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 180,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20,top: 5),
                                      child: Text("total",style: TextStyle(fontSize: 25),),
                                    ),
                                  ),
                                  Text('\$16',style: TextStyle(fontSize: 25),),

                                ],
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
          Container(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(onPressed: (){},
              child: Container(
                  width: 260,
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
          )
        ],
      ),
    );

  }
}