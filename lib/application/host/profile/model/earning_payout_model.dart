class EarningPayoutModel {
  EarningsOverview? earningsOverview;
  NextPayout? nextPayout;
  // List<Null>? transactionHistory;

  EarningPayoutModel({this.earningsOverview, this.nextPayout});

  EarningPayoutModel.fromJson(Map<String, dynamic> json) {
    earningsOverview = json['earnings_overview'] != null
        ? new EarningsOverview.fromJson(json['earnings_overview'])
        : null;
    nextPayout = json['next_payout'] != null
        ? new NextPayout.fromJson(json['next_payout'])
        : null;
    // if (json['transaction_history'] != null) {
    //   transactionHistory = <Null>[];
    //   json['transaction_history'].forEach((v) {
    //     transactionHistory!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.earningsOverview != null) {
      data['earnings_overview'] = this.earningsOverview!.toJson();
    }
    if (this.nextPayout != null) {
      data['next_payout'] = this.nextPayout!.toJson();
    }
    // if (this.transactionHistory != null) {
    //   data['transaction_history'] =
    //       this.transactionHistory!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class EarningsOverview {
  String? today;
  String? thisWeek;
  String? thisMonth;

  EarningsOverview({this.today, this.thisWeek, this.thisMonth});

  EarningsOverview.fromJson(Map<String, dynamic> json) {
    today = json['today'];
    thisWeek = json['this_week'];
    thisMonth = json['this_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['today'] = this.today;
    data['this_week'] = this.thisWeek;
    data['this_month'] = this.thisMonth;
    return data;
  }
}

class NextPayout {
  String? scheduledDate;
  String? estimatedAmount;

  NextPayout({this.scheduledDate, this.estimatedAmount});

  NextPayout.fromJson(Map<String, dynamic> json) {
    scheduledDate = json['scheduled_date'];
    estimatedAmount = json['estimated_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduled_date'] = this.scheduledDate;
    data['estimated_amount'] = this.estimatedAmount;
    return data;
  }
}
