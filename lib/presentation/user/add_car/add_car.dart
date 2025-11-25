import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart' as AppColors;
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/user/add_car/car_add_provider.dart';
import 'package:voltly_app/presentation/user/add_car/munal_add_car.dart';

class AddCar extends StatelessWidget {
  const AddCar({super.key});

  @override
  Widget build(BuildContext context) {
    final carProvider = context.watch<CarAddProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Vehicles"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: carProvider.carList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/image/add_car.png", height: 180),
                      const SizedBox(height: 20),
                      const Text(
                        'No vehicle found',
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 22,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      vPad15,
                      PrimaryButton(
                        text: "Add Vehicle",
                        onPressed: () {
                          context.push(RouterPath.manualAddCar);
                        },
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(12),
                        itemCount: carProvider.carList.length,
                        itemBuilder: (context, index) {
                          final vehicle = carProvider.carList[index];
                          return Card(
                            elevation: 3,
                            color: AppColors.primaryColor,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: vehicle.vehicleDetails!.name != null
                                    ? Image.network(
                                        "${AppUrls.imageUrl}${vehicle.vehicleDetails!.image}",
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        "https://placehold.co/100x100?text=No+Image",
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          debugPrint(
                                            "❌ Image load failed: $error",
                                          );
                                          return Image.network(
                                            'https://www.directmobilityonline.co.uk/assets/img/noimage.png',
                                            fit: BoxFit.cover,
                                            width: 60,
                                            height: 60,
                                          );
                                        },
                                      ),
                              ),
                              title: Text(
                                vehicle.vehicleDetails!.name ??
                                    "Unknown Vehicle",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reg: ${vehicle.vehicleDetails!.batteryType}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    "Plug Type: ${vehicle.selectedPlugName}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                              onTap: () async {
                                LoadingDialog.show(context);
                                final status = await carProvider
                                    .getDetailsVehicle(vehicle.id!);
                                LoadingDialog.hide(context);
                                context.push(RouterPath.carDetails);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    PrimaryButton(
                      text: "Add",
                      onPressed: () {
                        context.push(RouterPath.manualAddCar);
                      },
                    ),
                    SizedBox(height: 100),
                  ],
                ),
        ),
      ),
    );
  }
}
