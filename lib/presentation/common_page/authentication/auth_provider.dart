import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/authentication/authentiation_repo/authentication_repo.dart';

class AuthProvider extends ChangeNotifier {
  Future<Map<String, dynamic>> signUp({
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
