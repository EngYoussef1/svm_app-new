abstract class PaymentCubitState{}

class PaymentCubitInitial extends PaymentCubitState{}

class PaymentAuthLoadingInitial extends PaymentCubitState{}

class PaymentAuthSucessInitial extends PaymentCubitState{}

class PaymentAuthErrorInitial extends PaymentCubitState{}

class PaymentGetOrderRegistrationIdLoadingState extends PaymentCubitState{}
class PaymentGetOrderRegistrationIdSucessState extends PaymentCubitState{}
class PaymentGetOrderRegistrationIdErrorState extends PaymentCubitState{}


class PaymentGetPaymentRequestLoadingState extends PaymentCubitState{}
class PaymentGetPaymentRequestSucessState extends PaymentCubitState{}
class PaymentGetPaymentRequestErrorState extends PaymentCubitState{}



class PaymentRefCodeLoadingState extends PaymentCubitState{}
class PaymentRefCodeSucessState extends PaymentCubitState{}
class PaymentRefCodeErrorState extends PaymentCubitState{}