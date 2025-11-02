import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/host/charger/model/charging_list_model.dart';
import 'package:voltly_app/constant/app_urls.dart';

class ChargingRepo {
  Future<List<ChargingListModel>> getChargingList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getList(
      AppUrls.getChargingList,
      authToken: preferences.getString("authToken"),
    );
    return response.map((e) => ChargingListModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> addCharger(Map<String, dynamic> data) async {
    print(data);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final reseponse = await ApiService().postData(
      AppUrls.addHostCharger,
      data,
      authToken: preferences.getString("authToken"),
    );
    return reseponse;
  }
}
