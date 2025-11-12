class PlugConnectorModel {
  List<PlugType>? plugTypes;
  List<ConnectorType>? connectorTypes;

  PlugConnectorModel({this.plugTypes, this.connectorTypes});

  factory PlugConnectorModel.fromJson(Map<String, dynamic> json) {
    return PlugConnectorModel(
      plugTypes:
          (json['plug_types'] as List<dynamic>?)
              ?.map((e) => PlugType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      connectorTypes:
          (json['connector_types'] as List<dynamic>?)
              ?.map((e) => ConnectorType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'plug_types': plugTypes!.map((e) => e.toJson()).toList(),
    'connector_types': connectorTypes!.map((e) => e.toJson()).toList(),
  };
}

class PlugType {
  int? id;
  String? name;

  PlugType({this.id, this.name});

  factory PlugType.fromJson(Map<String, dynamic> json) {
    return PlugType(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class ConnectorType {
  int? id;
  String? name;

  ConnectorType({this.id, this.name});

  factory ConnectorType.fromJson(Map<String, dynamic> json) {
    return ConnectorType(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
