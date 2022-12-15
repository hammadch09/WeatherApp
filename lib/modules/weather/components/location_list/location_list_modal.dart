import 'dart:convert';

class AddressModel {
  AddressModel({
      this.city,
      this.country,
      required this.latitude,
      required this.longitude
  });

  factory AddressModel.fromJson(Map<String, dynamic> jsonData) {
    return AddressModel(
      longitude: jsonData['longitude'],
      latitude: jsonData['latitude'],
      city: jsonData['city'],
      country: jsonData['country']
    );
  }

  Map<String, dynamic> toJson() => {
    'city': city,
    'country': country,
    'latitude': latitude,
    'longitude': longitude
  };

  String? city;
  String? country;
  double latitude;
  double longitude;
}
