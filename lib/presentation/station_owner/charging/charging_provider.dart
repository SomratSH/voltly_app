import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:voltly_app/application/host/charger/model/charging_list_model.dart';
import 'package:voltly_app/application/host/charger/repo/charging_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class ChargingProvider extends ChangeNotifier {
  List<ChargingListModel> chargerList = [];

  String chargerTpye = "2";
  String chargername = "";
  String mode = "hour";
  String price = "";
  bool isOpen24Hours = false;

  LatLng? selectedPosition;
  String address = 'Move map to pick location';
  bool isLoading = true;
  GoogleMapController? mapController;

  Future<void> initCurrentLocation() async {
    final location = loc.Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (permissionGranted == PermissionStatus.granted) {
      final userLocation = await location.getLocation();
      selectedPosition = LatLng(
        userLocation.latitude!,
        userLocation.longitude!,
      );
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    Future.delayed(const Duration(milliseconds: 200), () {
      controller?.setMapStyle(darkMapStyle).catchError((error) {
        print('Error setting map style: $error');
      });
    });
  }

  void onCameraMove(CameraPosition position) {
    selectedPosition = position.target;
  }

  Future<void> onCameraIdle() async {
    if (selectedPosition != null) {
      await _updateAddressFromLatLng(selectedPosition!);
      notifyListeners();
    }
  }

  Future<void> _updateAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        address =
            "${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}";
      }
      print(address);
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching address: $e");
    }
  }

  Future<void> getChargingList() async {
    final reseponse = await ChargingRepo().getChargingList();
    if (reseponse.isNotEmpty) {
      chargerList = reseponse;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> addChargerHost(String stationId) async {
    final reseponse = await ChargingRepo().addCharger({
      "station_id": 7,
      "name": chargername,
      "charger_type": 2,
      "mode": mode,
      "price": price,
      "open_24_7": isOpen24Hours,
      "station_latitude": selectedPosition!.latitude.toString(),
      "station_longitude": selectedPosition!.longitude.toString(),
      "station_address": address,
    });
    return reseponse;
  }

  void updateTheStatusIsAvailable(bool value) {
    isOpen24Hours = value;
    notifyListeners();
  }

  final String darkMapStyle = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#479060"
      },
      {
        "saturation": 100
      },
      {
        "lightness": 100
      },
      {
        "weight": 1.5
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#479060"
      },
      {
        "weight": 8
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#52ff9d"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#479060"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#479060"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#52ff9d"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]''';

  void ratePerHourUpdate(String v) {
    price = v;
    notifyListeners();
  }

  void updateChargerName(String v) {
    chargername = v;
    notifyListeners();
  }
}
