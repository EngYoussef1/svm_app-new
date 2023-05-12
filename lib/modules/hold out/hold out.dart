import 'package:flutter/material.dart';

import '../Drawer/drawer.dart';
import 'holding details.dart';

class holdout extends StatefulWidget {
  const holdout({Key? key}) : super(key: key);

  @override
  State<holdout> createState() => _holdoutState();
}

class _holdoutState extends State<holdout> {
  List products=[
    'agezy',
    'segar',
    'albahr',

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


        title: Text('hold out'),
        centerTitle: true,
      ),
      // drawer: Drawer(
      //   child: drawerview(),
      // ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount:products.length ,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return HoldingDetails();
                            },
                          ),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          height: 220,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:170,
                                        child: Text('${products[index]}',style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold),),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                            onPressed: (){},
                                            icon:Icon(
                                              Icons.close,
                                              size: 30,
                                            )
                                        ),
                                      )

                                    ],
                                  ),
                                  Container(
                                      width:220,
                                      child: Text("chipsy, cocacola, domty",style: TextStyle(fontSize: 20,color: Colors.grey),)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5,bottom: 5),
                                    child: Container(
                                        width:220,
                                        child: Text("Date:2023/4/6,4.30 pm",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),)
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                            alignment: Alignment.centerRight,
                                            width:220,
                                            child: Text("\$16",style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold),)
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );

  }
}