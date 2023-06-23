
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svm_app/modules/payment/tryPayment/paymentController/payment_cubit_cubit.dart';
import 'package:svm_app/modules/payment/tryPayment/paymentController/payment_cubit_state.dart';
import 'package:svm_app/modules/payment/tryPayment/ref_code_screen.dart';
import 'package:svm_app/modules/payment/tryPayment/Screens/visa_screen.dart';

//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => PaymentCubitCubit(),
    child: Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.red[700],
        title: const Text(
          'My app',
          style: TextStyle(
            // color: Colors.white,
            // fontSize: 41,
            // fontWeight: FontWeight.bold,
            // fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        // elevation: 0.0,
        toolbarHeight: 60.0,
        // titleSpacing: 20.0,
        bottom: TabBar(
          padding: EdgeInsets.only(left: 35.0, right: 35.0),
          //padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 90.0),
          tabs: <Widget>[
            Tab(
              child: Text(
                'Products',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Tab(
              child: Text(
                'Machines',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),

      body: BlocConsumer<PaymentCubitCubit,PaymentCubitState>(
          listener: (context, state){
            if(state is PaymentRefCodeSucessState){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ReferenceScreen(),
              ),
              );
          }
      }, builder: (context, state){
        var cubit=PaymentCubitCubit.get(context);
        return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
                child: InkWell(
                  onTap: (){
                    cubit.getRefCode();
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/KIOSKNumber.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.black, width:2.0),
                    ),
                  ),
                )
            ),
            SizedBox(height: 10.0,),
            Expanded(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> VisaScreen(),),);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/VISA.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.black, width:2.0),
                    ),
                  ),
                )
            ),
          ],
        )
      );
      }
      )
    )
    );
  }
}

