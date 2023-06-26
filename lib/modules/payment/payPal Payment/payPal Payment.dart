import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPalScreen extends StatefulWidget{
  PayPalScreen(this.price);
  final price;

  @override
  _PayPalScreenState createState() => _PayPalScreenState();
}

class _PayPalScreenState extends State<PayPalScreen>{
  String _loadHTML(){
    return 'i can not see these lines in the video';
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: WebView(
          onPageFinished: (page){
            if (page.contains('/success')){
              Navigator.pop(context);
            }
          },

          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'http://localhost:8000/pay', //we may need to change this (this is modified to work on the emulator, to change it change also app.listen in app.js file into Server folder)

        )
    );
  }
}