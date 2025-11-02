
part of '../add_charger_owner.dart';

class MapPickerWidget extends StatelessWidget {
  const MapPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mapProvider = context.watch<ChargingProvider>()..initCurrentLocation();

    if (mapProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (mapProvider.selectedPosition == null) {
      return Container(
        height: 180,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF182724),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: const Text(
          'Location permission denied',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: GoogleMap(
              onMapCreated: mapProvider.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: mapProvider.selectedPosition!,
                zoom: 15,
              ),
              onCameraMove: mapProvider.onCameraMove,
              onCameraIdle: mapProvider.onCameraIdle,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),
          const Icon(Icons.location_pin, size: 50, color: Colors.redAccent),
          Positioned(
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                mapProvider.address,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
