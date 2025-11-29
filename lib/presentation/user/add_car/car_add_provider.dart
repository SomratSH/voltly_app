import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
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

  //helping data

  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  String _selectedVehicleType = 'car';

  String get selectedVehicleType => _selectedVehicleType;

  bool get isSelectedCar => _selectedVehicleType == 'Car';
  bool get isSelectedBike => _selectedVehicleType == 'Bike';

  void selectVehicle(String type) {
    _selectedVehicleType = type;
    notifyListeners();
  }

  String carName = "";

  void updateCarName(v) {
    carName = v;
    print(carName);
    notifyListeners();
  }

  //plug section

  String _selectedPlug = '';

  String get selectedPlug => _selectedPlug;
  bool get hasSelected => _selectedPlug.isNotEmpty;

  void selectPlug(String plugType) {
    _selectedPlug = plugType;
    notifyListeners();
  }

  void clearSelection() {
    _selectedPlug = '';
    notifyListeners();
  }

  String _registrationNumber = "";
  String get registrationNumber => _registrationNumber;

  updateRegistrationNumnber(String v) {
    _registrationNumber = v;
    notifyListeners();
  }

  Future<Map<String, dynamic>> addCarData() async {
    print(pickedImage!.path);
    final reseponse = await VehicleRepo().addCar({
      "registration_number": registrationNumber,
      "selected_plug": 2,
      "vehicle": 1,
      "custom_vehicle_name": carName,
      "vehicle_type": _selectedVehicleType.toUpperCase(),
      "battery_type": "lithium",
    }, pickedImage!);
    return reseponse;
  }
}
