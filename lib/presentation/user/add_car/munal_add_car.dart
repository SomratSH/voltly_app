import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/user/add_car/add_car_chargers.dart';
import 'package:voltly_app/presentation/user/add_car/car_add_provider.dart';

class MunalAddCar extends StatelessWidget {
  const MunalAddCar({super.key});

  @override
  Widget build(BuildContext context) {
    final addCarProvider = context.watch<CarAddProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121C24),
        title: const Text("Add Car", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              vPad20,

              // Vehicle Type Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildVehicleTypeChip(
                    'Car',
                    Icons.directions_car,
                    addCarProvider,
                    context,
                  ),
                  const SizedBox(width: 10.0),
                  _buildVehicleTypeChip(
                    'Bike',
                    Icons.motorcycle,
                    addCarProvider,
                    context,
                  ),
                ],
              ),
              vPad20,

              // Vehicle Image Section
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF162521), Color(0xFF293933)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Glow effect
                          Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor,
                                  blurRadius: 100,
                                  spreadRadius: 50,
                                ),
                              ],
                            ),
                          ),

                          // Vehicle Image (default or picked)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: addCarProvider.pickedImage != null
                                ? Image.file(
                                    addCarProvider.pickedImage!,
                                    width: 280,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/image/manual_add_car.png',
                                    width: 280,
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Add Car Image Button
                      ElevatedButton.icon(
                        onPressed: addCarProvider.pickImage,
                        icon: const Icon(Icons.add_photo_alternate_outlined),
                        label: const Text('Add Car Image'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              vPad20,

              const Divider(color: Color(0xFF293933), thickness: 1.0),
              vPad20,

              Container(
                decoration: ShapeDecoration(
                  color: Colors.black.withValues(alpha: 0),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF4B5563)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextField(
                  onChanged: (v) {
                    addCarProvider.updateCarName(v);
                  },
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Enter Car Name",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(
                      Icons.directions_car,
                      color: Color(0xFF388E3C),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              vPad20,

              // Proceed Button
              PrimaryButton(
                text: "Proceed",
                onPressed: () {
                  context.push(RouterPath.addCarCharger);
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleTypeChip(
    String type,
    IconData icon,
    CarAddProvider provider,
    BuildContext context,
  ) {
    bool isSelected = provider.selectedVehicleType == type;

    return GestureDetector(
      onTap: () {
        provider.selectVehicle(type);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : const Color(0xFF293933),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFF8B9B95),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(type, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
