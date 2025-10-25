import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/user/add_car/car_add_provider.dart';

class VehicleDetails extends StatelessWidget {
  const VehicleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final carProvider = context.watch<CarAddProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          carProvider.vechicleDetailsModel.vehicleName ?? "Vehicle Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: carProvider.vechicleDetailsModel.image != null
                  ? Image.network(
                      "${AppUrls.imageUrl}${carProvider.vechicleDetailsModel.image}",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "https://placehold.co/600x300?text=No+Image",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint("❌ Image load failed: $error");
                        return Image.network(
                          'https://www.directmobilityonline.co.uk/assets/img/noimage.png',
                          fit: BoxFit.cover,
                          height: 160,
                          width: double.infinity,
                        );
                      },
                    ),
            ),

            const SizedBox(height: 20),

            // Vehicle Name
            Text(
              carProvider.vechicleDetailsModel.vehicleName ?? "Unknown Vehicle",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            Text(
              carProvider.vechicleDetailsModel.user ?? "",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 10),

            // Info cards
            _infoRow(
              "Registration Number",
              carProvider.vechicleDetailsModel.registrationNumber,
            ),
            _infoRow(
              "Vehicle Type",
              carProvider.vechicleDetailsModel.vehicleType!.isNotEmpty
                  ? carProvider.vechicleDetailsModel.vehicleType
                  : "N/A",
            ),
            _infoRow("Plug Type", carProvider.vechicleDetailsModel.plugType),
            _infoRow(
              "Battery Type",
              carProvider.vechicleDetailsModel.batteryType!.isNotEmpty
                  ? carProvider.vechicleDetailsModel.batteryType!
                  : "N/A",
            ),
            _infoRow(
              "Battery Capacity",
              carProvider.vechicleDetailsModel.batteryCapacity!.isNotEmpty
                  ? carProvider.vechicleDetailsModel.batteryCapacity!
                  : "N/A",
            ),

            const SizedBox(height: 20),

            // // Button
            // Center(
            //   child: ElevatedButton.icon(
            //     style: ElevatedButton.styleFrom(
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 24,
            //         vertical: 12,
            //       ),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     icon: const Icon(Icons.edit),
            //     label: const Text("Edit Vehicle"),
            //     onPressed: () {
            //       // TODO: Navigate to edit page
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text("Edit vehicle tapped")),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  /// Helper Widget for info rows
  Widget _infoRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Flexible(
            child: Text(
              value?.toString().isNotEmpty == true ? value.toString() : "N/A",
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
