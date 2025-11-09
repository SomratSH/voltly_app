class CharingHistoryModel {
  List<History>? history;

  CharingHistoryModel({this.history});

  CharingHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  int? bookingId;
  String? vehicleName;
  String? plugType;
  String? stationName;
  String? bookingDate;
  String? usageKwh;
  String? price;

  History({
    this.bookingId,
    this.vehicleName,
    this.plugType,
    this.stationName,
    this.bookingDate,
    this.usageKwh,
    this.price,
  });

  History.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    vehicleName = json['vehicle_name'];
    plugType = json['plug_type'];
    stationName = json['station_name'];
    bookingDate = json['booking_date'];
    usageKwh = json['usage_kwh'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['vehicle_name'] = this.vehicleName;
    data['plug_type'] = this.plugType;
    data['station_name'] = this.stationName;
    data['booking_date'] = this.bookingDate;
    data['usage_kwh'] = this.usageKwh;
    data['price'] = this.price;
    return data;
  }
}
