class Product {
  late int id;
  late String name;
  late String price;
  late String picture;
  late String link;
  late String sku;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.picture,
    required this.link,
    required this.sku,
  });

  Product.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
    picture = map['picture'];
    link = map['link'];
    sku = map['sku'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
