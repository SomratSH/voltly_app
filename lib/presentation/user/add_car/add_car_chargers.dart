import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voltly_app/common/custom_padding.dart';

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
        backgroundColor: Color(0xFF121C24),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button press
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
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
                children: [
                  _buildPlugChip('Type A'),
                  _buildPlugChip('CHAdeMO'),
                  _buildPlugChip('Type B'),
                  _buildPlugChip('CCS-cable'),
                ],
              ),
              const SizedBox(height: 50.0),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  // Handle submit button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff01CC01),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlugChip(String type) {
    bool isSelected = selectedPlug == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlug = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff01CC01) : const Color(0xFF293933),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFF4B5563),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for the plug icon
            Icon(
              Icons.bolt,
              color: isSelected ? Colors.white : const Color(0xFF787878),
            ),
            const SizedBox(height: 8),
            Text(
              type,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF787878),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
