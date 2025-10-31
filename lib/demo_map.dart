// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter/services.dart' show rootBundle;

// class DarkMapWithTraffic extends StatefulWidget {
//   const DarkMapWithTraffic({super.key});

//   @override
//   State<DarkMapWithTraffic> createState() => _DarkMapWithTrafficState();
// }

// class _DarkMapWithTrafficState extends State<DarkMapWithTraffic> {
//   final Completer<GoogleMapController> _controller = Completer();
//   final Location _location = Location();

//   String? _mapStyle;
//   BitmapDescriptor? _carIcon;
//   Marker? _userMarker;

//   @override
//   void initState() {
//     super.initState();
//     _loadMapStyle();
//     _loadCarIcon();
//   }

//   Future<void> _loadMapStyle() async {
//     final style = await rootBundle.loadString('assets/map/map_style_dark.json');
//     setState(() => _mapStyle = style);
//   }

//   /// ✅ Load car marker icon (resized properly)
//   Future<void> _loadCarIcon() async {
//     final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(64, 64)),
//       'assets/image/rsz_110382282.png',
//     );
//     setState(() => _carIcon = icon);
//   }

//   /// ✅ Get current location & move camera to it
//   Future<void> _moveCameraToCurrentLocation() async {
//     final GoogleMapController controller = await _controller.future;
//     final currentLocation = await _location.getLocation();

//     final target = LatLng(currentLocation.latitude!, currentLocation.longitude!);

//     controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: target, zoom: 16),
//       ),
//     );

//     setState(() {
//       _userMarker = Marker(
//         markerId: const MarkerId('user_location'),
//         position: target,
//         icon: _carIcon ?? BitmapDescriptor.defaultMarker,
//         rotation: currentLocation.heading ?? 0,
//         anchor: const Offset(0.5, 0.5),
//       );
//     });

//     // Keep tracking for live updates
//     _trackUserLocation();
//   }

//   /// ✅ Listen for location updates (marker follows movement)
//   Future<void> _trackUserLocation() async {
//     bool serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//       if (!serviceEnabled) return;
//     }

//     PermissionStatus permissionGranted = await _location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) return;
//     }

//     _location.onLocationChanged.listen((LocationData currentLocation) async {
//       final GoogleMapController controller = await _controller.future;

//       final position = LatLng(
//         currentLocation.latitude!,
//         currentLocation.longitude!,
//       );

//       setState(() {
//         _userMarker = Marker(
//           markerId: const MarkerId('user_location'),
//           position: position,
//           icon: _carIcon ?? BitmapDescriptor.defaultMarker,
//           rotation: currentLocation.heading ?? 0,
//           anchor: const Offset(0.5, 0.5),
//         );
//       });

//       controller.animateCamera(
//         CameraUpdate.newLatLng(position),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _mapStyle == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               initialCameraPosition: const CameraPosition(
//                 target: LatLng(23.8103, 90.4125), // Default (Dhaka)
//                 zoom: 14,
//               ),
//               onMapCreated: (controller) async {
//                 _controller.complete(controller);
//                 await _moveCameraToCurrentLocation(); // ✅ focus on current location
//               },
//               style: _mapStyle,
//               trafficEnabled: true,
//               zoomControlsEnabled: true,
//               myLocationEnabled: false, // disable blue dot
//               markers: _userMarker != null ? {_userMarker!} : {},
//             ),
//     );
//   }
// }
