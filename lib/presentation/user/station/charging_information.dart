import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/user/payment/payment_charging.dart';
import 'package:voltly_app/presentation/user/station/payment_success.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class ChargingInformation extends StatelessWidget {
  const ChargingInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),
        centerTitle: true,
        leading: SvgPicture.asset(
          "assets/icon/logo.svg",
          width: 20,
          height: 20,
          fit: BoxFit.scaleDown,
        ),
        title: Text(
          'Charging Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vehicle Information',
              style: TextStyle(
                color: const Color(0xFFFFF7F7),
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(color: primaryColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Car Model',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                Text(
                  provider.bookingDetailsModel.vehicle!.model!,
                  style: TextStyle(
                    color: const Color(0xFFFFF7F7),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
              ],
            ),
            vPad20,
            Text(
              'Station Information',
              style: TextStyle(
                color: const Color(0xFFFFF7F7),
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(color: primaryColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Operator',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                Text(
                  'Md. Rafi',
                  style: TextStyle(
                    color: const Color(0xFFFFF7F7),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Station name',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                hPad5,
                Text(
                  provider.bookingDetailsModel.chargingStation!.stationName!,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            vPad20,
            Text(
              'Charging Information',
              style: TextStyle(
                color: const Color(0xFFFFF7F7),
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(color: primaryColor),

            hPad5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Charging Time',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                Text(
                  "${provider.charingCompleteResponseModel.durationHours}HH-${provider.charingCompleteResponseModel.durationMinutes}MIN-${provider.charingCompleteResponseModel.durationSeconds}",
                  style: TextStyle(
                    color: const Color(0xFFFFF7F7),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
              ],
            ),
            hPad5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                Text(
                  provider.charingCompleteResponseModel.subtotal!,
                  style: TextStyle(
                    color: const Color(0xFFFFF7F7),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
              ],
            ),
            hPad5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Platform Charge/Fee",
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                Text(
                  provider.charingCompleteResponseModel.platformFee!,
                  style: TextStyle(
                    color: const Color(0xFFFFF7F7),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
              ],
            ),
            hPad5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                Text(
                  provider.charingCompleteResponseModel.totalAmount!,
                  style: TextStyle(
                    color: const Color(0xFFFFF7F7),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
              ],
            ),

            vPad20,
            PrimaryButton(
              text: "Payment",
              onPressed: () async {
                LoadingDialog.show(context);
                final data = await provider.paymentForCharging(
                  provider.bookingDetailsModel.bookingDetails!.bookingId!,
                );
                if (data["checkout_url"] != null) {
                  LoadingDialog.hide(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PaymentCharging(url: data["checkout_url"]),
                    ),
                  );
                } else {
                  LoadingDialog.hide(context);
                  CustomSnackbar.show(
                    context,
                    message: "Please, try again later",
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
