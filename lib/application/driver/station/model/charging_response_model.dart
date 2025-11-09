class CharingCompleteResponseModel {
  String? message;
  int? durationHours;
  int? durationMinutes;
  int? durationSeconds;
  String? subtotal;
  String? platformFee;
  String? totalAmount;

  CharingCompleteResponseModel({
    this.message,
    this.durationHours,
    this.durationMinutes,
    this.durationSeconds,
    this.subtotal,
    this.platformFee,
    this.totalAmount,
  });

  CharingCompleteResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    durationHours = json['duration_hours'];
    durationMinutes = json['duration_minutes'];
    durationSeconds = json['duration_seconds'];
    subtotal = json['subtotal'];
    platformFee = json['platform_fee'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['duration_hours'] = this.durationHours;
    data['duration_minutes'] = this.durationMinutes;
    data['duration_seconds'] = this.durationSeconds;
    data['subtotal'] = this.subtotal;
    data['platform_fee'] = this.platformFee;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}
