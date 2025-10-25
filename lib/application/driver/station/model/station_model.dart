class StationModel {
  int? id;
  String? host;
  String? name;
  String? address;
  double? latitude;
  double? longitude;
  String? googlePlaceId;
  String? locationName;
  Details? details;
  double? distanceKm;
  double? timeToReachMin;

  StationModel({
    this.id,
    this.host,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.googlePlaceId,
    this.locationName,
    this.details,
    this.distanceKm,
    this.timeToReachMin,
  });

  StationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    host = json['host'];
    name = json['name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    googlePlaceId = json['google_place_id'];
    locationName = json['location_name'];
    details = json['details'] != null
        ? new Details.fromJson(json['details'])
        : null;
    distanceKm = json['distance_km'];
    timeToReachMin = json['time_to_reach_min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['host'] = this.host;
    data['name'] = this.name;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['google_place_id'] = this.googlePlaceId;
    data['location_name'] = this.locationName;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['distance_km'] = this.distanceKm;
    data['time_to_reach_min'] = this.timeToReachMin;
    return data;
  }
}

class Details {
  String? scannerCode;
  String? chargerType;
  String? chargerLevel;
  String? pricePerHour;
  String? pricePerKwh;
  bool? available;
  bool? available247;
  List<String>? availableDays;
  List<String>? extendedChargingOptions;
  String? image;

  Details({
    this.scannerCode,
    this.chargerType,
    this.chargerLevel,
    this.pricePerHour,
    this.pricePerKwh,
    this.available,
    this.available247,
    this.availableDays,
    this.extendedChargingOptions,
    this.image,
  });

  Details.fromJson(Map<String, dynamic> json) {
    scannerCode = json['scanner_code'];
    chargerType = json['charger_type'];
    chargerLevel = json['charger_level'];
    pricePerHour = json['price_per_hour'];
    pricePerKwh = json['price_per_kwh'];
    available = json['available'];
    available247 = json['available_24_7'];
    availableDays = json['available_days'].cast<String>();
    extendedChargingOptions = json['extended_charging_options'].cast<String>();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scanner_code'] = this.scannerCode;
    data['charger_type'] = this.chargerType;
    data['charger_level'] = this.chargerLevel;
    data['price_per_hour'] = this.pricePerHour;
    data['price_per_kwh'] = this.pricePerKwh;
    data['available'] = this.available;
    data['available_24_7'] = this.available247;
    data['available_days'] = this.availableDays;
    data['extended_charging_options'] = this.extendedChargingOptions;
    data['image'] = this.image;
    return data;
  }
}
