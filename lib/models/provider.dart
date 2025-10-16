class Provider {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String state;

  Provider({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    this.state = 'Activo',
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['provider_id'] ?? 0,
      name: json['provider_name'] ?? '',
      lastName: json['provider_last_name'] ?? '',
      email: json['provider_mail'] ?? '',
      state: json['provider_state'] ?? 'Activo',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider_id': id,
      'provider_name': name,
      'provider_last_name': lastName,
      'provider_mail': email,
      'provider_state': state,
    };
  }

  Map<String, dynamic> toJsonForAdd() {
    return {
      'provider_name': name,
      'provider_last_name': lastName,
      'provider_mail': email,
      'provider_state': state,
    };
  }

  String get fullName => '$name $lastName';
}