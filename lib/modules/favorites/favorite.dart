import 'package:flutter/material.dart';
import '../Drawer/drawer.dart';
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

  List products=[
    'Chipsy',
    'fayrouz',
    'Cocacola',
    'Cocacola',
    'fayrouz',
  ];
  final List machines=[
    'agezy',
    'segar',
    'albahr',
    'main',
  ];
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
            bottom: TabBar(
              padding: EdgeInsets.only(left: 35.0, right: 35.0),
              //padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 90.0),
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Products',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Machines',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: drawerview(),
          ),
          body: TabBarView(
            children: <Widget>[
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
                          height: 140,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //name , close icon
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
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
                                    padding: EdgeInsets.only(left: 20),
                                   child: Text("descreption",style: TextStyle(fontSize:25,color: Colors.grey ),),
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
              ListView.builder(
                  itemCount:machines.length ,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          height: 140,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //name , close icon
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(

                                      children: [
                                        Container(
                                          width: 180,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20,top:10),
                                            child: Text('${machines[index]}',style: TextStyle(fontSize: 25),),
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
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text("descreption",style: TextStyle(fontSize:25,color: Colors.grey ),),
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
            ],
          ),
        ));
  }
}
