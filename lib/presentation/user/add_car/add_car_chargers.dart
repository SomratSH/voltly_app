import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/user/add_car/car_add_provider.dart';
import 'package:voltly_app/presentation/user/add_car/select_car_details.dart';

class AddCarChargers extends StatelessWidget {
  const AddCarChargers({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CarAddProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.carName,
                    style: TextStyle(
                      color: const Color(0xFFBEBEBE),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.add, color: Colors.white),
                ],
              ),
              const SizedBox(height: 20.0),
              // Registration Number Section
              const Text(
                'Registration number',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              vPad10,
              Container(
                decoration: ShapeDecoration(
                  color: Colors.black.withValues(alpha: 0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    provider.updateRegistrationNumnber(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter registration number',
                    hintStyle: TextStyle(color: Color(0xFF787878)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Select Vehicle Plug Section
              Row(
                children: [
                  SvgPicture.asset("assets/icon/car-sport-outline.svg"),
                  SizedBox(width: 10.0),
                  Text(
                    'Select Vehicle Plug',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              Wrap(
                alignment: WrapAlignment.center,
                spacing: 14,
                runSpacing: 16,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPlugChip(
                        context,
                        'Type A',
                        'assets/icon/typeA.svg',
                        provider,
                      ),
                      hPad10,
                      _buildPlugChip(
                        context,
                        'CHAdeMO',
                        'assets/icon/chademo.svg',
                        provider,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPlugChip(
                        context,
                        'Type B',
                        'assets/icon/typeB.svg',
                        provider,
                      ),
                      hPad10,
                      _buildPlugChip(
                        context,
                        'CCS-cable',
                        'assets/icon/csscable.svg',
                        provider,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50.0),

              PrimaryButton(
                text: "Submit",
                onPressed: () async {
                  if (provider.carName.isEmpty ||
                      provider.selectedPlug.isEmpty ||
                      provider.pickedImage == null ||
                      provider.selectedVehicleType.isEmpty) {
                    CustomSnackbar.show(
                      context,
                      message: "Fill up all data",
                      backgroundColor: Colors.red,
                    );
                  } else {
                    LoadingDialog.show(context);
                    final status = await provider.addCarData();
                    print("data $status");
                    LoadingDialog.hide(context);
                    if (status["data"]["id"] != null) {
                      CustomSnackbar.show(
                        context,
                        message: "Car Added Successfully",
                      );
                      provider.getVehicleList();
                      context.go(RouterPath.addCar);
                    }
                  }
                },
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlugChip(
    BuildContext context,
    String type,
    String iconUrl,
    CarAddProvider provider,
  ) {
    final isSelected = provider.selectedPlug == type;

    return GestureDetector(
      onTap: () {
        provider.selectPlug(type);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 110,
        height: 110,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : const Color(0xFF1E2C2A),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconUrl,
              width: 40,
              color: isSelected ? Colors.black : Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              type,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
