import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../layout/layout.dart';
import '../../service/imageBanner.dart';
import '../../service/machinesView.dart';
import '../Drawer/drawer.dart';
import '../My machines/my machine.dart';
import '../search/search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

        centerTitle: true,

        title: Container(
            // margin: EdgeInsets.only(left: 25,bottom: 10),
            child:
            Text("Home",
            )
          // style: TextStyle(fontSize: 40),
        ),
        // backgroundColor:Colors.red[700],

        leading: Builder(
          builder: (BuildContext context) {
            return Container(
              // margin: EdgeInsets.only(bottom: 10,left: 5),
              child: IconButton(
                icon: const Icon(Icons.menu,),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            );
          },
        ),
        actions: [
          Container(
            // margin: EdgeInsets.only(bottom: 10,right: 5),
            child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const SearchPage()));
              },
              icon:  Icon(Icons.search,),
            ),
          )
        ],

      ),
      drawer: Drawer(
        child: drawerview(),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Bannerview(),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return MyMachine();
                        },
                      ),
                    );
                  },
                  child: machines()
              ),

            ]
        ),
      ),
    );
  }
}

