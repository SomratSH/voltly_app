import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:lottie/lottie.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/custom_timer.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/user/station/charging_information.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class ChargingPage extends StatelessWidget {
  const ChargingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),

        title: Text(
          'Charging Activity',
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
            vPad20,

            Align(
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 2,
                child: Container(
                  width: 247,
                  height: 139,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      // side: BorderSide(color: Colors.white),
                    ),
                  ),
                  child: Lottie.asset('assets/image/charging_animation.json'),
                ),
              ),
            ),
            vPad15,
            TimerScreen(),
            vPad20,
            // Row(
            //   children: [
            //     Expanded(
            //       child: DecoratedBox(
            //         decoration: ShapeDecoration(
            //           shape: RoundedRectangleBorder(
            //             side: BorderSide(width: 1, color: primaryColor),
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(12.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'Charging fee',
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   color: const Color(0xFFE6E6E6),
            //                   fontSize: 14,
            //                   fontFamily: 'Roboto',
            //                   fontWeight: FontWeight.w400,
            //                   height: 1.71,
            //                 ),
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     '500',
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: primaryColor,
            //                       fontSize: 24,
            //                       fontFamily: 'Roboto',
            //                       fontWeight: FontWeight.w400,
            //                       height: 1,
            //                     ),
            //                   ),
            //                   Text(
            //                     'THB',
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: const Color(0xFFE6E6E6),
            //                       fontSize: 16,
            //                       fontFamily: 'Roboto',
            //                       fontWeight: FontWeight.w400,
            //                       height: 1.50,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     hPad10,
            //     Expanded(
            //       child: DecoratedBox(
            //         decoration: ShapeDecoration(
            //           shape: RoundedRectangleBorder(
            //             side: BorderSide(
            //               width: 1,
            //               color: const Color(0xFF00AB82),
            //             ),
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(12.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'Charging fee',
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   color: const Color(0xFFE6E6E6),
            //                   fontSize: 14,
            //                   fontFamily: 'Roboto',
            //                   fontWeight: FontWeight.w400,
            //                   height: 1.71,
            //                 ),
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     '500',
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: primaryColor,
            //                       fontSize: 24,
            //                       fontFamily: 'Roboto',
            //                       fontWeight: FontWeight.w400,
            //                       height: 1,
            //                     ),
            //                   ),
            //                   hPad10,
            //                   Text(
            //                     'THB',
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: const Color(0xFFE6E6E6),
            //                       fontSize: 16,
            //                       fontFamily: 'Roboto',
            //                       fontWeight: FontWeight.w400,
            //                       height: 1.50,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // vPad20,
            // Row(
            //   children: [
            //     Expanded(
            //       child: DecoratedBox(
            //         decoration: ShapeDecoration(
            //           shape: RoundedRectangleBorder(
            //             side: BorderSide(width: 1, color: primaryColor),
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(12.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'Charging fee',
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   color: const Color(0xFFE6E6E6),
            //                   fontSize: 14,
            //                   fontFamily: 'Roboto',
            //                   fontWeight: FontWeight.w400,
            //                   height: 1.71,
            //                 ),
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     '500',
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: primaryColor,
            //                       fontSize: 24,
            //                       fontFamily: 'Roboto',
            //                       fontWeight: FontWeight.w400,
            //                       height: 1,
            //                     ),
            //                   ),
            //                   Text(
            //                     'THB',
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: const Color(0xFFE6E6E6),
            //                       fontSize: 16,
            //                       fontFamily: 'Roboto',
            //                       fontWeight: FontWeight.w400,
            //                       height: 1.50,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     hPad10,
            //     Expanded(
            //       child: DecoratedBox(
            //         decoration: ShapeDecoration(
            //           shape: RoundedRectangleBorder(
            //             side: BorderSide(
            //               width: 1,
            //               color: const Color(0xFF00AB82),
            //             ),
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(12.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'Charging fee',
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   color: const Color(0xFFE6E6E6),
            //                   fontSize: 14,
            //                   fontFamily: 'Roboto',
            //                   fontWeight: FontWeight.w400,
            //                   height: 1.71,
            //                 ),
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     '500',
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: primaryColor,
            //                       fontSize: 24,
            //                       fontFamily: 'Roboto',
            //                       fontWeight: FontWeight.w400,
            //                       height: 1,
            //                     ),
            //                   ),
            //                   hPad10,
            //                   Text(
            //                     'THB',
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: const Color(0xFFE6E6E6),
            //                       fontSize: 16,
            //                       fontFamily: 'Roboto',
            //                       fontWeight: FontWeight.w400,
            //                       height: 1.50,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // vPad20,
            PrimaryButton(
              text: "Finish Charging",
              onPressed: () async {
                LoadingDialog.show(context);
                final data = await provider.endChargingUser(
                  provider.bookingDetailsModel.bookingDetails!.id!,
                );
                if (data["message"] == "Charging completed") {
                  LoadingDialog.hide(context);
                  CustomSnackbar.show(context, message: data["message"]);
                  context.go(RouterPath.chargingInformation);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChargingInformation()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
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
              Row(
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
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.battery_charging_full, color: Colors.white, size: 16),
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
