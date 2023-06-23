
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_auth/firebase_auth.dart';


class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  var showpassword=true;
  var showconfirmpassword=true;

  var fullname = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  // var confirmpasswordController = TextEditingController();

  signUp() async {
    if(formKey.currentState!.validate())
    {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
       return userCredential;

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
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.red[700],
          // ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.red[700],
                  alignment: Alignment.topLeft,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  },
                    icon:Icon(Icons.arrow_back),),
                ),
                Container(
                  width: double.infinity,
                  height: 225,

                  decoration:BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), )
                  ) ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Container(
                       child:  Column(
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(10),
                             child: Container(
                               child: Text("Welcome",style: TextStyle(fontSize: 30,fontWeight:FontWeight.w500,color: Colors.white),),
                             ),
                           ),
                           Container(
                             child: Text("please sign up to continue",style: TextStyle(fontSize: 30,fontWeight:FontWeight.w500,color: Colors.white),),
                           ),
                         ],
                       ),

                     ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: fullname,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Full Name',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                validator: ( value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return 'name must not be empty';
                                  }

                                  return null;
                                },
                                onFieldSubmitted: (value){
                                  print(value);
                                },

                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                validator: ( value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return 'email must not be empty';
                                  }

                                  return null;
                                },
                                onFieldSubmitted: (value){
                                  print(value);
                                },

                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: showpassword,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'password',
                                  labelStyle: TextStyle(fontSize: 30),
                                  suffixIcon:IconButton(onPressed:(){
                                    setState(()
                                    {
                                      showpassword = !showpassword;
                                    });
                                  } , icon:Icon(showpassword ? Icons.visibility:Icons.visibility_off,),
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
                                onFieldSubmitted: (value){
                                  print(value);
                                },

                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // TextFormField(
                              //   controller: confirmpasswordController,
                              //   obscureText: showconfirmpassword,
                              //   keyboardType: TextInputType.number,
                              //   decoration:  InputDecoration(
                              //     border: OutlineInputBorder(),
                              //     labelText: 'Confirm password',
                              //     labelStyle: TextStyle(fontSize: 30),
                              //     suffixIcon:IconButton(onPressed:(){
                              //       setState(()
                              //       {
                              //         showconfirmpassword = !showconfirmpassword;
                              //       });
                              //     } , icon:Icon(showconfirmpassword ? Icons.visibility:Icons.visibility_off,),
                              //     ),
                              //   ),
                              //   validator: ( value)
                              //   {
                              //     if(value!.isEmpty)
                              //     {
                              //       return 'password must not be empty';
                              //     }
                              //
                              //     if(value!=confirmpasswordController)
                              //     {
                              //       return 'password is\'nt match';
                              //     }
                              //
                              //
                              //     return null;
                              //   },
                              //   onFieldSubmitted: (value){
                              //     print(value);
                              //   },
                              //
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(onPressed: () async{
                         var userData=await signUp();
                         if(userData!=null){
                           Navigator.pop(context);
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
                              child: Center(child: Text("Sign up",style: TextStyle(fontSize:30,color: Colors.white )))
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
      ),

    );
  }
}

