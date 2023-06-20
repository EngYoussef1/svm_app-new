
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../layout/layout.dart';
import '../../service/auth.dart';
import '../../shared/cnstant/contant.dart';
import '../../shared/provider/modelHud.dart';
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
  final _auth = Auth();
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  signInWithEmail() async {
    if(formKey.currentState!.validate())
    {
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password:  passwordController.text,
        );
        var user= dprf.child('user').get().then((DataSnapshot dataSnapshot) {
          print(dataSnapshot.value.toString());
        });

        print(credential.user);
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(msg: "No user found for that email.");
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(msg: "Wrong password provided for that user.");
          print('Wrong password provided for that user.');
        }
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
                                height: 30,
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
                        MaterialButton(onPressed: ()async{
                          var userData=await signInWithEmail();
                          if(userData!=null){
                            Navigator.pushAndRemoveUntil(
                                context,MaterialPageRoute(
                                builder: (context)=> const NavigationBottom()
                            ),
                                    (Route<dynamic>  route) => false
                            );
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
                              MaterialButton(onPressed: ()async{
                               var userData=await signInWithGoogle();
                               if(userData!=null){
                                 Navigator.pushAndRemoveUntil(
                                     context,MaterialPageRoute(
                                     builder: (context)=> const NavigationBottom()
                                 ),
                                         (Route<dynamic>  route) => false
                                 );
                               }
                              },
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
