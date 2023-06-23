import 'package:flutter/material.dart';
import 'package:svm_app/modules/payment/tryPayment/Screens/register_screen.dart';

class callingRegisterScreen extends StatelessWidget{
  const callingRegisterScreen({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: RegisterScreen(),
    );
  }
}