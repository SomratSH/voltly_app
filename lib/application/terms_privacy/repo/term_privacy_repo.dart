import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/terms_privacy/model/privacy_model.dart';
import 'package:voltly_app/application/terms_privacy/model/term_condition_model.dart';

import 'package:voltly_app/constant/app_urls.dart';

class TermPrivacyRepo {
  Future<PrivacyModel> getPrivacy() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getData(
      AppUrls.privacyPolicy,
      authToken: preferences.getString("authToken"),
    );
    return PrivacyModel.fromJson(response);
  }

  Future<TermConditionModel> getTermsCondition() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getData(
      AppUrls.termsCondition,
      authToken: preferences.getString("authToken"),
    );
    return TermConditionModel.fromJson(response);
  }
}
