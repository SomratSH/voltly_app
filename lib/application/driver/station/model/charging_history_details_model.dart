class CharingHistoryDetailsModel {
  VehicleInformation? vehicleInformation;
  StationInformation? stationInformation;
  ChargeDetails? chargeDetails;
  Timing? timing;

  CharingHistoryDetailsModel({
    this.vehicleInformation,
    this.stationInformation,
    this.chargeDetails,
    this.timing,
  });

  CharingHistoryDetailsModel.fromJson(Map<String, dynamic> json) {
    vehicleInformation = json['vehicle_information'] != null
        ? new VehicleInformation.fromJson(json['vehicle_information'])
        : null;
    stationInformation = json['station_information'] != null
        ? new StationInformation.fromJson(json['station_information'])
        : null;
    chargeDetails = json['charge_details'] != null
        ? new ChargeDetails.fromJson(json['charge_details'])
        : null;
    timing = json['timing'] != null
        ? new Timing.fromJson(json['timing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicleInformation != null) {
      data['vehicle_information'] = this.vehicleInformation!.toJson();
    }
    if (this.stationInformation != null) {
      data['station_information'] = this.stationInformation!.toJson();
    }
    if (this.chargeDetails != null) {
      data['charge_details'] = this.chargeDetails!.toJson();
    }
    if (this.timing != null) {
      data['timing'] = this.timing!.toJson();
    }
    return data;
  }
}

class VehicleInformation {
  String? licensePlate;
  String? vehicleName;

  VehicleInformation({this.licensePlate, this.vehicleName});

  VehicleInformation.fromJson(Map<String, dynamic> json) {
    licensePlate = json['license_plate'];
    vehicleName = json['vehicle_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['license_plate'] = this.licensePlate;
    data['vehicle_name'] = this.vehicleName;
    return data;
  }
}

class StationInformation {
  String? operator;
  String? stationName;
  double? rating;
  String? openStatus;
  String? openingTime;
  String? closingTime;

  StationInformation({
    this.operator,
    this.stationName,
    this.rating,
    this.openStatus,
    this.openingTime,
    this.closingTime,
  });

  StationInformation.fromJson(Map<String, dynamic> json) {
    operator = json['operator'];
    stationName = json['station_name'];
    rating = json['rating'];
    openStatus = json['open_status'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['operator'] = this.operator;
    data['station_name'] = this.stationName;
    data['rating'] = this.rating;
    data['open_status'] = this.openStatus;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    return data;
  }
}

class ChargeDetails {
  String? chargingFee;
  String? chargingRate;
  String? platformFee;
  String? totalFee;

  ChargeDetails({
    this.chargingFee,
    this.chargingRate,
    this.platformFee,
    this.totalFee,
  });

  ChargeDetails.fromJson(Map<String, dynamic> json) {
    chargingFee = json['charging_fee'];
    chargingRate = json['charging_rate'];
    platformFee = json['platform_fee'];
    totalFee = json['total_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charging_fee'] = this.chargingFee;
    data['charging_rate'] = this.chargingRate;
    data['platform_fee'] = this.platformFee;
    data['total_fee'] = this.totalFee;
    return data;
  }
}

class Timing {
  String? startCharging;
  String? finishCharging;

  Timing({this.startCharging, this.finishCharging});

  Timing.fromJson(Map<String, dynamic> json) {
    startCharging = json['start_charging'];
    finishCharging = json['finish_charging'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_charging'] = this.startCharging;
    data['finish_charging'] = this.finishCharging;
    return data;
  }
}
