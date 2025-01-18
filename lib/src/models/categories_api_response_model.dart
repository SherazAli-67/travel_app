class CategoryApiResponse {
  final List<LocationData> data;

  CategoryApiResponse({required this.data});

  factory CategoryApiResponse.fromJson(Map<String, dynamic> json) {
    return CategoryApiResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => LocationData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class LocationData {
  final String locationId;
  final String name;
  final Address address;

  LocationData({
    required this.locationId,
    required this.name,
    required this.address,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      locationId: json['location_id'] ?? '',
      name: json['name'] ?? '',
      address: Address.fromJson(json['address_obj'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location_id': locationId,
      'name': name,
      'address_obj': address.toJson(),
    };
  }
}

class Address {
  final String street1;
  final String street2;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final String addressString;

  Address({
    this.street1 = '',
    this.street2 = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.postalCode = '',
    this.addressString = '',
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street1: json['street1'] ?? '',
      street2: json['street2'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      postalCode: json['postalcode'] ?? '',
      addressString: json['address_string'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street1': street1,
      'street2': street2,
      'city': city,
      'state': state,
      'country': country,
      'postalcode': postalCode,
      'address_string': addressString,
    };
  }
}