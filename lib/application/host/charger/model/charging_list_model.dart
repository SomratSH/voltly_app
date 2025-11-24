class ChargingListModel {
  int? id;
  String? name;
  String? scannerCode;
  String? scannerImage;
  int? station;
  int? chargerType;
  List<int>? plugTypes;
  List<int>? connectorTypes;
  StationDetails? stationDetails;
  String? mode;
  String? price;
  bool? available;
  bool? open247;
  bool? isActive;
  bool? isDefault;

  ChargingListModel(
      {this.id,
      this.name,
      this.scannerCode,
      this.scannerImage,
      this.station,
      this.chargerType,
      this.plugTypes,
      this.connectorTypes,
      this.stationDetails,
      this.mode,
      this.price,
      this.available,
      this.open247,
      this.isActive,
      this.isDefault});

  ChargingListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    scannerCode = json['scanner_code'];
    scannerImage = json['scanner_image'];
    station = json['station'];
    chargerType = json['charger_type'];
    plugTypes = json['plug_types'].cast<int>();
    connectorTypes = json['connector_types'].cast<int>();
    stationDetails = json['station_details'] != null
        ? new StationDetails.fromJson(json['station_details'])
        : null;
    mode = json['mode'];
    price = json['price'];
    available = json['available'];
    open247 = json['open_24_7'];
    isActive = json['is_active'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['scanner_code'] = this.scannerCode;
    data['scanner_image'] = this.scannerImage;
    data['station'] = this.station;
    data['charger_type'] = this.chargerType;
    data['plug_types'] = this.plugTypes;
    data['connector_types'] = this.connectorTypes;
    if (this.stationDetails != null) {
      data['station_details'] = this.stationDetails!.toJson();
    }
    data['mode'] = this.mode;
    data['price'] = this.price;
    data['available'] = this.available;
    data['open_24_7'] = this.open247;
    data['is_active'] = this.isActive;
    data['is_default'] = this.isDefault;
    return data;
  }
}

class StationDetails {
  int? id;
  String? stationName;
  String? address;
  double? latitude;
  double? longitude;

  StationDetails(
      {this.id, this.stationName, this.address, this.latitude, this.longitude});

  StationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stationName = json['station_name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['station_name'] = this.stationName;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
