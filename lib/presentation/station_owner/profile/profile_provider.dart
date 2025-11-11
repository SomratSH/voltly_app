import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/driver/profile/model/profile_model.dart';
import 'package:voltly_app/application/driver/profile/repo/profile_repo.dart';
import 'package:voltly_app/application/host/profile/model/earning_payout_model.dart';
import 'package:voltly_app/application/host/profile/model/host_profile_model.dart';
import 'package:voltly_app/application/host/profile/model/upcoming_resevation_model.dart';
import 'package:voltly_app/application/host/profile/repo/host_profile_repo.dart';
import 'package:voltly_app/application/terms_privacy/model/privacy_model.dart';
import 'package:voltly_app/application/terms_privacy/model/term_condition_model.dart';
import 'package:voltly_app/application/terms_privacy/repo/term_privacy_repo.dart';

class HostProfileProvider extends ChangeNotifier {
  HostProfileModel hostProfileModel = HostProfileModel();

  EarningPayoutModel earningPayoutModel = EarningPayoutModel();
  UpcomingReservationModel upcomingReservationModel =
      UpcomingReservationModel();
  String name = "";
  String phone = "";
  Future<void> getProfileHost() async {
    final reseponse = await HostProfileRepo().fetchProfileHost();
    hostProfileModel = reseponse;
    notifyListeners();
  }

  //

  Future<Map<String, dynamic>> updateProfileHost({
    String? name,
    String? phone,
    File? image,
  }) async {
    final response = await HostProfileRepo().updateProfileHost({
      "full_name": name,

      "mobile": phone,
    }, image);
    if (response.isNotEmpty) {
      getProfileHost();
    } else {
      debugPrint("Failed to update profile");
    }
    return response;
  }

  Future<Map<String, dynamic>> changePasswordHost({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await HostProfileRepo().resetPasswordHost({
      "old_password": oldPassword,
      "new_password": password,
      "confirm_password": confirmPassword,
    });

    return response;
  }

  Future<void> getEaringPayoytHost() async {
    final response = await HostProfileRepo().getEaringPayout();
    print(response);
    earningPayoutModel = response;
    notifyListeners();
  }

  Future<void> getUpcomingReservationHost() async {
    final response = await HostProfileRepo().getUpcomingReservation();
    print(response);
    upcomingReservationModel = response;
    notifyListeners();
  }

  updateNameHost(String data) {
    name = data;
    notifyListeners();
  }

  updatePhoneHost(String data) {
    phone = data;
    notifyListeners();
  }

  PrivacyModel privacyModel = PrivacyModel();
  TermConditionModel termConditionModel = TermConditionModel();

  Future<void> getTerms() async {
    final response = await TermPrivacyRepo().getTermsCondition();
    termConditionModel = response;
    notifyListeners();
  }

  Future<void> getPrivacy() async {
    final response = await TermPrivacyRepo().getPrivacy();
    privacyModel = response;
    notifyListeners();
  }
}
