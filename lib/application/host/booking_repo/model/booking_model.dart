class BookingModel {
  int? id;
  String? userName;
  String? userPicture;
  String? vehicleName;
  String? chargerType;
  String? plugType;
  String? bookingDate;
  String? status;
  String? startTime;
  String? endTime;
  String? stationName;
  String? locationArea;
  List<Reviews>? reviews;

  BookingModel(
      {this.id,
      this.userName,
      this.userPicture,
      this.vehicleName,
      this.chargerType,
      this.plugType,
      this.bookingDate,
      this.status,
      this.startTime,
      this.endTime,
      this.stationName,
      this.locationArea,
      this.reviews});

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    userPicture = json['user_picture'];
    vehicleName = json['vehicle_name'];
    chargerType = json['charger_type'];
    plugType = json['plug_type'];
    bookingDate = json['booking_date'];
    status = json['status'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    stationName = json['station_name'];
    locationArea = json['location_area'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['user_picture'] = this.userPicture;
    data['vehicle_name'] = this.vehicleName;
    data['charger_type'] = this.chargerType;
    data['plug_type'] = this.plugType;
    data['booking_date'] = this.bookingDate;
    data['status'] = this.status;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['station_name'] = this.stationName;
    data['location_area'] = this.locationArea;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
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
