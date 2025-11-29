class BookingDetailsModel {
  Vehicle? vehicle;
  Charger? charger;
  ChargingStation? chargingStation;
  BookingDetails? bookingDetails;
  Pricing? pricing;

  BookingDetailsModel({
    this.vehicle,
    this.charger,
    this.chargingStation,
    this.bookingDetails,
    this.pricing,
  });

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    vehicle = json['vehicle'] != null
        ? new Vehicle.fromJson(json['vehicle'])
        : null;
    charger = json['charger'] != null
        ? new Charger.fromJson(json['charger'])
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
    if (this.charger != null) {
      data['charger'] = this.charger!.toJson();
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

class Charger {
  String? name;
  String? scannerCode;
  String? chargerType;
  List<String>? plugTypes;
  String? powerRatingKw;

  Charger({
    this.name,
    this.scannerCode,
    this.chargerType,
    this.plugTypes,
    this.powerRatingKw,
  });

  Charger.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    scannerCode = json['scanner_code'];
    chargerType = json['charger_type'];
    plugTypes = json['plug_types'].cast<String>();
    powerRatingKw = json['power_rating_kw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['scanner_code'] = this.scannerCode;
    data['charger_type'] = this.chargerType;
    data['plug_types'] = this.plugTypes;
    data['power_rating_kw'] = this.powerRatingKw;
    return data;
  }
}

class ChargingStation {
  String? stationName;
  String? status;
  String? openTime;
  String? closeTime;
  String? rating;
  String? image;

  ChargingStation({
    this.stationName,
    this.status,
    this.openTime,
    this.image,
    this.closeTime,
    this.rating,
  });

  ChargingStation.fromJson(Map<String, dynamic> json) {
    stationName = json['station_name'];
    status = json['status'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    rating = json['rating'];
    image = json['image'];
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
  int? bookingId;
  String? bookingDate;
  String? status;
  String? chargingDuration;
  String? chargingSessionTiming;

  BookingDetails({
    this.bookingId,
    this.bookingDate,
    this.status,
    this.chargingDuration,
    this.chargingSessionTiming,
  });

  BookingDetails.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingDate = json['booking_date'];
    status = json['status'];
    chargingDuration = json['charging_duration'];
    chargingSessionTiming = json['charging_session_timing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['booking_date'] = this.bookingDate;
    data['status'] = this.status;
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
