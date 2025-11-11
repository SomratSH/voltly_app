import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/driver/profile/model/profile_model.dart';
import 'package:voltly_app/application/driver/profile/repo/profile_repo.dart';
import 'package:voltly_app/application/host/profile/model/earning_payout_model.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();

  String name = "";
  String phone = "";
  Future<void> getProfile() async {
    final reseponse = await ProfileRepo().fetchProfile();
    profileModel = reseponse;
    notifyListeners();
  }

  //

  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? phone,
    File? image,
  }) async {
    final response = await ProfileRepo().updateProfile({
      "full_name": name,

      "mobile": phone,
    }, image);
    if (response.isNotEmpty) {
      getProfile();
    } else {
      debugPrint("Failed to update profile");
    }
    return response;
  }

  Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await ProfileRepo().resetPassword({
      "old_password": oldPassword,
      "new_password": password,
      "confirm_password": confirmPassword,
    });

    return response;
  }



  updateName(String data) {
    name = data;
    notifyListeners();
  }

  updatePhone(String data) {
    phone = data;
    notifyListeners();
  }
}
