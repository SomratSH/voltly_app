class BookingResponseModel {
  int? id;
  int? user;
  int? plug;
  int? vehicle;
  String? subtotal;
  String? platformFee;
  String? totalAmount;
  bool? isPaid;
  String? status;
  String? bookingDate;
  String? paymentDate;

  BookingResponseModel(
      {this.id,
      this.user,
      this.plug,
      this.vehicle,
      this.subtotal,
      this.platformFee,
      this.totalAmount,
      this.isPaid,
      this.status,
      this.bookingDate,
      this.paymentDate});

  BookingResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    plug = json['plug'];
    vehicle = json['vehicle'];
    subtotal = json['subtotal'];
    platformFee = json['platform_fee'];
    totalAmount = json['total_amount'];
    isPaid = json['is_paid'];
    status = json['status'];
    bookingDate = json['booking_date'];
    paymentDate = json['payment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['plug'] = this.plug;
    data['vehicle'] = this.vehicle;
    data['subtotal'] = this.subtotal;
    data['platform_fee'] = this.platformFee;
    data['total_amount'] = this.totalAmount;
    data['is_paid'] = this.isPaid;
    data['status'] = this.status;
    data['booking_date'] = this.bookingDate;
    data['payment_date'] = this.paymentDate;
    return data;
  }
}
