import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/host/subscription/model/subscription_model.dart';
import 'package:voltly_app/constant/app_urls.dart';

class SubscriptionRepo {
  Future<List<SubcriptionModel>> getSubscriptionList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final reseponse = await ApiService().getList(
      AppUrls.subscriptionListUrl,
      authToken: preferences.getString("authToken"),
    );
    return reseponse.map((e) => SubcriptionModel.fromJson(e)).toList();
  }
}
