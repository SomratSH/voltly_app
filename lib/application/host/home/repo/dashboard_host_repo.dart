import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/host/home/model/dashboard_model.dart';

import 'package:voltly_app/constant/app_urls.dart';

class DashboardHostRepo {
  Future<HostDashboardModel> getDashboard() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getData(
      AppUrls.hostDashboard,
      authToken: preferences.getString("authToken"),
    );
    return HostDashboardModel.fromJson(response);
  }

  Future<Map<String, dynamic>> linkStripeAccount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().postData(
      AppUrls.hostLinkStripe,
      {},
      authToken: preferences.getString("authToken"),
    );
    return response;
  }

  Future<Map<String, dynamic>> hostWithdrawRquest() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().postData(
      AppUrls.hostWithdrawRquest,
      {},
      authToken: preferences.getString("authToken"),
    );
    return response;
  }
}
