class UpcomingReservationModel {
  List<UpcomingReservations>? upcomingReservations;

  UpcomingReservationModel({this.upcomingReservations});

  UpcomingReservationModel.fromJson(Map<String, dynamic> json) {
    if (json['upcoming_reservations'] != null) {
      upcomingReservations = <UpcomingReservations>[];
      json['upcoming_reservations'].forEach((v) {
        upcomingReservations!.add(new UpcomingReservations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.upcomingReservations != null) {
      data['upcoming_reservations'] = this.upcomingReservations!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class UpcomingReservations {
  String? userName;
  String? vehicleName;
  String? status;
  String? startTime;
  String? endTime;
  String? bookingDate;

  UpcomingReservations({
    this.userName,
    this.vehicleName,
    this.status,
    this.startTime,
    this.endTime,
    this.bookingDate,
  });

  UpcomingReservations.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    vehicleName = json['vehicle_name'];
    status = json['status'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    bookingDate = json['booking_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['vehicle_name'] = this.vehicleName;
    data['status'] = this.status;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['booking_date'] = this.bookingDate;
    return data;
  }
}
