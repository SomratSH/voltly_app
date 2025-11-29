import 'dart:io';

import 'package:voltly_app/api_service/api_service.dart';

import 'package:voltly_app/application/driver/vehicle/model/vehicle_details_model.dart';
import 'package:voltly_app/application/driver/vehicle/model/vehicle_model.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleRepo {
  Future<List<VehicleModel>> getVehicleList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final reseponse = await ApiService().getList(
      AppUrls.getVehicleUrl,
      authToken: prefs.getString("authToken"),
    );
    return reseponse.map((e) => VehicleModel.fromJson(e)).toList();
  }

  Future<VechicleDetailsModel> getVehicleDetails(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await ApiService().getData(
      "${AppUrls.getVehicleDetails}$id/detail/",
      authToken: prefs.getString("authToken"),
    );

    return VechicleDetailsModel.fromJson(response);
  }

  Future<Map<String, dynamic>> addCar(
    Map<String, dynamic> data,
    File image,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().postData(
      AppUrls.addCarUrl,
      data,
      authToken: preferences.getString("authToken"),
      image: image,
      imageParamNam: "custom_vehicle_image",
    );
    return response;
  }
}
