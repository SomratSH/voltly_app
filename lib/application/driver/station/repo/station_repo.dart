import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/driver/station/model/booking_details_model.dart';
import 'package:voltly_app/application/driver/station/model/booking_list_model.dart';
import 'package:voltly_app/application/driver/station/model/booking_response_model.dart';
import 'package:voltly_app/application/driver/station/model/charging_history_details_model.dart';
import 'package:voltly_app/application/driver/station/model/charging_history_model.dart';
import 'package:voltly_app/application/driver/station/model/station_details_model.dart';
import 'package:voltly_app/application/driver/station/model/station_model.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/user/profile/charging_history.dart';
import 'package:voltly_app/presentation/user/station/booking_details.dart';
import 'package:voltly_app/presentation/user/station/station_details.dart';
import 'package:geolocator/geolocator.dart';
class StationRepo {

  
  Future<List<StationModel>> getStationList({
    required String lat,
    required String long,
    required String raduis,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final reseponse = await ApiService().getList(
      "${AppUrls.getStationListUrl}?latitude=$lat&longitude=$long&radius=50",
      authToken: prefs.getString("authToken"),
    );
    return reseponse.map((e) => StationModel.fromJson(e)).toList();
  }

  Future<StationDetailsModel> getStationDetails({
    required String lat,
    required String long,
    required String raduis,
    required String stationId,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final reseponse = await ApiService().getData(
      "${AppUrls.getStationDetails}?latitude=$lat&longitude=$long&radius=50&station_id=${stationId}",
      authToken: prefs.getString("authToken"),
    );
    return StationDetailsModel.fromJson(reseponse);
  }

  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().postDataRegular(
      AppUrls.createBooking,
      data,
      authToken: preferences.getString("authToken"),
    );
    return response;
  }

  Future<List<BookingListModel>> getBookingList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getList(
      AppUrls.getUserBookingList,
      authToken: preferences.getString("authToken"),
    );

    return response.map((e) => BookingListModel.fromJson(e)).toList();
  }

  Future<BookingDetailsModel> getBookingDetails(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getData(
      "${AppUrls.bookingDetails}$id/details/",
      authToken: preferences.getString("authToken"),
    );
    return BookingDetailsModel.fromJson(response);
  }

  Future<Map<String, dynamic>> startCharing(Map<String, dynamic> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = ApiService().postDataRegular(
      AppUrls.statChargingUrl,
      data,
      authToken: preferences.getString("authToken"),
    );
    return response;
  }

  Future<Map<String, dynamic>> endCharing(Map<String, dynamic> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = ApiService().postDataRegular(
      AppUrls.endChargingUrl,
      data,
      authToken: preferences.getString("authToken"),
    );
    return response;
  }

  Future<Map<String, dynamic>> payForCharging(Map<String, dynamic> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = ApiService().postDataRegular(
      AppUrls.paymentCharging,
      data,
      authToken: preferences.getString("authToken"),
    );
    return response;
  }

  Future<CharingHistoryModel> getChargingHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await ApiService().getData(
      AppUrls.chargingHistory,
      authToken: preferences.getString("authToken"),
    );
    return CharingHistoryModel.fromJson(response);
  }

  Future<CharingHistoryDetailsModel> getChargingHistoryDetails(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await ApiService().getData(
      "${AppUrls.charingHistoryDetails}${id}/history/",
      authToken: preferences.getString("authToken"),
    );
    return CharingHistoryDetailsModel.fromJson(response);
  }
}
