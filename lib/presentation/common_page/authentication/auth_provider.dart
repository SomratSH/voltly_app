import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/authentication/authentiation_repo/authentication_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage = File(image.path);
      notifyListeners();
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      selectedImage = File(image.path);
      notifyListeners();
    }
  }

  void removeImage() {
    selectedImage = null;
    notifyListeners();
  }

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
    required File image,
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
    }, image);
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
    final response = await AuthenticationRepo(ApiService()).signUpDriver({
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
    await prefs.remove("id");
    await prefs.remove("role");
    await prefs.clear();
    notifyListeners();
    print(prefs.getString("authToken"));
  }

  bool isLoading = false;
  Future<Map<String, dynamic>> signUpGoogle(User status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading = true;

    notifyListeners();
    final response = await AuthenticationRepo(ApiService()).loginGoogle(
      status.phoneNumber == null
          ? {
              "email": status.email!,
              "full_name": status.displayName!,
              "avatar": status.photoURL!,
            }
          : {
              "email": status.email!,
              "mobile": status.phoneNumber!,
              "full_name": status.displayName!,
              "avatar": status.photoURL!,
            },
    );
    print(response);
    if (response["message"] != null) {
      prefs.setString('authToken', response["access_token"]);
      prefs.setString('refreshToken', response["refresh_token"].toString());
      prefs.setBool("isGoogleLogin", true);
      // emailController.clear();
      // passwordController.clear();
      notifyListeners();
    } else {
      debugPrint("Login failed: ${response["message"]}");
    }
    isLoading = false;
    notifyListeners();
    return response;
  }

  // final _auth = FirebaseAuth.instance;
  // final _googleSignIn = GoogleSignIn();

 
  // Future<User?> signInWithGoogle() async {
  //   try {
  //     // Trigger the Google authentication flow
  //     final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
  //     if (gUser == null) {
  //       // User cancelled the sign-in
  //       return null;
  //     }

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication gAuth = await gUser.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: gAuth.accessToken,
  //       idToken: gAuth.idToken,
  //     );

  //     // Sign in to Firebase with the credential
  //     final userCredential = await _auth.signInWithCredential(credential);

  //     // Get the Firebase ID token (JWT)
  //     final idToken = await userCredential.user;
  //     print("id toke === >  $idToken");
  //     return idToken;
  //   } catch (e) {
  //     print('Google Sign-In error: $e');
  //     rethrow;
  //   }
  // }

  // /// Optional: Sign out from both Firebase and Google
  // Future<void> googleSignOut() async {
  //   await _auth.signOut();
  //   await _googleSignIn.signOut();
  // }
}
