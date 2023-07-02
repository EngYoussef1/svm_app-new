import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:svm_app/shared/cnstant/contant.dart';

import '../models/machinesClass.dart';

class store {
  String? Id =FirebaseAuth.instance.currentUser?.uid;
  addMachine(   userID,name, image, latitude, longitude,slots,details) {
    dprf.child('machines').child(userID!).set({
      kmachinename: name,
      kmachineimage: image,
      klatitude: latitude,
      klongitude: longitude,
      kmachineslots:slots,
      'state':'',
      kmachineDetails:details,
    });
    print(userID);
  }
  Future<List<Map<String, dynamic>>?> getNewMachine() async {
    DatabaseReference machinesRef = FirebaseDatabase.instance.ref().child('machines');

    try {
      DatabaseEvent event = await machinesRef.once();
      DataSnapshot snapshot = event.snapshot;
      dynamic machinesData = snapshot.value;

      if (machinesData != null && machinesData is Map) {
        List<Map<String, dynamic>> machineList = [];

        machinesData.forEach((key, value) {
          String machineId = key.toString();
          if (value is Map) {
            Map<String, dynamic> machineData = value.cast<String, dynamic>();
            machineData['id'] = machineId; // Add the 'id' key to the machine data map
            machineList.add(machineData);
          }
        });

        return machineList;
      } else {
        print('No machines found in the database.');
      }

      return null;
    } catch (error) {
      print('Failed to retrieve data from Firebase: $error');
      return null;
    }
  }


  void addProduct( userID ,Name,position ,price,details,image,amount) {
    // dprf.child('your_collection').get().then((DataSnapshot snapshot) {
    //   String? documentId = snapshot.key;
    //   print('Document ID: $documentId');
    //   // You can use the documentId here
    // });
    dprf
        .child('machine-products')
        .child(userID!)
    .push()
        .set({'name': Name,'position':position, 'price': price,'details':details,'image':image,'amount':amount})
        .then((value) => print('Product added successfully'))
        .catchError((error) => print('Failed to add product: $error'));
  }
  Future<List<Map<String, dynamic>>?> getNewproduct(String machineId) async {
    DatabaseReference machinesRef = FirebaseDatabase.instance
        .ref()
        .child('machine-products')
        .child(machineId);

    try {
      DatabaseEvent event = await machinesRef.once();
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? machinesData =
      snapshot.value as Map<dynamic, dynamic>?;

      if (machinesData != null) {
        List<Map<String, dynamic>> productList = [];

        machinesData.forEach((productId, productData) {
          if (productData is Map) {
            Map<String, dynamic> productMap = productData.cast<String, dynamic>();
            productMap['id'] = productId; // Add the 'id' key to the product data map
            productList.add(productMap);
          }
        });

        return productList;
      } else {
        print('No products found in the database.');
      }

      return null;
    } catch (error) {
      print('Failed to retrieve data from Firebase: $error');
      return null;
    }
  }

  void updateMachineValue(machineId,data) {
    dprf.child('machines').child(machineId!).update(data);
  }
  void updateProductValue(machineId,productID,data) {
    dprf.child('machine-products').child(machineId!).child(productID).update(data);
  }
}
