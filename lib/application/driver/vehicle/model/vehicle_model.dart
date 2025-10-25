class VehicleModel {
  int? id;
  String? user;
  String? vehicleType;
  String? vehicleName;
  String? registrationNumber;
  String? plugType;
  String? batteryType;
  String? batteryCapacity;
  String? image;

  VehicleModel(
      {this.id,
      this.user,
      this.vehicleType,
      this.vehicleName,
      this.registrationNumber,
      this.plugType,
      this.batteryType,
      this.batteryCapacity,
      this.image});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    vehicleType = json['vehicle_type'];
    vehicleName = json['vehicle_name'];
    registrationNumber = json['registration_number'];
    plugType = json['plug_type'];
    batteryType = json['battery_type'];
    batteryCapacity = json['battery_capacity'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_name'] = this.vehicleName;
    data['registration_number'] = this.registrationNumber;
    data['plug_type'] = this.plugType;
    data['battery_type'] = this.batteryType;
    data['battery_capacity'] = this.batteryCapacity;
    data['image'] = this.image;
    return data;
  }
}
