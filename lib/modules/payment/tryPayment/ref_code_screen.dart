import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:svm_app/modules/payment/tryPayment/Constants/constants.dart';

class ReferenceScreen extends StatelessWidget {
  const ReferenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon:Icon(Icons.arrow_back),),
        primary: true,


        title: Text('My Orders'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'You should go to any market to pay',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0,),
              const Text('This is reference code', style: TextStyle(fontSize: 10.0),),
              const SizedBox(height: 30.0,),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.purple.shade300,
                ),
                child: Center(
                  child: Text(
                    ApiConstants.refCode.isEmpty? '${const Icon(Icons.not_interested)}':ApiConstants.refCode,
                    style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold,color: Colors.white,),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
