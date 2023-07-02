
import 'package:flutter/material.dart';

import '../../service/store.dart';

class editProduct extends StatelessWidget {
  final String machineId;
  final String productID;
   editProduct({  required this.machineId,  required this.productID}) ;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  // var name = TextEditingController();
  // var machineID = TextEditingController();
  // var image = TextEditingController();
  // var details = TextEditingController();
  // var price = TextEditingController();
  // var amount = TextEditingController();
  String _name='',_image='',_details='';
  int _price=0,_amount=0,position=0;
  final _store = store();

  chackupdatedvalue(){
    if(_name.isNotEmpty){
      _store.updateProductValue(machineId,productID ,{'name': _name});
    }
    if(_details.isNotEmpty){

      _store.updateProductValue(machineId,productID,{ 'details': _details});
    }
    if(_price!=0){

      _store.updateProductValue(machineId,productID,{ 'price': _price});
    }
    if(_amount!=0){

      _store.updateProductValue(machineId,productID,{ 'amount': _amount});
    }
    if(position!=0){

      _store.updateProductValue(machineId,productID,{ 'position': position});
    }
    if(_image.isNotEmpty){
      _store.updateProductValue(machineId,productID,{ 'image': _image});
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
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
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'position must not be empty';
                  //   }
                  //
                  //   return null;
                  // },
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
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'name must not be empty';
                  //   }
                  //
                  //   return null;
                  // },
                  onChanged: (value) {
                    print(value);
                    _name=value!;
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
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'details must not be empty';
                  //   }
                  //
                  //   return null;
                  // },
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
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'image URL must not be empty';
                  //   }
                  //   return null;
                  // },
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
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'price must not be empty';
                  //   }
                  //
                  //   return null;
                  // },
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
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'amount must not be empty';
                  //   }
                  //
                  //   return null;
                  // },
                  onChanged: (value) {
                    _amount=int.parse(value);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(

                  onPressed: () {
                    chackupdatedvalue();
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
                      child: Center(child: Text("Edit Product",style: TextStyle(fontSize:30,color: Colors.white )))
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
