import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svm_app/modules/payment/tryPayment/default_button.dart';
import 'package:svm_app/modules/payment/tryPayment/default_textFormFiled.dart';
import 'package:svm_app/modules/payment/tryPayment/paymentController/payment_cubit_cubit.dart';
import 'package:svm_app/modules/payment/tryPayment/paymentController/payment_cubit_state.dart';
import 'package:svm_app/modules/payment/tryPayment/Screens/toggle_screen.dart';

class RegisterScreen extends StatelessWidget{
  RegisterScreen({super.key});
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return BlocProvider(create: (context)=> PaymentCubitCubit()..getAuthToken(),
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
        body: BlocConsumer<PaymentCubitCubit,PaymentCubitState>
          (listener: (context, state){
            if (state is PaymentGetPaymentRequestSucessState){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ToggleScreen(),
                )
                );
            }
        }, builder: (BuildContext context, state) {
            var cubit = PaymentCubitCubit.get(context);
          return SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  child: Image.asset('images/homeimage.jpg'),
                  width: double.infinity,
                  height: 300,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: DefaultTextFormFileed(
                                controller: firstNameController,
                                type: TextInputType.text,
                                hintText: 'First Name',
                                prefix: Icons.person,
                                validate: (String? value){
                                  if (value!.isEmpty){
                                    return 'please enter your first name';
                                  }
                                  return null;
                                }
                            )),
                            SizedBox(width: 10.0),
                            Expanded(child: DefaultTextFormFileed(
                                controller: lastNameController,
                                type: TextInputType.text,
                                hintText: 'Last Name',
                                prefix: Icons.person,
                                validate: (String? value){
                                  if (value!.isEmpty){
                                    return 'please enter your last name';
                                  }
                                  return null;
                                }
                            ))
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        DefaultTextFormFileed(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            hintText: 'email',
                            prefix: Icons.email,
                            validate: (String? value){
                              if (value!.isEmpty){
                                return 'please enter your email';
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 10.0,),
                        DefaultTextFormFileed(
                            controller: phoneController,
                            type: TextInputType.phone,
                            hintText: 'phone',
                            prefix: Icons.phone,
                            validate: (String? value){
                              if (value!.isEmpty){
                                return 'please enter your password';
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 10.0,),
                        DefaultTextFormFileed(
                            controller: priceController,
                            type: TextInputType.text,
                            hintText: 'price',
                            prefix: Icons.price_change,
                            validate: (String?value){
                              if (value!.isEmpty){
                                return 'please enter the price';
                              }
                              return null;
                            }
                        ),
                        SizedBox(height: 10.0,),
                        DefaultButton(
                          backgroundColor: Colors.purple.shade300,
                          radius: 10.0,
                          buttonWidget: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              letterSpacing: 1.7,
                            ),
                          ),
                          function: (){
                            if(formKey.currentState!.validate()){
                              cubit.getOrderRegisterationId(firstName: firstNameController.text, lastName: lastNameController.text, email: emailController.text, phone: phoneController.text, price: priceController.text);
                            }
                          },
                        )

                      ],
                    )
                )
              ],
            ),
          );
        },)
      )
    );
  }
}