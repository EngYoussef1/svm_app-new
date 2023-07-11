import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../layout/layout.dart';
import '../../service/store.dart';
import '../../shared/cnstant/contant.dart';

class MachinePayment extends StatefulWidget {
  final String machineId;
  final String productID;
  MachinePayment({required this.machineId, required this.productID});
  @override
  State<MachinePayment> createState() => _MachinePaymentState();
}

class _MachinePaymentState extends State<MachinePayment> {
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
                height: 230,
                child: FutureBuilder<List<Map<dynamic, dynamic>>?>(
                  future: store().getMachineOrder(widget.machineId,widget. productID),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Map<dynamic, dynamic>>? products = snapshot.data;
                      int totalPrice = 0;
                      for (Map<dynamic, dynamic> product in products!) {
                         totalPrice = product['subtotal'] ?? 0;
                      }

                      if (products != null) {
                        return Column(
                          children: [
                            Container(
                              height: 130,
                              child: ListView.builder(
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    Map<dynamic, dynamic> productsData =
                                    products[index];
                                    String productsName = productsData['name'];
                                    int productsquantity = productsData['quantity'];
                                    int productsprice = productsData['price'];
                                    return ListTile(
                                      title: Text(
                                        productsName,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(
                                        '\$${productsprice} * ${productsquantity}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }),
                            ),
                            Container(
                              height: 80,
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
                  child: FutureBuilder<List<Map<dynamic, dynamic>>?>(
                    future: store().getMachineOrder(widget.machineId,widget. productID),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Map<dynamic, dynamic>>? products = snapshot.data;

                        String productName = '';
                        String productsDetails = '';
                        int productsprice = 0;

                        int productsamount = 0;


                        if (products != null) {
                          for (Map<dynamic, dynamic> product in products) {
                            productName = product['name'];
                            // productsDetails = product['details'];
                            productsamount = product['quantity'];
                            productsprice = product['price'];


                            // Do something with the product data here...
                          }
                          return MaterialButton(
                            onPressed: () async {
                              List<Map<String, dynamic>>? userData =
                              await store().fetchUserCardInfo(Id);
                              print(userData);
                              if (formKey.currentState!.validate()) {
                                if (userData == null) {
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
                                                updateMachinestatus(20);
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
                                                updateMachinestatus(30);
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Yes'),
                                            onPressed: () {
                                              saveCartInfo();
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
                                  updateMachinestatus(20);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const NavigationBottom()),
                                          (Route<dynamic> route) => false);
                                }
                                print(widget.productID);
                                DatabaseReference ordersRef = dprf.child('machine-orders').child(widget.machineId).child(widget.productID);
                                ordersRef.onValue.listen((event) {
                                  if (event.snapshot.value != null) {
                                    Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
                                    if (data != null) {
                                      List<dynamic> productIDs = [];
                                      Map<dynamic, dynamic> orders = Map<dynamic, dynamic>.from(data);
                                      if (orders is Map<dynamic, dynamic>) {
                                        Map<dynamic, dynamic>? order = orders['order'];
                                        if (order != null) {
                                          order.forEach((productID, productData) {
                                            print('Product ID: $productID');
                                            // Add a condition to check if the product belongs to the specified order
                                            productIDs.add(productID);
                                          });
                                        }
                                      }
                                      createUserOrder(products, productIDs);
                                    }
                                  } else {
                                    print('No orders found.');
                                  }
                                }, onError: (error) {
                                  print('Failed to retrieve orders: $error');
                                });
                                // createUserOrder(products, [products![0].keys]);

                                // dprf.child('machine-orders').child(widget.machineId).child(widget.productID).child('order').onValue.listen((event) {
                                //   if (event.snapshot.value != null) {
                                //     Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
                                //
                                //     values?.forEach((key, value) {
                                //       if (key != null) { // Add null check for key variable
                                //         createUserOrder(products, key);
                                //         print('Key: $key');
                                //         print('Value: $value');
                                //       }
                                //     });
                                //   } else {
                                //     print('No data found');
                                //   }
                                // }, onError: (error) {
                                //   print('Error: $error');
                                // });

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
  createUserOrder(List<Map<dynamic, dynamic>> products, List<dynamic> productIDs) {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      DatabaseReference ordersRef = dprf.child('user-orders').child(userId!).child(widget.machineId);
      DatabaseReference newOrderRef = ordersRef.push();
      var unixTimeMilliseconds = DateTime.now().toUtc().millisecondsSinceEpoch;

      Map<String, dynamic> orderData = {
        'order': {},
        'status': 20,
        'timestamp': unixTimeMilliseconds,
      };

      for (Map<dynamic, dynamic> product in products) {
        String productName = product['name'];
        String productsDetails = product['details'];
        int productsprice = product['price'];
        int productsamount = product['quantity'];

        Map<String, dynamic> productData = {
          'name': productName,
          'details': productsDetails,
          'price': productsprice,
          'amount': productsamount,
        };


        for (dynamic productID in productIDs) {
          orderData['order'][productID.toString()] = productData;
        }
      }

      newOrderRef.set(orderData).then((value) {
        print('Products pushed to user-orders successfully.');
      }).catchError((error) {
        print('Failed to push products to user-orders: $error');
      });
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Operation failed')),
      );
    }
  }

  saveCartInfo(){
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
      updateMachinestatus(20);
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
      updateMachinestatus(30);
      Navigator.of(context).pop();
    }
  }
  updateMachinestatus(statuse){
    dprf.child('machine-orders').child(widget.machineId!).child(widget.productID).update(
        {
          'status': statuse
        });
  }
}
