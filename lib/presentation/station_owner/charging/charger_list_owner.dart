import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';

class ChargerListOwner extends StatefulWidget {
  const ChargerListOwner({super.key});

  @override
  State<ChargerListOwner> createState() => _ChargerListOwnerState();
}

class _ChargerListOwnerState extends State<ChargerListOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Chargers',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildChargerCard(
              chargerName: 'Level 2 Charger',
              location: '123 St, Midtown expressway',
              price: '\$5/hr',
              isActive: true,
            ),
            const SizedBox(height: 16),
            _buildChargerCard(
              chargerName: 'Tesla Wall\nConnector',
              location: '456 Oak Ave, Residential',
              price: '\$8/hr',
              isActive: false,
            ),
            const SizedBox(height: 16),
            _buildChargerCard(
              chargerName: 'Level 1 Charger',
              location: '789 Pine Rd, Garage',
              price: '\$3/hr',
              isActive: true,
            ),
            const Spacer(),
            _buildAddChargerButton(),
            vPad20,
          ],
        ),
      ),
    );
  }

  Widget _buildChargerCard({
    required String chargerName,
    required String location,
    required String price,
    required bool isActive,
  }) {
    Color statusColor = isActive ? hostprimaryColor : const Color(0xFF888888);
    String statusText = isActive ? 'Active' : 'Inactive';

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: ShapeDecoration(
        color: const Color(0xFF182724),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 15,
            offset: Offset(0, 10),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.70, color: const Color(0xFFD1D5DB)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icon/first_charger.svg",
              color: hostprimaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chargerName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: isActive,
                    onChanged: (bool value) {},
                    activeColor: hostprimaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 30,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: const Color(0xFFD1D5DB),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddChargerButton() {
    return PrimaryButton(text: "Add New Charger", onPressed: () {});
  }
}
