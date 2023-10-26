class Market {
  late int id;
  late String name;
  late String website;

  Market({
    required this.id,
    required this.name,
    required this.website,
  });

  Market.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    website = map['website'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'website' : website,
    };
  }
}