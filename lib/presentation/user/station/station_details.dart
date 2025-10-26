import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/user/station/booking_page.dart';
import 'package:voltly_app/presentation/user/station/scanner_screen.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class StationDetails extends StatelessWidget {
  const StationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Station Image
                      Container(
                        width: 60,
                        height: 60,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/image/station_details.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12), // spacing between image & text
                      // Station Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.selectedStation.name!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Row(
                              children: [
                                Icon(Icons.star, color: primaryColor, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'High score 5/5',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Text(
                                  'Open',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '09.00 - 22.00',
                                  style: TextStyle(
                                    color: const Color(0xFFB5B5B5),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Divider(),
                  vPad10,
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primaryColor, size: 16),
                      SizedBox(width: 8),
                      Text(
                        '${provider.selectedStation.distanceKm} Km.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          provider.selectedStation.address!,
                          style: TextStyle(
                            color: const Color(0xFFF2F2F2),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  vPad10,
                  PrimaryButton(text: "Go to Map", onPressed: () {}),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _ScanToChargeButton(),
            vPad15,

            _buildSectionTitle('Connector Type'),
            Divider(color: primaryColor),
            _buildConnectorType(
              iconPath: 'assets/icon_type1.png',
              type: 'Type 1 (AC)',
              power: '11.04 kW',
              status: 'Walk in',
              isAvailable: true,
            ),
            _buildConnectorType(
              iconPath: 'assets/icon_type2.png',
              type: 'Type 2 (AC)',
              power: '11.04 kW',
              status: 'Closed',
              isAvailable: false,
            ),
            _buildConnectorType(
              iconPath: 'assets/icon_ccs2.png',
              type: 'CCS2 (AC)',
              power: '11.04 kW',
              status: 'Walk in',
              isAvailable: true,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Service fee'),
            Divider(color: Color(0xff00AB82)),
            _buildServiceFeeItem('By Energy Unit'),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const SeviceFee();
                  },
                );
              },
              child: _buildServiceFeeItem('Extra Service Fee'),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const _RescheduleSessionDialog();
                  },
                );
              },
              child: _buildServiceFeeItem('Choose time'),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Reviews'),
            _buildReviews(),
            const SizedBox(height: 24),
            _buildReviewInput(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _BookNowButton(),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Image.asset(
            'assets/image/station_details.png', // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset("assets/icon/ph_bell.svg"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFFFCEFEF),
          fontSize: 18,
          fontFamily: 'Kanit',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildConnectorType({
    required String iconPath,
    required String type,
    required String power,
    required String status,
    required bool isAvailable,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),

                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  color: primaryColor,
                  "assets/icon/first_charger.svg",
                ), // Using a generic icon
              ),
              vPad10,
              Text(
                'Type 1 (AC)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFFCEFEF),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '11.04 kW',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFFCEFEF),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          Text(
            'ABC charging \nstation',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: isAvailable ? primaryColor : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceFeeItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w400,
            ),
          ),
          SvgPicture.asset("assets/icon/arrow.svg", color: primaryColor),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.star, color: Colors.white, size: 24),
              Icon(Icons.star, color: Colors.white, size: 24),
              Icon(Icons.star, color: Colors.white, size: 24),
              Icon(Icons.star_border, color: Colors.white, size: 24),
              Icon(Icons.star_border, color: Colors.white, size: 24),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '10 review photos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,

              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildReviewPhoto('assets/image/station_one.jpg'),
              _buildReviewPhoto('assets/image/station_two.jpg'),
              _buildReviewPhoto('assets/image/station_three.jpg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewPhoto(String assetPath) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(assetPath), // Replace with your image asset
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildReviewInput() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFC5D0E6)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Review...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Icon(Icons.photo_library_outlined, color: Colors.white70),
          SizedBox(width: 8),
          SvgPicture.asset("assets/icon/send-2.svg", color: primaryColor),
        ],
      ),
    );
  }
}

class _GoToMapButton extends StatelessWidget {
  const _GoToMapButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2E3E2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF33D933)),
      ),
      child: const Text(
        'Go To Map',
        style: TextStyle(color: Color(0xFF33D933), fontSize: 12),
      ),
    );
  }
}

class _ScanToChargeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ScannerScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Scan to charge',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookNowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: "Book Now",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ChargingSummaryPage()),
        );
      },
    );
  }
}

class _RescheduleSessionDialog extends StatefulWidget {
  const _RescheduleSessionDialog();

  @override
  State<_RescheduleSessionDialog> createState() =>
      _RescheduleSessionDialogState();
}

class _RescheduleSessionDialogState extends State<_RescheduleSessionDialog> {
  String? selectedTimeSlot;
  int selectedDayIndex = 3; // Wednesday

  final List<String> timeSlots = [
    '10:00 AM - 11:00 AM',
    '12:30 PM - 01:30 PM',
    '2:30 PM - 03:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Color(0xFF121C24),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Let's reschedule your Session",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "We understand plans change. Choose a new time that works best for you.",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            const Text(
              "Available Time Slot",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text("Select Days", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            _buildDaySelector(provider.selectedStation.details!.availableDays!),
            const SizedBox(height: 24),
            const Text("Select Hours", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            _buildTimeSlotSelector(),
            const SizedBox(height: 24),
            _buildRescheduleButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySelector(List<String> days) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFF182724),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(days.length, (index) {
            bool isSelected = index == selectedDayIndex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDayIndex = index;
                });
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0x3301CC01)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Colors.white24,
                  ),
                ),
                child: Center(
                  child: Text(
                    days[index][0],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTimeSlotSelector() {
    return Column(
      children: timeSlots.map((slot) {
        bool isSelected = selectedTimeSlot == slot;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedTimeSlot = slot;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Color(0xFF01CC01)
                      : const Color(0xFF2E3E2E),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF33D933)
                            : Colors.white70,
                        width: 2,
                      ),
                      color: isSelected
                          ? const Color(0xFF33D933)
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Center(
                            child: Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.black,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    slot,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRescheduleButton(BuildContext context) {
    return PrimaryButton(
      text: "Reschedule Session",
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

class SeviceFee extends StatefulWidget {
  const SeviceFee();

  @override
  State<SeviceFee> createState() => SeviceFeeState();
}

class SeviceFeeState extends State<SeviceFee> {
  String? selectedTimeSlot;
  int selectedDayIndex = 3; // Wednesday

  final List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<String> timeSlots = [
    '10:00 AM - 11:00 AM',
    '12:30 PM - 01:30 PM',
    '2:30 PM - 03:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Color(0xFF121C24),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Charging Not Yet Complete?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 1.22,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Session Is ending Extend Time to continue charging seamlessly.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.57,
              ),
            ),

            _buildTimeSlotSelector(),
            Text(
              'If not extended, your session will stop automatically.\nReconnecting may require new availability confirmation.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.83,
              ),
            ),
            const SizedBox(height: 24),
            _buildRescheduleButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlotSelector() {
    return Column(
      children: timeSlots.map((slot) {
        bool isSelected = selectedTimeSlot == slot;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedTimeSlot = slot;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Color(0xFF01CC01)
                      : const Color(0xFF2E3E2E),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF33D933)
                            : Colors.white70,
                        width: 2,
                      ),
                      color: isSelected
                          ? const Color(0xFF33D933)
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Center(
                            child: Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.black,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    slot,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRescheduleButton(BuildContext context) {
    return PrimaryButton(
      text: "Extend Session",
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
