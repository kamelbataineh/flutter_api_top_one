class Productmodel {
  String? id;
  String? name;
  double? price;
  String? description;

  Productmodel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory Productmodel.toMap(Map<String, dynamic> map) {
    return Productmodel(
        id: map['id'].toString(),
        name: map['name'].toString(),
        price: (map['price'] as num).toDouble(),
        description: map['description'] ?? 'nothing');
  }
}
