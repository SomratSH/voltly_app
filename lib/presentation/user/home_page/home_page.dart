import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/presentation/user/ai_chat/ai_chat.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121C24),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121C24),
        elevation: 0,
        leading: SvgPicture.asset(
          "assets/icon/logo.svg",
          width: 20,
          height: 20,
          fit: BoxFit.scaleDown,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: ShapeDecoration(
                color: const Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/icon/ph_bell.svg"),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile + Name
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://marketplace.canva.com/EAFSZhFumYM/2/0/1600w/canva-dark-red-neon-futuristic-instagram-profile-picture-1u1wshkWxIM.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(99)),
                          ),
                        ),
                      ),
                      hPad10,
                      const Text(
                        'Rafsan\nMahmud',
                        style: TextStyle(
                          color: Color(0xFFC7BEBE),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                  hPad20,
                  // const Spacer(), // pushes search field to right
                  // ✅ Search field that expands properly
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.70,
                            color: const Color(0xFFD1D5DB),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search station',
                          hintStyle: TextStyle(
                            color: const Color(0xFF787878),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xff787878),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              vPad20,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Car',
                        style: TextStyle(
                          color: const Color(0xFFD1D5DB),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 1.50,
                        ),
                      ),
                      vPad5,
                      Text(
                        'Tesla CS23',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      vPad10,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/image/home_car.png",
                          width: 200,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  hPad10,
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/image/map_image.png",
                          width: 200,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              vPad10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nearby Stations',
                    style: TextStyle(
                      color: const Color(0xFFD1D5DB),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: const Color(0xFF01CC01),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 1.50,
                    ),
                  ),
                ],
              ),

              vPad10,
             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SvgPicture.asset(
                            "assets/icon/bi_ev-station.svg",
                          ),
                        ),
                      ),
                      hPad20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Midtown expressway',
                            style: TextStyle(
                              color: const Color(0xFFD1D5DB),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 1.50,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule_rounded,
                                color: const Color(0xFFD1D5DB),
                                size: 12,
                              ),
                              Text(
                                '10mins drive',
                                style: TextStyle(
                                  color: const Color(0xFFD1D5DB),
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                              hPad10,
                              Icon(Icons.star, color: Colors.amber, size: 12),
                              Text(
                                '4.5',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: const Color(0xFFD1D5DB),
                    size: 12,
                  ),
                ],
              ),
              
              
              vPad10,
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Background Car Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/image/charge_car_image.png",
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Positioned Floating Icon Button
                  Positioned(
                    bottom: -15,
                    right: 0,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AiChat()),
                      ),
                      child: Container(
                        width: 60,
                        height: 46,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(0.50, 0.10),
                            end: Alignment(0.50, 0.50),
                            colors: [Color(0xFF1F8D3C), Color(0xFF121C24)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(44)),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F01E601),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Center(
                          // ✅ makes ai_car.png centered
                          child: Image.asset(
                            "assets/image/ai_car.png",

                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ev Charger Types',
                    style: TextStyle(
                      color: const Color(0xFFD1D5DB),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: const Color(0xFF01CC01),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                ],
              ),

              vPad20,

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        DecoratedBox(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.70,
                                color: const Color(0xFFD1D5DB),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                "assets/icon/standard+charge.svg",
                              ),
                            ),
                          ),
                        ),
                        vPad10,
                        Text(
                          'Standard Charger',
                          style: TextStyle(
                            color: const Color(0xFF01CC01),
                            fontSize: 10,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hPad10,
                  Expanded(
                    child: Column(
                      children: [
                        DecoratedBox(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.70,
                                color: const Color(0xFFD1D5DB),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                "assets/icon/first_charger.svg",
                              ),
                            ),
                          ),
                        ),
                        vPad10,
                        Text(
                          'Fast Charger',
                          style: TextStyle(
                            color: const Color(0xFF01CC01),
                            fontSize: 10,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hPad10,
                  Expanded(
                    child: Column(
                      children: [
                        DecoratedBox(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.70,
                                color: const Color(0xFFD1D5DB),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                "assets/icon/rapid_charger.svg",
                              ),
                            ),
                          ),
                        ),
                        vPad10,
                        Text(
                          'Rapid Charger',
                          style: TextStyle(
                            color: const Color(0xFF01CC01),
                            fontSize: 10,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hPad10,
                  Expanded(
                    child: Column(
                      children: [
                        DecoratedBox(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.70,
                                color: const Color(0xFFD1D5DB),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                "assets/icon/tesla_chargers.svg",
                              ),
                            ),
                          ),
                        ),
                        vPad10,
                        Text(
                          'Tesla chargers',
                          style: TextStyle(
                            color: const Color(0xFF01CC01),
                            fontSize: 10,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              vPad70,
            ],
          ),
        ),
      ),
    );
  }
}
