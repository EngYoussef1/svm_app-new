class ApiConstants{
  //https://accept.paymob.com/api/auth/tokens
  static const String baseUrl= 'https://accept.paymob.com/api';
  static const String getAuthToken= '/auth/tokens';
  static const String paymentApiKey = 'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T0RNek5UY3lMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuMVA0aldTcmc0SlZNQ3hfamlvV3cydjI4WktYSzFSOW5rbUtGR1AwbDNub3FUMkowdEV5QzdFNC1CSEdqNUZGWFJScWRaWlluaTNaWVhwV3pTd0tjSmc=';
  static const String getOrderId = '/ecommerce/orders';
  static const String getPaymentId = '/acceptance/payment_keys';
  static const String getRefCode = '/acceptance/payment/pay'; //kiosk payment
  static String visaUrl =
      '$baseUrl/acceptance/iframes/424000?payment_token=$finalToken';
  static String paymentFirstToken= ''; //the token from authentication to use to the payment process(with card)
  static String paymentOrderId = '';
  static String finalToken = '';
  static String refCode = '';

  static String integrationIdKiosk = '3957701';
  static String integrationIdCard = '3953530';
}