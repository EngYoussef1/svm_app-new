
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../layout/layout.dart';
import '../home/home.dart';
import '../sign up/sign up.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({Key? key}) : super(key: key);

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  var showpassword=true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password:  passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
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
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          child: Text("Welcome",style: TextStyle(fontSize: 30,fontWeight:FontWeight.w500,color: Colors.white ),),
                        ),
                      ),
                      Container(
                        child: Text("please sign in to continue",style: TextStyle(fontSize: 30,fontWeight:FontWeight.w500,color: Colors.white ),),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
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
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
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
                                height: 30,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: showpassword,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'password',
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        MaterialButton(onPressed: (){
                          if(formKey.currentState!.validate())
                          {
                            print(emailController.text);
                            print(passwordController.text);
                          }
                        },
                          child: Container(
                            // width: double.infinity,
                              height: 67,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),


                                color: Colors.red[700],

                              ),
                              child: Center(child: Text("Sign in",style: TextStyle(fontSize:30,color: Colors.white  )))
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text("don't have account?",style:TextStyle(fontSize: 25)),
                            TextButton(onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return Sign_up();
                                      },
                                  ),
                              );
                            },
                                child: Text("sign up",style:TextStyle(color:Colors.red[700],fontSize: 20 ),))

                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(onPressed: (){},
                                child:Image.asset("images/twitter.png",width: 50,height: 50,),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              MaterialButton(onPressed: (){},
                                child:Image.asset("images/google.png",width: 50,height: 50,),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              MaterialButton(onPressed: (){},
                                child:Image.asset("images/facebook.png",width: 50,height: 50,),
                              ),
                            ]
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 20),
                  // height: double.infinity,
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(
                          context,MaterialPageRoute(
                          builder: (context)=> const NavigationBottom()
                      ),
                              (Route<dynamic>  route) => false
                      );
                    },
                    child: Text("Skip Now",style:TextStyle(color:Colors.red[700],fontSize: 27 ),),
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
