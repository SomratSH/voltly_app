import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/user/add_car/car_add_provider.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class CarSelectorBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF121C24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final provider = context.watch<StationProvider>();
        final carProvider = context.watch<CarAddProvider>();

        if (carProvider.carList.isEmpty) {
          return SizedBox(
            height: 100,
            width: double.infinity,
            child: Center(
              child: Text(
                "No cars available",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          );
        }

        return SizedBox(
          width: double.infinity, // Full width
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Car",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: carProvider.carList.map((car) {
                    final isSelected = provider.selectCarId == car.id;
                    return GestureDetector(
                      onTap: () {
                        provider.setSelectedCar(car.id!);
                        CustomSnackbar.show(
                          context,
                          message: "Select car successfully",
                        );
                        Navigator.pop(
                          context,
                        ); // Close bottom sheet after selection
                      },
                      child: Container(
                        width: double.infinity, // Ensure full width
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? driverPrimaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? driverPrimaryColor : Colors.white54,
                          ),
                        ),
                        child: Text(
                          car.vehicleDetails!.name ?? "Car ${car.id}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white70,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
