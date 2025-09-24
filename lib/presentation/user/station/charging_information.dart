import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/presentation/user/station/payment_success.dart';

class ChargingInformation extends StatelessWidget {
  const ChargingInformation({super.key});

  @override
  Widget build(BuildContext context) {
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
            Divider(color: Color(0xff00AB82)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'License Plate',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                Text(
                  'AB 1234',
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
            Divider(color: Color(0xff00AB82)),
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
                  'ABC charging station',
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
            Divider(color: Color(0xff00AB82)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start Charging',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                Text(
                  '15/09/25 11:30',
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
                  'Start Charging',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                Text(
                  '15/09/25 11:30',
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
                  'Usage (kWh)',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '50.25',
                      style: TextStyle(
                        color: const Color(0xFFFFF7F7),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.38,
                      ),
                    ),
                    hPad5,
                    Text(
                      'kWh',
                      style: TextStyle(
                        color: const Color(0xFF666666),
                        fontSize: 16,
                        fontFamily: 'Kanit',
                        fontWeight: FontWeight.w400,
                        height: 1.38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            hPad5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Usage (kWh)',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '510',
                      style: TextStyle(
                        color: const Color(0xFFFFF7F7),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.38,
                      ),
                    ),
                    hPad5,
                    Text(
                      'THB',
                      style: TextStyle(
                        color: const Color(0xFF666666),
                        fontSize: 16,
                        fontFamily: 'Kanit',
                        fontWeight: FontWeight.w400,
                        height: 1.38,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            vPad20,
            PrimaryButton(
              text: "Payment",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PaymentSuccess()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
