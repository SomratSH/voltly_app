import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/driver/station/model/station_details_model.dart';
import 'package:voltly_app/application/driver/station/model/station_model.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/user/station/station_details.dart';

class StationRepo {
  Future<List<StationModel>> getStationList({
    required String lat,
    required String long,
    required String raduis,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final reseponse = await ApiService().getList(
      "${AppUrls.getStationListUrl}?latitude=34.0522&longitude=-118.2437&radius=50",
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
      "${AppUrls.getStationDetails}?latitude=34.0522&longitude=-118.2437&radius=50&station_id=${stationId}",
      authToken: prefs.getString("authToken"),
    );
    return StationDetailsModel.fromJson(reseponse);
  }
}
