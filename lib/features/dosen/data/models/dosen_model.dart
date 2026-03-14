class DosenModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final AdressModel address;

  DosenModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
  });

  factory DosenModel.fromJson(Map<String, dynamic> json) {
    final addressJson = json['address'];

    return DosenModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      name: json['name']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      address: addressJson is Map<String, dynamic>
          ? AdressModel.fromJson(addressJson)
          : AdressModel.fromJson(const <String, dynamic>{}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'address': address.toJson(),
    };
  }
}

class AdressModel {
  final String street;
  final String suite;
  final String city;
  final String zipcode;

  AdressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  factory AdressModel.fromJson(Map<String, dynamic> json) {
    return AdressModel(
      street: json['street']?.toString() ?? '',
      suite: json['suite']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      zipcode: json['zipcode']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
    };
  }
}