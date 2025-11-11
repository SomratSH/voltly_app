import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/authentication/authentiation_repo/authentication_repo.dart';

class AuthProvider extends ChangeNotifier {
  //
  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  String confirmPassword = '';
  String selectedCountryCode = '+1';
  bool agreeToTerms = false;

  String stationName = '';
  String locationArea = '';
  String latitude = '';
  String longitude = '';

  // Update functions
  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePhone(String value) {
    phone = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    confirmPassword = value;
    notifyListeners();
  }

  void updateCountryCode(String value) {
    selectedCountryCode = value;
    notifyListeners();
  }

  void toggleAgreeToTerms(bool value) {
    agreeToTerms = value;
    notifyListeners();
  }

  ///
  ///
  void setStationName(String value) {
    stationName = value;
    notifyListeners();
  }

  void setLocationArea(String value) {
    locationArea = value;
    notifyListeners();
  }

  void setLatitude(String value) {
    latitude = value;
    notifyListeners();
  }

  void setLongitude(String value) {
    longitude = value;
    notifyListeners();
  }

  //api calling function
  Future<Map<String, dynamic>> signUpHost({
    required String name,
    required String email,
    required String phone,
    required String role,
    required String password,
    required String confirmPassword,
    required bool isTerms,
  }) async {
    final response = await AuthenticationRepo(ApiService()).signUp({
      "full_name": name,
      "email": email,
      "phone": phone,
      "role": role,
      "password": password,
      "confirm_password": confirmPassword,
      "terms_privacy": isTerms,
      "station_name": stationName,
      "location_area": locationArea,
      "latitude": latitude,
      "longitude": longitude,
    });
    return response;
  }

  Future<Map<String, dynamic>> signUpDrver({
    required String name,
    required String email,
    required String phone,
    required String role,
    required String password,
    required String confirmPassword,
    required bool isTerms,
  }) async {
    final response = await AuthenticationRepo(ApiService()).signUp({
      "full_name": name,
      "email": email,
      "phone": phone,
      "role": role,
      "password": password,
      "confirm_password": confirmPassword,
      "terms_privacy": isTerms,
    });
    return response;
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await AuthenticationRepo(ApiService()).login({
      "email": email,
      "password": password,
      // "device_token": "test-token-12345",
    });
    if (response["message"] != null) {
      prefs.setString('authToken', response["access_token"]);
      prefs.setString('refreshToken', response["refresh_token"].toString());
      prefs.setInt("id", response['data']["id"]);
      prefs.setString("role", response['data']["role"]);
    } else {
      debugPrint("Login failed: ${response["message"]}");
    }
    return response;
  }

  Future<Map<String, dynamic>> sendOtp({required String email}) async {
    final response = await AuthenticationRepo(
      ApiService(),
    ).forgotPassword({"email": email});
    return response;
  }

  Future<Map<String, dynamic>> signUpVerifyUserForgot({
    required String email,
    required String otp,
  }) async {
    final response = await AuthenticationRepo(
      ApiService(),
    ).verifyOtp({"email": email, "otp": otp});

    return response;
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await AuthenticationRepo(ApiService()).resetPassword({
      "email": email,
      "password": password,
      "confirm_password": confirmPassword,
    });

    return response;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    await prefs.remove('refreshToken');
    notifyListeners();
  }
}
