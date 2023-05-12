import 'package:flutter/material.dart';


import '../modules/My cart/my cart.dart';
import '../modules/favorites/favorite.dart';
import '../modules/home/home.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int choosenbar=0;
  List<Widget> screens=[
    FavouritePage(),
    Home(),
    MyCart(),

  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:screens[choosenbar] ,
      bottomNavigationBar: Container(
        child: BottomNavigationBar(


          currentIndex: choosenbar,
          onTap: (index){
            setState(() {
              choosenbar=index;
              if (choosenbar == 3 && _scaffoldKey.currentState != null) {
                _scaffoldKey.currentState!.openDrawer();
              }
              print(index);
            });

          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'favorite'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'my cart'
            ),
          ],

        ),
      ),
    );
  }
}