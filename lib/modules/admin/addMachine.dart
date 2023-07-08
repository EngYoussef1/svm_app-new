
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:svm_app/models/machinesClass.dart';

import '../../service/auth.dart';
import '../../service/store.dart';
import '../../shared/cnstant/contant.dart';
import 'addProduct.dart';

class addMachine extends StatefulWidget {
  addMachine({Key? key}) : super(key: key);

  @override
  State<addMachine> createState() => _addMachineState();
}

class _addMachineState extends State<addMachine> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> machineAuth = GlobalKey<FormState>();

  // var name = TextEditingController();
  String _name='',_image='',_details='',_email='',_passwoed='',_location='';



  int _slots=0;

  final _store = store();
  final _auth = Auth();

  var showpassword=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addMachine'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: machineAuth,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'email',
                          labelStyle: TextStyle(fontSize: 30),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email must not be empty';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          print(value);
                          _email=value!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: showpassword,
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'password',
                          labelStyle: TextStyle(fontSize: 30),
                          suffixIcon:IconButton(onPressed:(){
                            setState(()
                            {
                              showpassword = !showpassword;
                            });
                          } , icon:Icon(showpassword ? Icons.visibility_off:Icons.visibility,),
                          ),
                        ),
                        validator: ( value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'password must not be empty';
                          }

                          return null;
                        },
                        onChanged: (value){
                          print(value);
                          _passwoed=value!;
                        },

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (machineAuth.currentState!.validate()) {
                            machineAuth.currentState!.save();

                            try {

                              var authResult = await _auth.signUp( _email,_passwoed);
                              print(authResult.user?.uid);




                              // handle successful registration here
                            } on FirebaseAuthException catch (e) {

                              if (e.code == 'weak-password') {
                                Fluttertoast.showToast(msg: "The password provided is too weak.");
                              } else if (e.code == 'email-already-in-use') {
                                Fluttertoast.showToast(msg: "The account already exists for that email.");
                              } else {
                                Fluttertoast.showToast(msg: "Unknown error occurred.");
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: Container(
                            width: 270,
                            height: 67,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),


                              color: Colors.red[700],

                            ),
                            child: Center(child: Text("add machine user",style: TextStyle(fontSize:30,color: Colors.white )))
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
              ),
              Form(
                key:_globalKey ,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        labelStyle: TextStyle(fontSize: 30),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        print(value);
                        _name=value!;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'details',
                        labelStyle: TextStyle(fontSize: 30),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'details must not be empty';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        print(value);
                        _details=value!;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'slots',
                        labelStyle: TextStyle(fontSize: 30),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'slots must not be empty';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        print(value);
                        _slots=int.parse(value)!;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(

                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'location',
                        labelStyle: TextStyle(fontSize: 30),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'location must not be empty';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        print(value);
                        _location=value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter image URL',
                        labelStyle: TextStyle(fontSize: 30),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'image URL must not be empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print(value);
                        _image=value!;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (_globalKey.currentState!.validate()) {
                          _globalKey.currentState!.save();
                          final user = await _auth.getUser();
                          _store.addMachine( user ,_name,_image,_location,_slots,_details);
                        }
                      },
                      child: Container(
                          width: 270,
                          height: 67,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),


                            color: Colors.red[700],

                          ),
                          child: Center(child: Text("add machine",style: TextStyle(fontSize:30,color: Colors.white )))
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // FutureBuilder<List<dynamic>>(
                    //   future: store().getNewMachine(),
                    //   builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       return CircularProgressIndicator(); // Show a loading indicator while waiting for the data
                    //     } else if (snapshot.hasError) {
                    //       return Text('Error: ${snapshot.error}');
                    //     } else {
                    //       var name = snapshot.data![0];
                    //       return Text(
                    //         name ?? '',
                    //         style: TextStyle(
                    //           fontSize: 25,
                    //           fontWeight: FontWeight.w500,
                    //           color: Colors.white,
                    //         ),
                    //       ); // Display the retrieved name
                    //     }
                    //   },
                    // ),
                    MaterialButton(
                      onPressed: ()async {
                        final user = await _auth.getUser();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  addProduct(user: user)),
                        );
                        print(user);

                      },
                      child: Container(
                          width: 270,
                          height: 67,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: Colors.red[700],
                          ),
                          child: Center(child: Text("add product",style: TextStyle(fontSize:30,color: Colors.white )))
                      ),
                    ),
                  ],
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
