class MedicineItem {
  String name;
  String category;
  double price;
  String imageLink;
  String benefits;
  String howToUse;
  bool inStock;

  MedicineItem({
    required this.name,
    required this.category,
    required this.price,
    required this.imageLink,
    required this.benefits,
    required this.howToUse,
    required this.inStock,
  });
}
