import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:voltly_app/application/host/home/model/dashboard_model.dart';
import 'package:voltly_app/application/host/home/model/plug_connector_model.dart';
import 'package:voltly_app/application/host/home/repo/dashboard_host_repo.dart';

class HostHomeProvider extends ChangeNotifier {
  GoogleMapController? _controller;
  final LatLng sourceLocation = const LatLng(23.8103, 90.4125); // Dhaka example
  Set<Marker> markers = {};
  String mapTheme = "";
  void onMapCreated(GoogleMapController controller) {
    _controller = controller;

    // Add marker
    markers.add(
      Marker(
        markerId: const MarkerId('source'),
        position: sourceLocation,
        infoWindow: const InfoWindow(title: 'Source Location'),
      ),
    );
    Future.delayed(const Duration(milliseconds: 200), () {
      _controller?.setMapStyle(_darkMapStyle).catchError((error) {
        print('Error setting map style: $error');
      });
    });

    notifyListeners();
  }

  List<int> plugType = [];
  List<int> connectorType = [];

  void updatePlugType(int id) {
    if (!plugType.contains(id)) {
      plugType.add(id);
      notifyListeners();
    }
  }

  void updateConnectorType(int id) {
    if (!connectorType.contains(id)) {
      connectorType.add(id);
      notifyListeners();
    }
  }

  int? getPlugId(String name) {
    try {
      return plugConnectorModel.plugTypes!.firstWhere((e) => e.name == name).id;
    } catch (_) {
      return null;
    }
  }

  int? getConnectorId(String name) {
    try {
      return plugConnectorModel.connectorTypes!
          .firstWhere((e) => e.name == name)
          .id;
    } catch (_) {
      return null;
    }
  }

  final String _darkMapStyle = '''[
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

  HostDashboardModel hostDashboardModel = HostDashboardModel();

  Future<void> getDasboardData() async {
    final response = await DashboardHostRepo().getDashboard();
    hostDashboardModel = response;
    notifyListeners();
  }

  Future<Map<String, dynamic>> linkStripeAccountHost() async {
    final response = await DashboardHostRepo().linkStripeAccount();
    return response;
  }

  PlugConnectorModel plugConnectorModel = PlugConnectorModel();

  Future<void> getPlugConnectData() async {
    final response = await DashboardHostRepo().getPlugConnector();
    plugConnectorModel = response;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> hostWithdrawRquest() async {
    final response = await DashboardHostRepo().hostWithdrawRquest();
    return response;
  }
}
