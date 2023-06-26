import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svm_app/modules/payment/payPal%20Payment/payPal%20Payment.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Payment Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PayPalCallingScreen(PayPalCallingScreen),
    );
  }
}




class PayPalCallingScreen extends StatefulWidget{
  PayPalCallingScreen(this.price);
  final price;

  @override
  _PayPalCallingScreenState createState() => _PayPalCallingScreenState();
}

class _PayPalCallingScreenState extends State<PayPalCallingScreen>{
  late int price;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon:Icon(Icons.arrow_back),),
        iconTheme: IconThemeData(
          size: 40,
          color: Colors.white,
        ),
        primary: true,
        backgroundColor:Colors.red[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        title: Text('Payment',style:  TextStyle(fontSize: 40),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value){
                price=int.parse(value);
              },
              decoration: InputDecoration(
                hintText: 'Enter the amount of money',
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context)=>PayPalScreen(price)));
        },
        child: Icon(Icons.payment),
      ),
    );
  }
}