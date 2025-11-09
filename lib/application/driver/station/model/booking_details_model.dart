class BookingDetailsModel {
  Vehicle? vehicle;
  ChargingStation? chargingStation;
  BookingDetails? bookingDetails;
  Pricing? pricing;

  BookingDetailsModel({
    this.vehicle,
    this.chargingStation,
    this.bookingDetails,
    this.pricing,
  });

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    vehicle = json['vehicle'] != null
        ? new Vehicle.fromJson(json['vehicle'])
        : null;
    chargingStation = json['charging_station'] != null
        ? new ChargingStation.fromJson(json['charging_station'])
        : null;
    bookingDetails = json['booking_details'] != null
        ? new BookingDetails.fromJson(json['booking_details'])
        : null;
    pricing = json['pricing'] != null
        ? new Pricing.fromJson(json['pricing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.toJson();
    }
    if (this.chargingStation != null) {
      data['charging_station'] = this.chargingStation!.toJson();
    }
    if (this.bookingDetails != null) {
      data['booking_details'] = this.bookingDetails!.toJson();
    }
    if (this.pricing != null) {
      data['pricing'] = this.pricing!.toJson();
    }
    return data;
  }
}

class Vehicle {
  String? model;
  String? plugType;
  String? bookingStatus;

  Vehicle({this.model, this.plugType, this.bookingStatus});

  Vehicle.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    plugType = json['plug_type'];
    bookingStatus = json['booking_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['plug_type'] = this.plugType;
    data['booking_status'] = this.bookingStatus;
    return data;
  }
}

class ChargingStation {
  String? stationName;
  String? status;
  String? openTime;
  String? closeTime;
  double? rating;

  ChargingStation({
    this.stationName,
    this.status,
    this.openTime,
    this.closeTime,
    this.rating,
  });

  ChargingStation.fromJson(Map<String, dynamic> json) {
    stationName = json['station_name'];
    status = json['status'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['station_name'] = this.stationName;
    data['status'] = this.status;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['rating'] = this.rating;
    return data;
  }
}

class BookingDetails {
  int? id;
  String? bookingDate;
  String? chargingDuration;
  String? chargingSessionTiming;

  BookingDetails({
    this.bookingDate,
    this.chargingDuration,
    this.chargingSessionTiming,
    this.id,
  });

  BookingDetails.fromJson(Map<String, dynamic> json) {
    bookingDate = json['booking_date'];
    id = json['booking_id'];
    chargingDuration = json['charging_duration'];
    chargingSessionTiming = json['charging_session_timing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_date'] = this.bookingDate;
    data['charging_duration'] = this.chargingDuration;
    data['charging_session_timing'] = this.chargingSessionTiming;
    return data;
  }
}

class Pricing {
  String? hourlyRate;
  String? subtotal;
  String? platformFee;
  String? totalAmount;

  Pricing({this.hourlyRate, this.subtotal, this.platformFee, this.totalAmount});

  Pricing.fromJson(Map<String, dynamic> json) {
    hourlyRate = json['hourly_rate'];
    subtotal = json['subtotal'];
    platformFee = json['platform_fee'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hourly_rate'] = this.hourlyRate;
    data['subtotal'] = this.subtotal;
    data['platform_fee'] = this.platformFee;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}
