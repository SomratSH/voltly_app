class ChargingListModel {
  int? id;
  String? name;
  String? scannerCode;
  String? scannerImage;
  int? station;
  int? chargerType;
  List<int>? plugTypes;
  List<int>? connectorTypes;
  String? mode;
  String? price;
  bool? available;
  bool? open247;
  bool? isActive;
  bool? isDefault;

  ChargingListModel({
    this.id,
    this.name,
    this.scannerCode,
    this.scannerImage,
    this.station,
    this.chargerType,
    this.plugTypes,
    this.connectorTypes,
    this.mode,
    this.price,
    this.available,
    this.isDefault,
    this.open247,
    this.isActive,
  });

  ChargingListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    scannerCode = json['scanner_code'];
    scannerImage = json['scanner_image'];
    station = json['station'];
    chargerType = json['charger_type'];
    plugTypes = json['plug_types'].cast<int>();
    connectorTypes = json['connector_types'].cast<int>();
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
    data['mode'] = this.mode;
    data['price'] = this.price;
    data['available'] = this.available;
    data['open_24_7'] = this.open247;
    data['is_active'] = this.isActive;
    return data;
  }
}
