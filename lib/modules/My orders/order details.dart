
import 'package:flutter/material.dart';

class Orderdetails extends StatelessWidget {
  const Orderdetails({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          //Order details
          Padding(
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
                      child: Text("agezy",style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold)),
                    ),
                    SizedBox(height: 15,),
                    //Order ID
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Order ID:23456",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),)
                    ),
                    SizedBox(height: 5,),
                    //Date
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Date:2023/4/6,4.30 pm",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),)
                    ),
                    SizedBox(height: 20,),
                    //products
                    Container(
                      height: 200,
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context,index){
                            return ListTile(
                              title:  Text("Chipsy",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              subtitle: Text("chease",style: TextStyle(fontSize: 20),),
                              trailing: Text("\$16*2",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            );
                          }
                      ),
                    ),
                    SizedBox(height: 10,),
                    //divider
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Divider(thickness: 1,color: Colors.black,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total:",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold)),
                          Text("\$40",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
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
    );
  }
}
