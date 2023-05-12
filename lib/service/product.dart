
import 'package:flutter/material.dart';
import '../../shared/componant/counter_operations.dart';
class products extends StatefulWidget {
  const products({Key? key}) : super(key: key);

  @override
  State<products> createState() => _productsState();
}

class _productsState extends State<products> {
  List products=[
    'Chipsy',
    'Domty',
    'Tiger',
  ];
  List productsdetails=[
    'chease',
    'mango',
    'chease',
  ];
  List<int> selectedItem = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView.builder(
            itemCount:products.length ,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          //product image
                          child: Container(
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),

                              // border: Border.all(color: Colors.black),
                              image: DecorationImage(
                                image: AssetImage(
                                  'images/firstentry.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            //name , close icon
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              height: 55,
                              width: 200,
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 1),
                                title: Text('${products[index]}',style: TextStyle(fontSize: 25),),
                                subtitle: Text('${productsdetails[index]}',style: TextStyle(fontSize: 25 ,color: Colors.grey),),
                                trailing: IconButton(
                                  onPressed: () {
                                    toggleIconView(index);
                                  },
                                  iconSize: 40,
                                  icon: Icon(selectedItem.contains(index)
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                                  color: selectedItem.contains(index) ? Colors.red : Colors.red,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 90,
                                  ),
                                  IconButton(
                                    alignment: Alignment.centerRight,
                                      iconSize: 35,
                                      onPressed: (){
                                      setState(() {
                                        decrementCounter();
                                      });


                                      },
                                      icon:Icon(Icons.remove_circle_outline
                                      )
                                  ),
                                  Text('$counter',style: TextStyle(fontSize: 35),),
                                  IconButton(
                                      iconSize: 35,
                                      onPressed: (){
                                        setState(() {
                                          incrementCounter();
                                        });
                                      },
                                      icon:Icon(Icons.add_circle_outline
                                      )
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10,right: 10),
                              child: Container(
                                width: 200,
                                child: Divider(
                                  height: 3,
                                  thickness: 2,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    // width: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text("Total",style: TextStyle(fontSize: 25),),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                      child: Text('\$16',style: TextStyle(fontSize: 25),)
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
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
