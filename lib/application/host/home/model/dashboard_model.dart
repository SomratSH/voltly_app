class HostDashboardModel {
  PaymentSetup? paymentSetup;
  SubscriptionPlan? subscriptionPlan;
  Chargers? chargers;
  RatingsAndReviews? ratingsAndReviews;

  HostDashboardModel({
    this.paymentSetup,
    this.subscriptionPlan,
    this.chargers,
    this.ratingsAndReviews,
  });

  HostDashboardModel.fromJson(Map<String, dynamic> json) {
    paymentSetup = json['payment_setup'] != null
        ? new PaymentSetup.fromJson(json['payment_setup'])
        : null;
    subscriptionPlan = json['subscription_plan'] != null
        ? new SubscriptionPlan.fromJson(json['subscription_plan'])
        : null;
    chargers = json['chargers'] != null
        ? new Chargers.fromJson(json['chargers'])
        : null;
    ratingsAndReviews = json['ratings_and_reviews'] != null
        ? new RatingsAndReviews.fromJson(json['ratings_and_reviews'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentSetup != null) {
      data['payment_setup'] = this.paymentSetup!.toJson();
    }
    if (this.subscriptionPlan != null) {
      data['subscription_plan'] = this.subscriptionPlan!.toJson();
    }
    if (this.chargers != null) {
      data['chargers'] = this.chargers!.toJson();
    }
    if (this.ratingsAndReviews != null) {
      data['ratings_and_reviews'] = this.ratingsAndReviews!.toJson();
    }
    return data;
  }
}

class PaymentSetup {
  String? stripeStatus;

  PaymentSetup({this.stripeStatus});

  PaymentSetup.fromJson(Map<String, dynamic> json) {
    stripeStatus = json['stripe_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stripe_status'] = this.stripeStatus;
    return data;
  }
}

class SubscriptionPlan {
  String? currentPlan;
  Null? nextBillingDate;

  SubscriptionPlan({this.currentPlan, this.nextBillingDate});

  SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    currentPlan = json['current_plan'];
    nextBillingDate = json['next_billing_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_plan'] = this.currentPlan;
    data['next_billing_date'] = this.nextBillingDate;
    return data;
  }
}

class Chargers {
  int? activeChargers;
  int? inactiveChargers;

  Chargers({this.activeChargers, this.inactiveChargers});

  Chargers.fromJson(Map<String, dynamic> json) {
    activeChargers = json['active_chargers'];
    inactiveChargers = json['inactive_chargers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_chargers'] = this.activeChargers;
    data['inactive_chargers'] = this.inactiveChargers;
    return data;
  }
}

class RatingsAndReviews {
  double? averageRating;
  int? totalReviews;

  RatingsAndReviews({this.averageRating, this.totalReviews});

  RatingsAndReviews.fromJson(Map<String, dynamic> json) {
    averageRating = json['average_rating'];
    totalReviews = json['total_reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average_rating'] = this.averageRating;
    data['total_reviews'] = this.totalReviews;
    return data;
  }
}
