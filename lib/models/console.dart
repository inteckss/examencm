class Console {
  final int id;
  final String name;
  final String manufacturer;
  final int year;
  final String description;
  final String imageUrl;

  Console({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.year,
    required this.description,
    required this.imageUrl,
  });

  factory Console.fromJson(Map<String, dynamic> json) {
    return Console(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      year: json['year'] ?? 0,
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'manufacturer': manufacturer,
      'year': year,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}

class Joystick {
  final int id;
  final String name;
  final String type;
  final String imageUrl;
  final int consoleId;
  final String connectivity;
  final bool isWireless;

  Joystick({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.consoleId,
    required this.connectivity,
    this.isWireless = false,
  });

  factory Joystick.fromJson(Map<String, dynamic> json) {
    return Joystick(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      consoleId: json['consoleId'] ?? 0,
      connectivity: json['connectivity'] ?? '',
      isWireless: json['isWireless'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'imageUrl': imageUrl,
      'consoleId': consoleId,
      'connectivity': connectivity,
      'isWireless': isWireless,
    };
  }
}