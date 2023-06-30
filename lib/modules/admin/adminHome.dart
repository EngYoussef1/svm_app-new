import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../service/auth.dart';
import '../../service/store.dart';
import '../sign in/sign in.dart';
import 'addMachine.dart';
import 'addProduct.dart';
import 'editMachine.dart';
import 'editProduct.dart';
import 'viewMachine.dart';
import 'viewProduct.dart';

class adminHome extends StatelessWidget {
   adminHome({Key? key}) : super(key: key);
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Admin panal')),
        leading: IconButton(
          icon: const Icon(Icons.logout,),
          onPressed: () {
            _auth.signOut();
            Navigator.pushAndRemoveUntil(
                context,MaterialPageRoute(
                builder: (context)=> const Sign_in()
            ),
                    (Route<dynamic>  route) => false
            );
          },

        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  addMachine()),
              );
            },
            child: Container(
                width: 270,
                height: 67,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.red[700],
                ),
                child: Center(child: Text("Add machine",style: TextStyle(fontSize:30,color: Colors.white )))
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  editMachine()),
              );
            },
            child: Container(
                width: 270,
                height: 67,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.red[700],
                ),
                child: Center(child: Text("Edit machine",style: TextStyle(fontSize:30,color: Colors.white )))
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ViewMachine()),
              );
              print(store().getNewMachine());
            },
            child: Container(
                width: 270,
                height: 67,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.red[700],
                ),
                child: Center(child: Text("View machine",style: TextStyle(fontSize:30,color: Colors.white )))
            ),
          ),

          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  editProduct()),
              );
            },
            child: Container(
                width: 270,
                height: 67,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.red[700],
                ),
                child: Center(child: Text("Edit product",style: TextStyle(fontSize:30,color: Colors.white )))
            ),
          ),
          SizedBox(
            height: 10,
          ),

        ],
      ),
    );
  }
}
