import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/constant/app_urls.dart';

class AuthenticationRepo {
  final ApiService _apiService;

  AuthenticationRepo(this._apiService);

  Future<Map<String, dynamic>> signUp(
    Map<String, dynamic> body,
    File image,
  ) async {
    final response = await _apiService.postData(
      AppUrls.signUp,
      body,
      image: image,
    );
    debugPrint("Response from signUp: $response");
    return response;
  }

  Future<Map<String, dynamic>> signUpDriver(Map<String, dynamic> body) async {
    final response = await _apiService.postDataRegular(AppUrls.signUp, body);
    debugPrint("Response from signUp: $response");
    return response;
  }

  Future<Map<String, dynamic>> login(Map<String, String> map) async {
    final response = await _apiService.postDataRegular(AppUrls.login, map);
    debugPrint("Response from login: $response");
    return response;
  }

  //forgot password
  Future<Map<String, dynamic>> forgotPassword(Map<String, String> body) async {
    final response = await _apiService.postDataRegular(
      AppUrls.forgotPassword,
      body,
    );
    debugPrint("Response from sendOtp: $response");
    return response;
  }

  Future<Map<String, dynamic>> verifyOtp(Map<String, String> body) async {
    final response = await _apiService.postDataRegular(AppUrls.verfiyOtp, body);
    debugPrint("Response from verifyOtp: $response");
    return response;
  }

  Future<Map<String, dynamic>> resetPassword(Map<String, String> body) async {
    final response = await _apiService.postDataRegular(
      AppUrls.resetPassword,
      body,
    );
    debugPrint("Response from resetPassword: $response");
    return response;
  }

    Future<Map<String, dynamic>> loginGoogle(Map<String, String> map) async {
    print(map);
    final response = await _apiService.postDataRegular(
      AppUrls.loginGoogle,
      map,
    );
    debugPrint("Response from login: $response");
    return response;
  }
}
