import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openMapToAddress({
  required String destinationLat,
  required String destinationLang,
}) async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("Location permission denied");
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    print("Location permission permanently denied");
    return null;
  }

  // Get current position
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // Create the URL with lat/long for both origin and destination
  final Uri googleMapUrl = Uri.parse(
    'https://www.google.com/maps/dir/?api=1'
    '&origin=${position.latitude},${position.longitude}'
    '&destination=${destinationLat},${destinationLang}'
    '&travelmode=driving',
  );

  // Try opening in external app first, fallback to browser
  try {
    final launched = await launchUrl(
      googleMapUrl,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      // fallback to browser
      await launchUrl(googleMapUrl, mode: LaunchMode.inAppBrowserView);
    }
  } catch (e) {
    // ultimate fallback
    await launchUrl(googleMapUrl, mode: LaunchMode.platformDefault);
  }
}
