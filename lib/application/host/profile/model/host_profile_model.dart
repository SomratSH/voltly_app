class HostProfileModel {
  String? message;
  Data? data;

  HostProfileModel({this.message, this.data});

  HostProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? fullName;
  String? email;
  String? phone;
  String? picture;
  ChargingStation? chargingStation;

  Data({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.picture,
    this.chargingStation,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    picture = json['picture'];
    chargingStation = json['charging_station'] != null
        ? new ChargingStation.fromJson(json['charging_station'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['picture'] = this.picture;
    if (this.chargingStation != null) {
      data['charging_station'] = this.chargingStation!.toJson();
    }
    return data;
  }
}

class ChargingStation {
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
  // List<Null>? reviews;

  ChargingStation({
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
    // this.reviews,
  });

  ChargingStation.fromJson(Map<String, dynamic> json) {
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
    // if (json['reviews'] != null) {
    //   reviews = <Null>[];
    //   json['reviews'].forEach((v) {
    //     reviews!.add(new Null.fromJson(v));
    //   });
    // }
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
    // if (this.reviews != null) {
    //   data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    // }
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
