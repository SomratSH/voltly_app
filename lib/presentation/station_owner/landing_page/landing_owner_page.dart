import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/station_owner/charging/charging_page.dart';
import 'package:voltly_app/presentation/station_owner/earning/earning_page.dart';
import 'package:voltly_app/presentation/station_owner/home_page/home_page.dart';
import 'package:voltly_app/presentation/station_owner/resevation/reservation_page.dart';
import 'package:voltly_app/presentation/user/find_station/find_station.dart';

class LandingOwnerPage extends StatefulWidget {
  final Widget? child;
  const LandingOwnerPage({super.key, this.child});

  @override
  _LandingOwnerPageState createState() => _LandingOwnerPageState();
}

class _LandingOwnerPageState extends State<LandingOwnerPage> {
  int _currentIndex = 0;

  // Define your icons and colors
  final List<String> _pages = [
    RouterPath.homeOwner, // First page
    RouterPath.reservationHost,
    RouterPath.chargingHost, // Second page
    RouterPath.earningHost, // Third page
  ];

  final List<CustomNavBarItem> navItem = [
    CustomNavBarItem("assets/icon/home.svg", ""),
    CustomNavBarItem("assets/icon/reseve.svg", ""),
    CustomNavBarItem("assets/icon/owner_charging.svg", ""),
    CustomNavBarItem("assets/icon/earning.svg", ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            widget.child ?? const SizedBox.shrink(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0xFF262626),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: List.generate(navItem.length, (index) {
                    return Expanded(
                      child: _currentIndex == index
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      navItem[index].icon.toString(),
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 15),
                                  ],
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                _currentIndex = index;
                                setState(() {});
                                context.push(_pages[index]);
                              },
                              child: SvgPicture.asset(
                                color: hostprimaryColor,
                                navItem[index].icon.toString(),
                              ),
                            ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 40, left: 30, right: 30),
      //   child: InkWell(
      //     onTap: () => Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => FindStation()),
      //     ),
      //     child: Container(
      //       height: 60,
      //       width: 60,
      //       decoration: ShapeDecoration(
      //         color: bottomNavBarIconColor,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(12),
      //         ),
      //         shadows: [
      //           BoxShadow(
      //             color: Color(0x3F0091D8),
      //             blurRadius: 4,
      //             offset: Offset(0, 4),
      //             spreadRadius: 0,
      //           ),
      //         ],
      //       ),
      //       child: Padding(
      //         padding: const EdgeInsets.all(12.0),
      //         child: SvgPicture.asset("assets/icon/thunder.svg"),
      //       ),
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CustomNavBarItem {
  String? icon;
  String? title;
  CustomNavBarItem(this.icon, this.title);
}
