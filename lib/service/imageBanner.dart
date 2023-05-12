import 'package:flutter/material.dart';

class Bannerview extends StatelessWidget {
  const Bannerview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 225,

        child: PageView(
          children: [
            Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(30) ,
               border: Border.all(color: Colors.black),
              image: DecorationImage(
                    image: AssetImage(
                      'images/homeimage.jpg',
                    ),
                    fit: BoxFit.fill,
                  ),
             ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30) ,
                border: Border.all(color: Colors.black),
                image: DecorationImage(
                  image: AssetImage(
                    'images/homeimage.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30) ,
                border: Border.all(color: Colors.black),
                image: DecorationImage(
                  image: AssetImage(
                    'images/homeimage.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}