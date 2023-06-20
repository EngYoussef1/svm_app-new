import 'package:firebase_database/firebase_database.dart';

class CardItem {


  String name;
  String details;
  int amount;
  String price;
  bool isFavorite;

  // I've defined some default values but it could be anything else
  CardItem({
    required this.name,
    required this.details,
    this.amount = 0,
    this.price = "\$10",
    this.isFavorite=false
  });


}