import 'package:flutter/material.dart';
import 'package:voltly_app/application/host/booking_repo/model/booking_model.dart';
import 'package:voltly_app/application/host/booking_repo/repo/booking_repo.dart';

class ReservationProvider extends ChangeNotifier {
  List<BookingModel> bookingList = [];
  List<BookingModel> filteredBookings = [];
  bool isLoading = false;
  Future<void> getBooking(String status) async {
    isLoading = true;
    notifyListeners();
    final response = await BookingRepo().getBookingList(status);
    bookingList.clear();
    bookingList = response;
    filteredBookings = response;
    isLoading = false;
    notifyListeners();
  }

  void updateStatus(int id, String status) {
    bookingList.forEach((e) {
      if (e.id == id) {
        e.status = status;
      }
    });
    notifyListeners();
  }

  Future<Map<String, dynamic>> bookingAccept(String id, String status) async {
    final response = await BookingRepo().acceptBooking(id, status);
    return response;
  }

  void searchBooking(String query) {
    if (query.isEmpty) {
      filteredBookings = List.from(bookingList);
    } else {
      query = query.toLowerCase();
      filteredBookings = bookingList.where((booking) {
        final driverName = booking.userName.toString().toLowerCase();
        final chargerName = booking.chargerType.toString().toLowerCase();
        final carName = booking.vehicleName!.toLowerCase();
        return driverName.contains(query) ||
            chargerName.contains(query) ||
            carName.contains(query);
      }).toList();
    }
    notifyListeners();
  }
}
