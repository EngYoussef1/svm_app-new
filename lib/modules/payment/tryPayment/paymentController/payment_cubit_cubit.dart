//import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:meta/meta.dart';

import '../Constants/constants.dart';
import '../Constants/dio_helper.dart';
import 'payment_cubit_state.dart';

class PaymentCubitCubit extends Cubit<PaymentCubitState>{
  PaymentCubitCubit(): super(PaymentCubitInitial());
  static PaymentCubitCubit get(context)=> BlocProvider.of(context);
  Future<void> getAuthToken() async{
    emit(PaymentAuthLoadingInitial());
    DioHelper.postDataDio(url: ApiConstants.getAuthToken, data:{
      "api_key": ApiConstants.paymentApiKey,
    }).then((value){
      ApiConstants.paymentFirstToken=value.data['token'];
      print('the token is ${ApiConstants.paymentFirstToken}');
      emit(PaymentAuthSucessInitial());
    }).catchError((error){
      emit(PaymentAuthErrorInitial());
    });
  }
  Future getOrderRegisterationId({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String price,
  })async{
    emit(PaymentGetOrderRegistrationIdLoadingState());
    DioHelper.postDataDio(url: ApiConstants.getOrderId, data:{
      "auth_token": ApiConstants.paymentFirstToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "items": [], //remove that??????????????????????????
    }).then((value){
      ApiConstants.paymentOrderId=value.data['id'];
      //getPaymentRequest(firstName,lastName,email,phone,price);
      emit(PaymentGetOrderRegistrationIdSucessState());
    }).catchError((error){
      print(error.toString());
      emit(PaymentGetOrderRegistrationIdErrorState());
    });
  }
  Future<void>getPaymentRequest({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String price,
  })async{
    emit(PaymentGetOrderRegistrationIdLoadingState());
    DioHelper.postDataDio(url: ApiConstants.getPaymentId, data:{
      "auth_token": ApiConstants.paymentFirstToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "expiration": 3600,
      "order_id": ApiConstants.paymentOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping-method": "NA",
        "postal-code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA",
      },
      "currency": "EGP",
      "integration_id": ApiConstants.integrationIdCard,
      "lock_order_when_paid": "false"
    }).then((value){
      ApiConstants.finalToken = value.data['token'];
      print('Final Token is  ${ApiConstants.finalToken}');
    }).catchError((error){
      print(error.toString());
      emit(PaymentGetPaymentRequestErrorState());
    });
  }
  Future<void>getRefCode()async{
    emit(PaymentRefCodeLoadingState());
    DioHelper.postDataDio(url: ApiConstants.getRefCode, data:{
      "source": {
        "identifier": "AGGREGATOR",
        "subtype": "AGGREGATOR"
      },
      "payment_token": ApiConstants.finalToken,
    }).then((value){
      print('Sucess get ref code');
      ApiConstants.refCode = value.data['id'].toString();
      emit(PaymentRefCodeSucessState());
    }).catchError((error){
      print(error.toString());
      emit(PaymentRefCodeErrorState());
    });
  }
}