class VehicleModel {
  int? id;
  String? name;
  String? vehicleType;
  String? batteryType;
  String? unitsPerTime;
  // List<Null>? supportedPlugs;
  String? batteryCapacity;
  String? chargingTime;
  String? image;

  VehicleModel({
    this.id,
    this.name,
    this.vehicleType,
    this.batteryType,
    this.unitsPerTime,
    // this.supportedPlugs,
    this.batteryCapacity,
    this.chargingTime,
    this.image,
  });

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    vehicleType = json['vehicle_type'];
    batteryType = json['battery_type'];
    unitsPerTime = json['units_per_time'];
    // if (json['supported_plugs'] != null) {
    //   supportedPlugs = <Null>[];
    //   json['supported_plugs'].forEach((v) {
    //     supportedPlugs!.add(new Null.fromJson(v));
    //   });
    // }
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
    // if (this.supportedPlugs != null) {
    //   data['supported_plugs'] = this.supportedPlugs!
    //       .map((v) => v.toJson())
    //       .toList();
    // }
    data['battery_capacity'] = this.batteryCapacity;
    data['charging_time'] = this.chargingTime;
    data['image'] = this.image;
    return data;
  }
}
