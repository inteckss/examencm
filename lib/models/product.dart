class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String state;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.state = 'Activo',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'] ?? 0,
      name: json['product_name'] ?? '',
      price: (json['product_price'] ?? 0).toDouble(),
      imageUrl: json['product_image'] ?? '',
      state: json['product_state'] ?? 'Activo',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'product_name': name,
      'product_price': price,
      'product_image': imageUrl,
      'product_state': state,
    };
  }

  Map<String, dynamic> toJsonForAdd() {
    return {
      'product_name': name,
      'product_price': price,
      'product_image': imageUrl,
    };
  }
}