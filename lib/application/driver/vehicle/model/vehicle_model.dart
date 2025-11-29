class VehicleModel {
  int? id;
  String? registrationNumber;
  int? vehicle;
  VehicleDetails? vehicleDetails;
  int? selectedPlug;
  String? selectedPlugName;
  String? unitsValue;
  String? timeValue;
  bool? isDefault;
  String? image;

  VehicleModel({
    this.id,
    this.registrationNumber,
    this.vehicle,
    this.vehicleDetails,
    this.selectedPlug,
    this.selectedPlugName,
    this.unitsValue,
    this.timeValue,
    this.isDefault,
    this.image,
  });

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registrationNumber = json['registration_number'];
    vehicle = json['vehicle'];
    vehicleDetails = json['vehicle_details'] != null
        ? new VehicleDetails.fromJson(json['vehicle_details'])
        : null;
    selectedPlug = json['selected_plug'];
    selectedPlugName = json['selected_plug_name'];
    unitsValue = json['units_value'];
    timeValue = json['time_value'];
    isDefault = json['is_default'];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['registration_number'] = this.registrationNumber;
    data['vehicle'] = this.vehicle;
    if (this.vehicleDetails != null) {
      data['vehicle_details'] = this.vehicleDetails!.toJson();
    }
    data['selected_plug'] = this.selectedPlug;
    data['selected_plug_name'] = this.selectedPlugName;
    data['units_value'] = this.unitsValue;
    data['time_value'] = this.timeValue;
    data['is_default'] = this.isDefault;
    return data;
  }
}

class VehicleDetails {
  int? id;
  String? name;
  String? vehicleType;
  String? batteryType;
  String? unitsPerTime;
  String? batteryCapacity;
  String? chargingTime;
  String? image;

  VehicleDetails({
    this.id,
    this.name,
    this.vehicleType,
    this.batteryType,
    this.unitsPerTime,
    this.batteryCapacity,
    this.chargingTime,
    this.image,
  });

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    vehicleType = json['vehicle_type'];
    batteryType = json['battery_type'];
    unitsPerTime = json['units_per_time'];
    batteryCapacity = json['battery_capacity'];
    chargingTime = json['charging_time'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['vehicle_type'] = this.vehicleType;
    data['battery_type'] = this.batteryType;
    data['units_per_time'] = this.unitsPerTime;
    data['battery_capacity'] = this.batteryCapacity;
    data['charging_time'] = this.chargingTime;
    data['image'] = this.image;
    return data;
  }
}
