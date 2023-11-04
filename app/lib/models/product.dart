class Product {
  late int id;
  late int marketId;
  late String name;
  late double price;
  late String picture;
  late String link;
  late String sku;

  Product({
    required this.id,
    required this.marketId,
    required this.name,
    required this.price,
    required this.picture,
    required this.link,
    required this.sku,
  });

  Product.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    marketId = map['market_id'];
    name = map['name'];
    price = map['price'].toDouble();
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
