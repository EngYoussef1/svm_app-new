import 'dart:developer';
import 'Userpayment.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  // final databaseReference = FirebaseDatabase.instance.reference();


  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('QR Scanner'),
      // ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller)  {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      print(scanData.code);
     setState(() {
       // var snapshot = await databaseReference.child("qr_codes").once();
       // if (snapshot.value != null && snapshot.value[scanData.code] != null) {
       //   Navigator.pushAndRemoveUntil(
       //       context,MaterialPageRoute(
       //       builder: (context)=>  Payment()
       //   ),
       //           (Route<dynamic>  route) => false
       //   );
       // } else {
       //   ScaffoldMessenger.of(context).showSnackBar(
       //     SnackBar(
       //       content: Text('QR code is wrong'),
       //     ),
       //   );
       // }
     });
    });
  }
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}