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
  int? averageRating;
  Host? host;
  List<Reviews>? reviews;
  double? distanceKm;
  double? timeToReachMin;
  List<Chargers>? chargers;

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

  StationDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stationName = json['station_name'];
    locationArea = json['location_area'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    image = json['image'];
    averageRating = json['average_rating'];
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    distanceKm = json['distance_km'];
    timeToReachMin = json['time_to_reach_min'];
    if (json['chargers'] != null) {
      chargers = <Chargers>[];
      json['chargers'].forEach((v) {
        chargers!.add(new Chargers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['station_name'] = this.stationName;
    data['location_area'] = this.locationArea;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['image'] = this.image;
    data['average_rating'] = this.averageRating;
    if (this.host != null) {
      data['host'] = this.host!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['distance_km'] = this.distanceKm;
    data['time_to_reach_min'] = this.timeToReachMin;
    if (this.chargers != null) {
      data['chargers'] = this.chargers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Host {
  int? id;
  String? fullName;
  String? email;
  String? phone;

  Host({this.id, this.fullName, this.email, this.phone});

  Host.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Reviews {
  int? chargingStation;
  int? rating;
  String? comment;

  Reviews({this.chargingStation, this.rating, this.comment});

  Reviews.fromJson(Map<String, dynamic> json) {
    chargingStation = json['charging_station'];
    rating = json['rating'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charging_station'] = this.chargingStation;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    return data;
  }
}

class Chargers {
  int? id;
  String? name;
  String? chargerType;
  String? mode;
  dynamic? price;
  bool? available;
  List<String>? plugTypes;
  List<String>? connectorTypes;

  Chargers({
    this.id,
    this.name,
    this.chargerType,
    this.mode,
    this.price,
    this.available,
    this.plugTypes,
    this.connectorTypes,
  });

  Chargers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    chargerType = json['charger_type'];
    mode = json['mode'];
    price = json['price'];
    available = json['available'];
    plugTypes = json['plug_types'].cast<String>();
    connectorTypes = json['connector_types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['charger_type'] = this.chargerType;
    data['mode'] = this.mode;
    data['price'] = this.price;
    data['available'] = this.available;
    data['plug_types'] = this.plugTypes;
    data['connector_types'] = this.connectorTypes;
    return data;
  }
}
