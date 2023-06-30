
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../service/store.dart';

class addProduct extends StatelessWidget {
  final  user;
  addProduct({required this.user});
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  // var name = TextEditingController();
  // var machineID = TextEditingController();
  // var image = TextEditingController();
  // var details = TextEditingController();
  // var price = TextEditingController();
  // var amount = TextEditingController();
  String _name='',_image='',_details='';
  int _price=0,amount=0,position=0;
  final _store = store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addProduct'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key:_globalKey ,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'position',
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'position must not be empty';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    position=int.parse(value);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'name must not be empty';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    _name=value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(

                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Details',
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'details must not be empty';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    _details=value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(

                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter image URL',
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'image URL must not be empty';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _image=value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(

                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'price must not be empty';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    _price=int.parse(value);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'amount must not be empty';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    amount=int.parse(value);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(

                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                       _store.addProduct(user,_name,position, _price, _details, _image,amount,);
                    }
                  },
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
                      child: Center(child: Text("add product",style: TextStyle(fontSize:30,color: Colors.white )))
                  ),
                ),
              ],
            ) ,
          ),
        ),
      ),
    );
  }
}
