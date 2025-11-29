import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/commone_helper.dart';
import 'package:voltly_app/common/custom_appbar.dart';
import 'package:voltly_app/common/custom_html_text.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/user/station/scanner_screen.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Booking Details", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
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
              _buildCarInfoCard(provider),
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
              _buildStationInfoCard(provider),
              Divider(color: driverPrimaryColor),
              vPad10,
              _buildSessionDetails(provider),
              const SizedBox(height: 24),
              _buildAmountEstimation(provider),
              const SizedBox(height: 24),
              _buildCloseButtom(context),
              const SizedBox(height: 10),
              provider.bookingDetailsModel.bookingDetails!.status == "confirmed"
                  ? _buildScanToChargeButton(context, provider)
                  : SizedBox(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarInfoCard(StationProvider provider) {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.bookingDetailsModel.vehicle!.model!,
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
                      provider.bookingDetailsModel.vehicle!.plugType!,
                      style: TextStyle(
                        color: const Color(0xFFD7D7D7),
                        fontSize: 12,
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
              color: driverPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                provider.bookingDetailsModel.vehicle!.bookingStatus!,
                style: TextStyle(
                  color: const Color(0xFFD7D7D7),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationInfoCard(StationProvider provider) {
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
              image: DecorationImage(
                image:
                    provider.bookingDetailsModel.chargingStation!.image == null
                    ? NetworkImage('assets/image/station_details.png')
                    : NetworkImage(
                        AppUrls.imageUrl +
                            provider
                                .bookingDetailsModel
                                .chargingStation!
                                .image!,
                      ), // Placeholder
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.bookingDetailsModel.chargingStation!.stationName!,
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
                      'High score ${provider.bookingDetailsModel.chargingStation!.rating}/5',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      provider.bookingDetailsModel.chargingStation!.status ==
                              "OP"
                          ? 'Open'
                          : "Closed",
                      style: TextStyle(
                        color: driverPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${convertTo12HourFormat(provider.bookingDetailsModel.chargingStation!.openTime!)} - ${convertTo12HourFormat(provider.bookingDetailsModel.chargingStation!.closeTime!)}',
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

  Widget _buildSessionDetails(StationProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.50),
          end: Alignment(1.00, 0.50),
          colors: [const Color(0x33182724), const Color(0x192ECC71)],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: driverPrimaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Booking Date',
            '${provider.bookingDetailsModel.bookingDetails!.bookingDate!}',
          ),

          _buildDetailRow('Charging Duration', '60 Minute'),

          _buildDetailRow(
            'Charging Session Timing',
            '${convertTo12HourFormat(provider.bookingDetailsModel.bookingDetails!.chargingSessionTiming.toString())}',
          ),
        ],
      ),
    );
  }

  Widget _buildAmountEstimation(StationProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.50),
          end: Alignment(1.00, 0.50),
          colors: [const Color(0x33182724), const Color(0x192ECC71)],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: driverPrimaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Amount Estimation',
            '\$ ${provider.bookingDetailsModel.pricing!.subtotal}',
          ),

          _buildDetailRow(
            'Platform Fee',
            '\$ ${provider.bookingDetailsModel.pricing!.platformFee!}',
          ),
          Divider(color: Color(0xFF9CA3AF)),

          _buildDetailRow(
            'Total Amount',
            '\$ ${provider.bookingDetailsModel.pricing!.totalAmount}',
          ),
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

  Widget _buildScanToChargeButton(
    BuildContext context,
    StationProvider provider,
  ) {
    return InkWell(
      onTap: () {
        if (provider.bookingDetailsModel.vehicle!.bookingStatus != "pending") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ScannerScreen()),
          );
        } else {
          CustomSnackbar.show(
            context,
            message:
                "Your booking isn’t confirmed yet. Please confirm your booking to proceed.",
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: ShapeDecoration(
          color: driverPrimaryColor,
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

  Widget _buildCloseButtom(BuildContext context) {
    return InkWell(
      onTap: () => context.go(RouterPath.home),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: ShapeDecoration(
          color: driverPrimaryColor,
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
            Icon(Icons.home, color: Colors.white),

            SizedBox(width: 8),
            Text(
              'Back to Home',
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
