import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../layout/layout.dart';
import '../../service/store.dart';
import '../../shared/cnstant/contant.dart';
import '../My orders/my order.dart';

class Payment extends StatefulWidget {
  final String machineId;
  Payment({required this.machineId});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var _character;
  var formKey = GlobalKey<FormState>();
  // var CardName = TextEditingController();
  // var CardNamber = TextEditingController();
  // var EpiringOn = TextEditingController();
  // var ccv = TextEditingController();
  String? Id = FirebaseAuth.instance.currentUser?.uid;
  String CardName = '', EpiringOn = '';
  int ccv = 0, CardNamber = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        iconTheme: IconThemeData(
          size: 40,
          color: Colors.white,
        ),
        primary: true,
        backgroundColor: Colors.red[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        title: Text(
          'Payment',
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 280,
                child: FutureBuilder<List<Map<dynamic, dynamic>>?>(
                  future: store().getCartInfo(widget.machineId, Id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Map<dynamic, dynamic>>? products = snapshot.data;
                      int totalPrice = 0;
                      if (products != null) {
                        for (Map<dynamic, dynamic> product in products) {
                          int productPrice = product['price'] ?? 0;
                          int productAmount = product['amount'] ?? 0;
                          totalPrice += productPrice * productAmount;
                        }
                        return Column(
                          children: [
                            Container(
                              height: 180,
                              child: ListView.builder(
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    Map<dynamic, dynamic> productsData =
                                        products[index];
                                    String productsName = productsData['name'];
                                    String productsDetails =
                                        productsData['details'];
                                    int productsamount = productsData['amount'];
                                    String productsimage =
                                        productsData['image'];
                                    int productsprice = productsData['price'];
                                    String productID = productsData['id'];
                                    return ListTile(
                                      title: Text(
                                        productsName,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        productsDetails,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      trailing: Text(
                                        '\$${productsprice} * ${productsamount}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }),
                            ),
                            Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Total:",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
                                        Text("\$${totalPrice}",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text('No products available'),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error loading products'),
                      );
                    } else {
                      return Center(
                        child: Text('cart is empty'),
                      );
                    }
                  },
                ),
              ),
              // SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(35)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Credit",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        // SizedBox(width: 230,),
                        Radio(
                            value: 'Credit',
                            groupValue: _character,
                            onChanged: (value) {
                              setState(() {
                                _character = value;
                                print("$_character");
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Debit Card",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        // SizedBox(width: 230,),
                        Radio(
                            value: 'DebitCard',
                            groupValue: _character,
                            onChanged: (value) {
                              setState(() {
                                _character = value;
                                print("$_character");
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Paypal",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        // SizedBox(width: 230,),
                        Radio(
                            value: 'Paypal',
                            groupValue: _character,
                            onChanged: (value) {
                              setState(() {
                                _character = value;
                                print("$_character");
                              });
                            })
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Card Name must not be empty';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          CardName = value;
                          print(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Namber',
                        ),
                        validator: (value) {
                          if (value!.length != 16) {
                            return 'invalid card';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          CardNamber = int.parse(value);
                          print(value);
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'YY/MM',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' date must not be empty';
                              }

                              return null;
                            },
                            onChanged: (value) {
                              EpiringOn = value;
                              print(value);
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'ccv',
                              ),
                              validator: (value) {
                                if (value!.length != 3) {
                                  return 'invalid card';
                                }

                                return null;
                              },
                              onChanged: (value) {
                                ccv = int.parse(value);
                                print(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child:FutureBuilder<List<Map<dynamic, dynamic>>?>(
                  future: store().getCartInfo(widget.machineId,Id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Map<dynamic, dynamic>>? products = snapshot.data;
                      if (products != null) {
                        return   MaterialButton(
                          onPressed: () async {
                            List<Map<String, dynamic>>? userData =
                            await store().fetchUserData(Id);
                            print(userData);
                            if (formKey.currentState!.validate()) {
                              if (userData == null) {
                                for (Map<dynamic, dynamic> product in products) {
                                  String productsName = product['name'];
                                  String productsDetails = product['details'];
                                  int productsamount = product['amount'];
                                  String productsimage = product['image'];
                                  int productsprice = product['price'];
                                  String productID = product['id'];

                                }
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Do You Want to save card info? '),
                                      actions: [
                                        TextButton(
                                          child: Text('No'),
                                          onPressed: () {
                                            try {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content:
                                                    Text('Successfully payment')),
                                              );

                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => const NavigationBottom()),
                                                      (Route<dynamic> route) => false);
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content:
                                                    Text('Something went wrong')),
                                              );
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Yes'),
                                          onPressed: () {
                                            try {
                                              String? userId = FirebaseAuth
                                                  .instance.currentUser?.uid;
                                              DatabaseReference userRef =
                                              dprf.child('user').child(userId!);
                                              userRef.update({
                                                'cardInfo': {
                                                  'CardName': CardName,
                                                  'CardNamber': CardNamber,
                                                  'EpiringOn': EpiringOn,
                                                  'ccv': ccv,
                                                  'cardtype': _character,
                                                }
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content:
                                                    Text('Successfully payment')),
                                              );
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => const NavigationBottom()),
                                                      (Route<dynamic> route) => false);
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content:
                                                    Text('Something went wrong')),
                                              );
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Successfully payment')),
                                );
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const NavigationBottom()),
                                        (Route<dynamic> route) => false);
                              }

                              try {
                                String? userId = FirebaseAuth.instance.currentUser?.uid;
                                DatabaseReference cartRef = dprf
                                    .child('cart')
                                    .child(userId!)
                                    .child(widget.machineId);
                                DatabaseReference ordersRef =
                                dprf.child('user-orders')
                                .child(userId!)
                                    .child(widget.machineId);

                                cartRef.once().then((DatabaseEvent event) {
                                  DataSnapshot snapshot = event.snapshot;
                                  Map<dynamic, dynamic>? cartData =
                                  snapshot.value as Map<dynamic, dynamic>?;

                                  if (cartData != null) {
                                    cartData.forEach((key, value) {
                                      // Push product data to machine-orders
                                      DatabaseReference newOrderRef = ordersRef

                                          .push();
                                      print(value);
                                      var unixTimeMilliseconds =
                                          DateTime.now().toUtc().millisecondsSinceEpoch;
                                      // Modify the structure of the order data according to your requirements
                                      Map<String, dynamic> orderData = {
                                        'order': value,
                                        'status': 20,
                                        'timestamp': unixTimeMilliseconds,
                                      };


                                      newOrderRef.set(orderData).then((value) {
                                        print(
                                            'Product pushed to machine-orders successfully.');
                                      }).catchError((error) {
                                        print(
                                            'Failed to push product to machine-orders: $error');
                                      });
                                    });
                                  }
                                  store().removeCart(widget.machineId);
                                });
                              } catch (e) {
                                print('Error: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Operation failed')),
                                );
                              }
                            }
                          },
                          child: Container(
                              width: 260,
                              height: 67,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                                color: Colors.red[700],
                              ),
                              child: Center(
                                  child: Text("Proceed",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white)))),
                        );
                      } else {
                        return Center(
                          child: Text('No products available'),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error loading products'),
                      );
                    } else {
                      return Center(
                        child: Text('cart is empty'),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
