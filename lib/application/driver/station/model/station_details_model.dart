class StationDetailsModel {
  int? id;
  String? stationName;
  String? locationArea;
  String? address;
  double? latitude;
  double? longitude;
  String? status;
  String? openingTime;
  String? closingTime;
  String? image;
  double? averageRating;
  Host? host;
  List<Review>? reviews;
  double? distanceKm;
  double? timeToReachMin;
  List<Charger>? chargers;

  StationDetailsModel({
    this.id,
    this.stationName,
    this.locationArea,
    this.address,
    this.latitude,
    this.longitude,
    this.status,
    this.openingTime,
    this.closingTime,
    this.image,
    this.averageRating,
    this.host,
    this.reviews,
    this.distanceKm,
    this.timeToReachMin,
    this.chargers,
  });

  factory StationDetailsModel.fromJson(Map<String, dynamic> json) {
    return StationDetailsModel(
      id: json['id'],
      stationName: json['station_name'],
      locationArea: json['location_area'],
      address: json['address'],
      latitude: (json['latitude'] ?? 0.0 as num).toDouble(),
      longitude: (json['longitude'] ?? 0.0 as num).toDouble(),
      status: json['status'],
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],
      image: json['image'],
      averageRating: (json['average_rating'] ?? 0.0 as num).toDouble(),
      host: Host.fromJson(json['host']),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e))
          .toList(),
      distanceKm: (json['distance_km'] as num).toDouble(),
      timeToReachMin: (json['time_to_reach_min'] as num).toDouble(),
      chargers: (json['chargers'] as List<dynamic>)
          .map((e) => Charger.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'station_name': stationName,
    'location_area': locationArea,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'status': status,
    'opening_time': openingTime,
    'closing_time': closingTime,
    'image': image,
    'average_rating': averageRating,
    'host': host?.toJson(),
    'reviews': reviews?.map((e) => e.toJson()).toList(),
    'distance_km': distanceKm,
    'time_to_reach_min': timeToReachMin,
    'chargers': chargers?.map((e) => e.toJson()).toList(),
  };
}

class Host {
  int? id;
  String? fullName;
  String? email;
  String? phone;

  Host({this.id, this.fullName, this.email, this.phone});

  factory Host.fromJson(Map<String, dynamic> json) => Host(
    id: json['id'],
    fullName: json['full_name'],
    email: json['email'],
    phone: json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'email': email,
    'phone': phone,
  };
}

class Review {
  int? chargingStation;
  int? rating;
  String? comment;

  Review({this.chargingStation, this.rating, this.comment});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    chargingStation: json['charging_station'],
    rating: json['rating'],
    comment: json['comment'],
  );

  Map<String, dynamic> toJson() => {
    'charging_station': chargingStation,
    'rating': rating,
    'comment': comment,
  };
}

class Charger {
  int? id;
  String? name;
  String? chargerType;
  String? mode;
  double? price;
  bool? available;
  List<PlugType>? plugTypes;
  List<ConnectorType>? connectorTypes;

  Charger({
    this.id,
    this.name,
    this.chargerType,
    this.mode,
    this.price,
    this.available,
    this.plugTypes,
    this.connectorTypes,
  });

  factory Charger.fromJson(Map<String, dynamic> json) => Charger(
    id: json['id'],
    name: json['name'],
    chargerType: json['charger_type'],
    mode: json['mode'],
    price: (json['price'] as num).toDouble(),
    available: json['available'],
    plugTypes: (json['plug_types'] as List<dynamic>)
        .map((e) => PlugType.fromJson(e))
        .toList(),
    connectorTypes: (json['connector_types'] as List<dynamic>)
        .map((e) => ConnectorType.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'charger_type': chargerType,
    'mode': mode,
    'price': price,
    'available': available,
    'plug_types': plugTypes?.map((e) => e.toJson()).toList(),
    'connector_types': connectorTypes?.map((e) => e.toJson()).toList(),
  };
}

class PlugType {
  int? id;
  String? name;

  PlugType({this.id, this.name});

  factory PlugType.fromJson(Map<String, dynamic> json) =>
      PlugType(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class ConnectorType {
  int? id;
  String? name;

  ConnectorType({this.id, this.name});

  factory ConnectorType.fromJson(Map<String, dynamic> json) =>
      ConnectorType(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
