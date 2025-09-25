import 'package:flutter/material.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/presentation/station_owner/charging/charger_list_owner.dart';

class AddChargerOwner extends StatefulWidget {
  const AddChargerOwner({super.key});

  @override
  State<AddChargerOwner> createState() => _AddChargerOwnerState();
}

class _AddChargerOwnerState extends State<AddChargerOwner> {
  String? _selectedChargerType;
  int? _selectedExtension;
  bool _isAvailable = true;

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
          'Add Charger',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Charger Type'),
            const SizedBox(height: 8),
            _buildChargerTypeDropdown(),
            const SizedBox(height: 16),
            _buildSectionTitle('Charger Name/Label'),
            const SizedBox(height: 8),
            _buildChargerNameInput(),
            const SizedBox(height: 16),
            _buildSectionTitle('Location'),
            const SizedBox(height: 8),
            Text(
              'Pin Location',
              style: TextStyle(
                color: const Color(0xFFD1D5DB),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            vPad5,
            _buildMapPlaceholder(),
            const SizedBox(height: 16),
            _buildSectionTitle('Address'),
            const SizedBox(height: 8),
            _buildAddressInput(),
            const SizedBox(height: 16),
            _buildSectionTitle('Pricing'),
            const SizedBox(height: 8),
            _buildPricingInputs(),
            vPad20,
            Row(
              children: [
                _statusChargingCard("Charging Fee", "00", "THB"),
                hPad10,
                _statusChargingCard("Charging ", "00", "kW/h"),
                hPad10,
                _statusChargingCard("Service Fee", "00", "THB"),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Availability'),
            const SizedBox(height: 8),
            _buildAvailabilityRow(),
            const SizedBox(height: 16),
            _buildDaySelection(),
            const SizedBox(height: 16),
            _buildSectionTitle('Charging Not Yet Complete?'),
            const SizedBox(height: 8),
            _buildChargingOptions(),
            const SizedBox(height: 32),
            _buildButtons(),
            vPad20,
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildChargerTypeDropdown() {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFF182724),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
        hint: const Text(
          'Select charger type',
          style: TextStyle(color: Color(0xFF5A5A5A)),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF5A5A5A)),
        dropdownColor: const Color(0xFF282828),
        items: ['Type 1', 'Type 2', 'CHAdeMO', 'CCS'].map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedChargerType = newValue;
          });
        },
        value: _selectedChargerType,
      ),
    );
  }

  Widget _buildChargerNameInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: ShapeDecoration(
              color: const Color(0xFF182724),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                hintText: 'e.g., Home Garage Charger',
                hintStyle: TextStyle(color: Color(0xFF5A5A5A)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 50,
          height: 50,
          decoration: ShapeDecoration(
            color: const Color(0xFF182724),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.add_rounded, color: Color(0xFF5A5A5A)),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFF182724),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
          side: BorderSide(color: const Color(0xFFE5E7EB)),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.location_on, size: 50, color: Colors.green),
          const Positioned(
            bottom: 20,
            child: Text(
              'Tap to set location',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFD1D5DB),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInput() {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFF182724),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: 'Address will auto-fill from map',
          hintStyle: TextStyle(color: Color(0xFF5A5A5A)),
        ),
      ),
    );
  }

  Widget _buildPricingInputs() {
    return Row(
      children: [
        Expanded(child: _buildPriceField('Price per hour', '\$ 0.00')),
        const SizedBox(width: 16),
        Expanded(child: _buildPriceField('Price per kWh', '\$ 0.00')),
      ],
    );
  }

  Widget _buildPriceField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFFD1D5DB),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: ShapeDecoration(
            color: const Color(0xFF182724),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: TextField(
            style: TextStyle(
              color: const Color(0xFFD1D5DB),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF5A5A5A)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statusChargingCard(String label, String value, String valuTitle) {
    return Expanded(
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: const Color(0xFF00AB82)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFE6E6E6),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.71,
                ),
              ),
              vPad10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF01CC01),
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                  hPad5,
                  Text(
                    valuTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFE6E6E6),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvailabilityRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Available 24/7',
          style: TextStyle(
            color: const Color(0xFFD1D5DB),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 1.43,
          ),
        ),
        Switch(
          value: _isAvailable,
          onChanged: (bool value) {
            setState(() {
              _isAvailable = value;
            });
          },
          activeColor: const Color(0xFF01CC01),
        ),
      ],
    );
  }

  Widget _buildDaySelection() {
    final days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: const Color(0xFF182724),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: days.map((day) {
            bool isSelected =
                day == 'M' || day == 'T' || day == 'W' || day == 'F';
            return InkWell(
              onTap: () {
                setState(() {
                  if (day == day) {
                    isSelected = true;
                  } else {
                    isSelected = false;
                  }
                });
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: isSelected
                    ? ShapeDecoration(
                        color: const Color(0x3301CC01),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: const Color(0xFFE5E7EB)),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      )
                    : ShapeDecoration(
                        color: Colors.black.withValues(alpha: 0),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: const Color(0xFFE5E7EB)),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF5A5A5A),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildChargingOptions() {
    final options = [
      {'title': 'Extended For 10 Min', 'price': 'EST 0.02\$'},
      {'title': 'Extended For 10 Min', 'price': 'EST 0.25\$'},
      {'title': 'Extended For 25 Min', 'price': 'EST 0.25\$'},
    ];

    return Column(
      children: options.map((option) {
        final index = options.indexOf(option);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.50, color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: RadioListTile<int>(
              title: Text(
                option['title']!,
                style: TextStyle(
                  color: const Color(0xFFBEBEBE),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: index,
              groupValue: _selectedExtension,
              onChanged: (int? value) {
                setState(() {
                  _selectedExtension = value;
                });
              },
              secondary: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(
                  option['price']!,
                  style: TextStyle(
                    color: const Color(0xFFBEBEBE),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              activeColor: Color(0xFF01CC01),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF888888)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF888888)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PrimaryButton(
            text: "Publish",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChargerListOwner()),
              );
            },
          ),
        ),
      ],
    );
  }
}
