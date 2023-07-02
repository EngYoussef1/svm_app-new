import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:svm_app/modules/payment/tryPayment/Constants/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';






class VisaScreen extends StatefulWidget {
  const VisaScreen({Key? key}) : super(key: key);

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState(){
    super.initState();
    if (Platform.isAndroid){
      WebView.platform= SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          body: WebView(
            initialUrl: ApiConstants.visaUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController){
              _controller.complete(webViewController);
            },
            onProgress: (int progress){
              print('WebView is loading (progress: $progress%)');
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request){
              if (request.url.startsWith('https://www.google.com/')){
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context){
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}
