import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:svm_app/shared/cnstant/contant.dart';


class machines extends StatefulWidget {
  const machines({Key? key}) : super(key: key);

  @override
  State<machines> createState() => _machinesState();
}

class _machinesState extends State<machines> {
 final List machines=[
    'agezy',
    'segar',
   'albahr',
   'main',
  ];
 // List<bool> favoritecontrol=List.filled(4,   favoritecoler);
 List<int> selectedItem = [];
 double? _ratingValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
          itemCount: machines.length ,
          // clipBehavior: Clip.none,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
              childAspectRatio: 400 / (1850 / 4)),

          itemBuilder: (context,index){
            return Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(30))

                ),
                child: SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //machines image
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft:Radius.circular(30),
                            topRight:Radius.circular(30),
                          ) ,
                          border: Border.all(color: Colors.black),
                          image: DecorationImage(
                            image: AssetImage(
                              'images/firstentry.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //listtile
                      SizedBox(
                        height: 40,
                        child: ListTile(
                          title:Text("${machines[index]}",style: TextStyle(fontSize: 20),) ,
                          // subtitle:Text("all ptoduct",style: TextStyle(fontSize: 20)) ,
                          // horizontalTitleGap: 20,
                          trailing:IconButton(
                            onPressed: ()async {
                              toggleIconView(index);

                            },
                            icon: Icon(selectedItem.contains(index)
                                ? Icons.favorite
                                : Icons.favorite_border),
                            color: selectedItem.contains(index) ? Colors.red : Colors.red,
                          ),
                        ),
                      ),
                      //rating icons
                      Container(
                        alignment: Alignment.centerLeft,

                        margin: EdgeInsets.only(left:10,top: 20),
                        child: RatingBar(
                            initialRating: 0,
                            itemSize: 25,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                                full: const Icon(Icons.star, color: Colors.orange),
                                half: const Icon(
                                  Icons.star_half,
                                  color: Colors.orange,
                                ),
                                empty: const Icon(
                                  Icons.star_outline,
                                  color: Colors.orange,
                                )),
                            onRatingUpdate: (value) {
                              setState(() {
                                _ratingValue = value;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),

    );

  }
 void toggleIconView(int index) {
   if (selectedItem.contains(index)) {
     selectedItem.remove(index);
   } else {
     selectedItem.add(index);
   }
   setState(() {});
 }
}
