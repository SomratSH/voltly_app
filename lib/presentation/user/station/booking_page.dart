import 'package:flutter/material.dart';
import 'package:voltly_app/common/custom_appbar.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/presentation/user/station/scanner_screen.dart';

class ChargingSummaryPage extends StatelessWidget {
  const ChargingSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Car',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFEDEDED),
                  fontSize: 22,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              _buildCarInfoCard(),
              const SizedBox(height: 24),
              Text(
                'Charging Station',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFEDEDED),
                  fontSize: 22,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              _buildStationInfoCard(),
              Divider(color: Color(0xFF1F8D3C)),
              vPad10,
              _buildSessionDetails(),
              const SizedBox(height: 24),
              _buildAmountEstimation(),
              const SizedBox(height: 48),
              _buildScanToChargeButton(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Tesla CS23',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFBEBEBE),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    hPad20,
                    Text(
                      'ABCD \nType 2',
                      style: TextStyle(
                        color: const Color(0xFFD7D7D7),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFF01CC01),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.battery_charging_full,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Charging',
                  style: TextStyle(
                    color: const Color(0xFFD7D7D7),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/image/station_details.png',
                ), // Placeholder
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ABC charging station',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0xFFF3B924), size: 24),
                    SizedBox(width: 4),
                    Text(
                      'High score 5/5',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Open',
                      style: TextStyle(
                        color: Color(0xFF33D933),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '09:00 - 22:00',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.50),
          end: Alignment(1.00, 0.50),
          colors: [const Color(0x33182724), const Color(0x192ECC71)],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0x4C2ECC71)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Booking Date', '15 Sep 2025'),

          _buildDetailRow('Charging Duration', '60 Minute'),

          _buildDetailRow('Charging Session Timing', '10 AM'),
        ],
      ),
    );
  }

  Widget _buildAmountEstimation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.50),
          end: Alignment(1.00, 0.50),
          colors: [const Color(0x33182724), const Color(0x192ECC71)],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0x4C2ECC71)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Amount Estimation', '\$ 0.00'),

          _buildDetailRow('Tax', '\$ 0.00'),
          Divider(color: Color(0xFF9CA3AF)),

          _buildDetailRow('Total Amount', '\$ 0.00'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanToChargeButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ScannerScreen()),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: ShapeDecoration(
          color: const Color(0xFF01CC01),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: [
            BoxShadow(
              color: Color(0x5907775C),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
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
