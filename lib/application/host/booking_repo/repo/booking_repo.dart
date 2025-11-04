import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/host/booking_repo/model/booking_model.dart';
import 'package:voltly_app/constant/app_urls.dart';

class BookingRepo {
  Future<List<BookingModel>> getBookingList(String status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getList(
      AppUrls.bookingListUrl + "?status=${status}",
      authToken: preferences.getString("authToken"),
    );
    return response.map((e) => BookingModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> acceptBooking(String id, String status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().postDataRegular(
      "${AppUrls.acceptBooking}$id/status/",
      {"status": status},
      authToken: preferences.getString("authToken"),
    );
    return response;
  }
}
