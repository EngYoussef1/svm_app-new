
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/auth.dart';
import '../../shared/provider/authprovider.dart';
import '../My cart/my cart.dart';
import '../My orders/my order.dart';
import '../favorites/favorite.dart';
import '../hold out/hold out.dart';
import '../home/home.dart';
import '../sign in/sign in.dart';

class drawerview extends StatelessWidget {
   drawerview({Key? key}) : super(key: key);

   User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          margin: EdgeInsets.only(bottom: 10),
          decoration:BoxDecoration(
              color: Colors.red[700],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)
              ),

          ) ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  child:  CircleAvatar(
                    radius: 80,
                    backgroundImage:ExactAssetImage('images/photo.jpg') ,
                  ),
                ),
              ),
              Text(
                "Youssef ashrf",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight:FontWeight.w500,
                    color: Colors.white
                ),
              ),
              Text('${currentUser?.email}',
                 style: TextStyle(
                    fontSize: 25,
                    fontWeight:FontWeight.w500,
                    color: Colors.white
                ),
              ),

            ],
          ),
        ),
        Column(
          children: [
            // MaterialButton(
            //   onPressed: (){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (BuildContext context) {
            //           return Home();
            //         },
            //       ),
            //     );
            //   },
            //   child: ListTile(
            //     leading: Icon(Icons.home,size: 40,),
            //     title: Text("Home",style: TextStyle(fontSize: 25),),
            //   ),
            // ),
            // MaterialButton(
            //   onPressed: (){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (BuildContext context) {
            //           return FavouritePage();
            //         },
            //       ),
            //     );
            //   },
            //   child: ListTile(
            //     leading: Icon(Icons.favorite,size: 40,),
            //     title: Text("favorite",style: TextStyle(fontSize: 25),),
            //   ),
            // ),
            // MaterialButton(
            //   onPressed: (){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (BuildContext context) {
            //           return MyCart();
            //         },
            //       ),
            //     );
            //   },
            //   child: ListTile(
            //     leading: Icon(Icons.shopping_cart,size: 40,),
            //     title: Text("my cart",style: TextStyle(fontSize: 25),),
            //   ),
            // ),
            MaterialButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MyOrders();
                    },
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.shopping_bag,size: 40,),
                title: Text("My Orders",style: TextStyle(fontSize: 25),),
              ),
            ),
            MaterialButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return holdout();
                    },
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.hourglass_full,size: 40,),
                title: Text("hold out",style: TextStyle(fontSize: 25),),
              ),
            ),
            MaterialButton(
              onPressed: (){},
              child: ListTile(
                leading: Icon(Icons.person,size: 40,),
                title: Text("Profile",style: TextStyle(fontSize: 25),),
              ),
            ),
            MaterialButton(
              onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,MaterialPageRoute(
                    builder: (context)=> const Sign_in()
                ),
                        (Route<dynamic>  route) => false
                );
              },
              child: ListTile(
                leading: Icon(Icons.logout,size: 40,),
                title: Text("Sign out",style: TextStyle(fontSize: 25),),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
