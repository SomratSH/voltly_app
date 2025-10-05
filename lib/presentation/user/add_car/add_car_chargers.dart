import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/user/add_car/select_car_details.dart';

class VehiclePlugSelectionScreen extends StatefulWidget {
  const VehiclePlugSelectionScreen({super.key});

  @override
  _VehiclePlugSelectionScreenState createState() =>
      _VehiclePlugSelectionScreenState();
}

class _VehiclePlugSelectionScreenState
    extends State<VehiclePlugSelectionScreen> {
  String? selectedPlug;

  @override
  Widget build(BuildContext context) {
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
                    'Tesla CS23',
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
                child: const TextField(
                  style: TextStyle(color: Colors.white),
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

              // Plug Options
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPlugChip('Type A', "assets/icon/typeA.svg"),
                  _buildPlugChip('CHAdeMO', "assets/icon/chademo.svg"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPlugChip('Type B', "assets/icon/typeB.svg"),
                  _buildPlugChip('CCS-cable', "assets/icon/csscable.svg"),
                ],
              ),
              const SizedBox(height: 50.0),

              PrimaryButton(
                text: "Submit",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectCarDetails()),
                  );
                },
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlugChip(String type, String iconUrl) {
    bool isSelected = selectedPlug == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlug = type;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(15),
          decoration: ShapeDecoration(
            color: isSelected ? primaryColor : const Color(0x7FC4C4C4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Placeholder for the plug icon
              SvgPicture.asset(
                iconUrl,
                color: isSelected ? Colors.black : Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                type,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.60),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                  height: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
