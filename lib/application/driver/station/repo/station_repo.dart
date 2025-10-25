import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/driver/station/model/station_model.dart';
import 'package:voltly_app/constant/app_urls.dart';

class StationRepo {
  Future<List<StationModel>> getStationList({
    required String lat,
    required String long,
    required String raduis,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final reseponse = await ApiService().getList(
      "${AppUrls.getStationListUrl}?latitude=25.7616898&longitude=-80.1917902&radius=50",
      authToken: prefs.getString("authToken"),
    );
    return reseponse.map((e) => StationModel.fromJson(e)).toList();
  }
}
