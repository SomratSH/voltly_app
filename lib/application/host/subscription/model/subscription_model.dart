class SubcriptionModel {
  int? id;
  String? name;
  String? planType;
  String? description;
  String? price;
  String? billingCycle;
  Features? features;
  int? maxChargers;
  Null? maxReservations;

  SubcriptionModel(
      {this.id,
      this.name,
      this.planType,
      this.description,
      this.price,
      this.billingCycle,
      this.features,
      this.maxChargers,
      this.maxReservations});

  SubcriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    planType = json['plan_type'];
    description = json['description'];
    price = json['price'];
    billingCycle = json['billing_cycle'];
    features = json['features'] != null
        ? new Features.fromJson(json['features'])
        : null;
    maxChargers = json['max_chargers'];
    maxReservations = json['max_reservations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['plan_type'] = this.planType;
    data['description'] = this.description;
    data['price'] = this.price;
    data['billing_cycle'] = this.billingCycle;
    if (this.features != null) {
      data['features'] = this.features!.toJson();
    }
    data['max_chargers'] = this.maxChargers;
    data['max_reservations'] = this.maxReservations;
    return data;
  }
}

class Features {
  String? analytics;
  String? placement;
  String? chargerListing;

  Features({this.analytics, this.placement, this.chargerListing});

  Features.fromJson(Map<String, dynamic> json) {
    analytics = json['analytics'];
    placement = json['placement'];
    chargerListing = json['charger_listing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['analytics'] = this.analytics;
    data['placement'] = this.placement;
    data['charger_listing'] = this.chargerListing;
    return data;
  }
}
