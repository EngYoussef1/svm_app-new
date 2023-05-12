class CardItem {
  String name;
  String detils;
  int qty;
  String price;

  // I've defined some default values but it could be anything else
  CardItem({required this.name,required this.detils, this.qty = 0, this.price = "\$10"});
}