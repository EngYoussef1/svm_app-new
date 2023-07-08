import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../layout/layout.dart';
import '../../service/imageBanner.dart';
import '../../service/machinesView.dart';
import '../../shared/cnstant/contant.dart';
import '../Drawer/drawer.dart';
import '../My machines/my machine.dart';
import '../payment/machinePayment.dart';
import '../search/search.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);

  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

        centerTitle: true,

        title: Container(
            // margin: EdgeInsets.only(left: 25,bottom: 10),
            child:
            Text("Home",
            )
          // style: TextStyle(fontSize: 40),
        ),
        // backgroundColor:Colors.red[700],

        leading: Builder(
          builder: (BuildContext context) {
            return Container(
              // margin: EdgeInsets.only(bottom: 10,left: 5),
              child: IconButton(
                icon: const Icon(Icons.menu,),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            );
          },
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => const SearchPage()));
                },
                icon:  Icon(Icons.search,),
              ),
              IconButton(
                onPressed: () {
                  try{
                    FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR).then((value){
                      if(value!=null){
                        List<String> splitString = value.split("/");
                        String machineID = splitString[0];
                        String productID = splitString[1];
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) {
                        //       return MachinePayment( machineId: machineID,productID: productID);
                        //     },
                        //   ),
                        // );
                        DatabaseReference status =dprf.child('machine-orders').child(machineID).child(productID).child('status');
                        if(status==0){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return MachinePayment( machineId: machineID,productID: productID);
                              },
                            ),
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('qr code had been scanned')),);
                        }

                        dprf.child('machine-orders').child(machineID!).child(productID).update(
                            {
                              'status': 10,
                            });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('machine qr is wrong')),
                        );
                      }
                    });
                  }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('some thing want wrong')),
                    );
                    print('unable to read this');
                  }
                },
                icon:  Icon(Icons.qr_code,),
              ),
            ],
          )
        ],

      ),
      drawer: Drawer(
        child: drawerview(),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Bannerview(),
              SizedBox(
                height: 20,
              ),
              machines(),

            ]
        ),
      ),
    );
  }
}

