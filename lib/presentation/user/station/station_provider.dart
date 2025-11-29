import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:voltly_app/application/driver/station/model/booking_details_model.dart';
import 'package:voltly_app/application/driver/station/model/booking_list_model.dart';
import 'package:voltly_app/application/driver/station/model/booking_response_model.dart';
import 'package:voltly_app/application/driver/station/model/charging_history_details_model.dart';
import 'package:voltly_app/application/driver/station/model/charging_history_model.dart';
import 'package:voltly_app/application/driver/station/model/charging_response_model.dart';
import 'package:voltly_app/application/driver/station/model/station_details_model.dart';
import 'package:voltly_app/application/driver/station/model/station_model.dart';
import 'package:voltly_app/application/driver/station/repo/station_repo.dart';

class StationProvider extends ChangeNotifier {
  List<StationModel> stationList = [];
  StationModel selectedStation = StationModel();
  StationDetailsModel stationDetailsModel = StationDetailsModel();
  BookingResponseModel bookingSummaryModel = BookingResponseModel();

  int? selectCarId;
  int? selectedChargerId;
  int? selectedPlugId;

  double? myLat;
  double? myLong;

  // StationProvider() {
  //   initLocation();
  // }

  // Future<void> initLocation() async {
  //   print(myLat);
  //   print(myLong);
  //   await getMyLatLong();
  // }

  // Future<void> getMyLatLong() async {
  //   // Check permission
  //   LocationPermission permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       print("Location permission denied");
  //       return null;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     print("Location permission permanently denied");
  //     return null;
  //   }

  //   // Get current position
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );

  //   myLat = position.latitude;
  //   myLong = position.longitude;
  //   notifyListeners();
  // }

  void selectPlug(int chargerId, int plugId) {
    selectedChargerId = chargerId;
    selectedPlugId = plugId;
    notifyListeners();
  }

  void setSelectedCar(int id) {
    selectCarId = id;
    notifyListeners();
  }

  DateTime? selectedDate;
  String? selectedDateFinal;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? finalStartTime;
  String? endTimeFinal;

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    selectedDateFinal = "${year}-${month}-${day}";
    notifyListeners();
  }

  void setStartTime(TimeOfDay time) {
    startTime = time;

    // Reset end time if invalid
    if (endTime != null &&
        _timeToDouble(endTime!) <= _timeToDouble(startTime!)) {
      endTime = null;
    }

    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    finalStartTime = "$h:$m";

    notifyListeners();
  }

  void setEndTime(TimeOfDay time) {
    endTime = time;
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    endTimeFinal = "$h:$m";
    notifyListeners();
  }

  double _timeToDouble(TimeOfDay time) => time.hour + time.minute / 60.0;

  Future<void> getNeayByStation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permission permanently denied");
      return null;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final response = await StationRepo().getStationList(
      lat: position.latitude.toString(),
      long: position.longitude.toString(),
      raduis: "50",
    );
    stationList = response;
    notifyListeners();
  }

  void selectedStationFunc(StationModel data) {
    selectedStation = StationModel();
    selectedStation = data;
    notifyListeners();
  }

  Future<bool> getStationDetails(String stationID) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permission permanently denied");
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final response = await StationRepo().getStationDetails(
      lat: position.latitude.toString(),
      long: position.longitude.toString(),
      raduis: "50",
      stationId: stationID,
    );
    stationDetailsModel = response;
    notifyListeners();
    return true;
  }

  Future<Map<String, dynamic>> createConfirmBooking() async {
    final response = await StationRepo().createBooking({
      "station": stationDetailsModel.id,
      "charger": selectedChargerId,
      "plug": selectedPlugId,
      "vehicle_id": selectCarId,
      "booking_date": selectedDateFinal,
      "start_time": finalStartTime.toString(),
      "end_time": endTimeFinal.toString(),
    });
    print(response);
    if (response["id"] != null) {
      bookingSummaryModel = BookingResponseModel.fromJson(response);
      notifyListeners();
    }

    return response;
  }

  List<BookingListModel> bookingListModel = [];
  BookingDetailsModel bookingDetailsModel = BookingDetailsModel();

  Future<void> getUserBookingList() async {
    final response = await StationRepo().getBookingList();
    bookingListModel = response;
    notifyListeners();
  }

  Future<void> getBookingDetailsUser(int id) async {
    final response = await StationRepo().getBookingDetails(id);
    bookingDetailsModel = response;
    notifyListeners();
  }

  //start and end charging api
  CharingCompleteResponseModel charingCompleteResponseModel =
      CharingCompleteResponseModel();
  Future<Map<String, dynamic>> startChargingUser(int id) async {
    final response = await StationRepo().startCharing({"booking_id": id});
    return response;
  }

  Future<Map<String, dynamic>> endChargingUser(int id) async {
    final response = await StationRepo().endCharing({"booking_id": id});
    if (response["message"] == "Charging completed") {
      charingCompleteResponseModel = CharingCompleteResponseModel.fromJson(
        response,
      );
      notifyListeners();
    }
    return response;
  }

  Future<Map<String, dynamic>> paymentForCharging(int id) async {
    final response = await StationRepo().payForCharging({"booking_id": id});
    return response;
  }

  //charging history

  CharingHistoryModel charingHistoryModel = CharingHistoryModel();
  CharingHistoryDetailsModel charingHistoryDetailsModel =
      CharingHistoryDetailsModel();

  Future<void> getCharingHistoryUser() async {
    final response = await StationRepo().getChargingHistory();
    charingHistoryModel = response;
    notifyListeners();
  }

  Future<void> getCharingHistoryDetailsUser(int id) async {
    final response = await StationRepo().getChargingHistoryDetails(id);
    charingHistoryDetailsModel = response;
    notifyListeners();
  }
}
