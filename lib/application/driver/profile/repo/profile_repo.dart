import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/driver/profile/model/profile_model.dart';
import 'package:voltly_app/constant/app_urls.dart';

class ProfileRepo {
  Future<ProfileModel> fetchProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final reseponse = await ApiService().getData(
      AppUrls.profile,
      authToken: preferences.getString("authToken"),
    );
    return ProfileModel.fromJson(reseponse);
  }

  Future<Map<String, dynamic>> updateProfile(
    Map<String, dynamic> profileData,
    File? image,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await ApiService().patchData(
      AppUrls.profileUpdate,
      profileData,
      image: image,
      authToken: prefs.getString('authToken'),
    );
    return response;
  }

  Future resetPassword(Map<String, String> map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await ApiService().postDataRegular(
      AppUrls.changePassword,
      map,
      authToken: prefs.getString('authToken'),
    );
    return response;
  }
}
