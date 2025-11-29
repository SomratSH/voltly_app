import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/user/home_page/home_provider.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final PolylinePoints polylinePoints = PolylinePoints(apiKey: 'YOUR_API_KEY');

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      markers.add(
        Marker(
          markerId: const MarkerId("me"),
          position: currentLocation!,
          infoWindow: const InfoWindow(title: "My Location"),
        ),
      );
    });

    // Add nearby stations after current location is ready
    _addNearbyStations();
  }

  void _addNearbyStations() {
    final provider = context.read<StationProvider>();
    final stations =
        provider.stationList; // Assuming this list has lat, lng, name, image

    for (var station in stations) {
      markers.add(
        Marker(
          markerId: MarkerId(station.id.toString()), // or unique string
          position: LatLng(station.latitude!, station.longitude!),
          infoWindow: InfoWindow(title: station.stationName),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
        ),
      );
    }

    setState(() {});
  }

  Future<void> getRoute(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(startLat, startLng),
        destination: PointLatLng(endLat, endLng),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {
        polylines = {
          Polyline(
            polylineId: const PolylineId("route"),
            width: 6,
            color: Colors.blue,
            points: polylineCoordinates,
          ),
        };
      });

      _fitRouteToScreen();
    }
  }

  Future<void> _fitRouteToScreen() async {
    if (polylineCoordinates.isEmpty) return;
    final controller = await _controller.future;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        polylineCoordinates
            .map((p) => p.latitude)
            .reduce((a, b) => a < b ? a : b),
        polylineCoordinates
            .map((p) => p.longitude)
            .reduce((a, b) => a < b ? a : b),
      ),
      northeast: LatLng(
        polylineCoordinates
            .map((p) => p.latitude)
            .reduce((a, b) => a > b ? a : b),
        polylineCoordinates
            .map((p) => p.longitude)
            .reduce((a, b) => a > b ? a : b),
      ),
    );

    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  void goToDestination(double lat, double lng) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();
    final stations = provider.stationList;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Google Map Route",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),

      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: currentLocation!,
                    zoom: 14,
                  ),
                  markers: markers,
                  polylines: polylines,
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                    Future.delayed(const Duration(milliseconds: 200), () {
                      controller?.setMapStyle(darkMapStyle).catchError((error) {
                        print('Error setting map style: $error');
                      });
                    });
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
                // Bottom station list
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 150,
                  child: Container(
                    color: Colors.white.withOpacity(0.9),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: stations.length,
                      itemBuilder: (context, index) {
                        final station = stations[index];
                        return GestureDetector(
                          onTap: () {
                            goToDestination(
                              station.latitude!,
                              station.longitude!,
                            );
                          },
                          child: Container(
                            width: 120,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.blue.shade50,
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  AppUrls.imageUrl + station.image!,
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  station.stationName!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
