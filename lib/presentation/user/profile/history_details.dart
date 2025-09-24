import 'package:flutter/material.dart';
import 'package:voltly_app/common/custom_padding.dart';

class HistoryDetails extends StatelessWidget {
  const HistoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: Text("History Details", style: TextStyle(color: Colors.white)),
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
            vPad10,
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
            vPad10,
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
            vPad10,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Station Image
                Container(
                  width: 60,
                  height: 60,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image/station_details.png"),
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
                        'ABC charging station',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Row(
                        children: const [
                          Icon(Icons.star, color: Color(0xFF33D933), size: 16),
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
                        children: const [
                          Text(
                            'Open',
                            style: TextStyle(
                              color: const Color(0xFF01CC01),
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
                          Icon(Icons.keyboard_arrow_down, color: Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            vPad10,
            Text(
              'Charge Detail',
              style: TextStyle(
                color: const Color(0xFFA0A0A0),
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(color: Color(0xff00AB82)),
            vPad15,
            Row(
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF00AB82),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Charging fee',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFE6E6E6),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.71,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '500',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF01CC01),
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              ),
                              hPad10,
                              Text(
                                'THB',
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
                ),
                hPad15,
                Expanded(
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF00AB82),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Charging',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFE6E6E6),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.71,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '30',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF01CC01),
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              ),
                              hPad10,
                              Text(
                                'Kw/h',
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
                ),
              ],
            ),
            vPad20,
            Row(
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF00AB82),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Service Fee',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFE6E6E6),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.71,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '10',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF01CC01),
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              ),
                              hPad10,
                              Text(
                                'THB',
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
                ),
                hPad15,
                Expanded(
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF00AB82),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Extra Parking time',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFE6E6E6),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.71,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF01CC01),
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              ),
                              hPad10,
                              Text(
                                'MINS',
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
                ),
              ],
            ),
            vPad15,
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
                Row(
                  children: [
                    Text(
                      '15/09/25',
                      style: TextStyle(
                        color: const Color(0xFFFFF7F7),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.38,
                      ),
                    ),
                    hPad10,
                    Text(
                      '11:30',
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
              ],
            ),
            vPad20,
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
                Row(
                  children: [
                    Text(
                      '15/09/25',
                      style: TextStyle(
                        color: const Color(0xFFFFF7F7),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.38,
                      ),
                    ),
                    hPad10,
                    Text(
                      '11:30',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
