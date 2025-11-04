import 'package:flutter/widgets.dart';
import 'package:voltly_app/application/driver/station/model/station_details_model.dart';
import 'package:voltly_app/application/driver/station/model/station_model.dart';
import 'package:voltly_app/application/driver/station/repo/station_repo.dart';

class StationProvider extends ChangeNotifier {
  List<StationModel> stationList = [];
  StationModel selectedStation = StationModel();
  StationDetailsModel stationDetailsModel = StationDetailsModel();

  Future<void> getNeayByStation() async {
    final response = await StationRepo().getStationList(
      lat: "234",
      long: "213",
      raduis: "58",
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
    final response = await StationRepo().getStationDetails(
      lat: "",
      long: "",
      raduis: "",
      stationId: stationID,
    );
    stationDetailsModel = response;
    notifyListeners();
    return true;
  }
}
