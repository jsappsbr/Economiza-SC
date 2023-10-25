class Store {
  late int id;
  late String name;
  late String website;

  Store({
    required this.id,
    required this.name,
    required this.website,
  });

  Store.fromMap(Map<String, dynamic> map) {
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