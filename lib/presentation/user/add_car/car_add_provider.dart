import 'package:flutter/widgets.dart';
import 'package:voltly_app/application/driver/vehicle/model/vehicle_details_model.dart';
import 'package:voltly_app/application/driver/vehicle/model/vehicle_model.dart';
import 'package:voltly_app/application/driver/vehicle/repo/vehicle_repo.dart';

class CarAddProvider extends ChangeNotifier {
  List<VehicleModel> carList = [];
  VechicleDetailsModel vechicleDetailsModel = VechicleDetailsModel();

  Future<void> getVehicleList() async {
    final reseponse = await VehicleRepo().getVehicleList();
    if (reseponse.isNotEmpty) {
      carList = reseponse;
      notifyListeners();
    }
  }

  Future<void> getDetailsVehicle(int id) async {
    final response = await VehicleRepo().getVehicleDetails(id);
    vechicleDetailsModel = response;
    notifyListeners();
  }
}
