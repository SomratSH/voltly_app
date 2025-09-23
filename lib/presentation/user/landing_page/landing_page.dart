import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voltly_app/presentation/user/add_car/add_car.dart';
import 'package:voltly_app/presentation/user/find_station/find_station.dart';
import 'package:voltly_app/presentation/user/home_page/home_page.dart';
import 'package:voltly_app/presentation/user/profile/profile_page.dart';
import 'package:voltly_app/presentation/user/station/station_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;

  // Define your icons and colors
  final List<Widget> _pages = [
    const HomePage(), // First page
    const AddCar(),
    StationPage(), // Second page
    const ProfilePage(), // Third page
  ];

  final List<CustomNavBarItem> navItem = [
    CustomNavBarItem("assets/icon/home.svg", ""),
    CustomNavBarItem("assets/icon/car.svg", ""),
    CustomNavBarItem("assets/icon/station.svg", ""),
    CustomNavBarItem("assets/icon/user_square.svg", ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _pages[_currentIndex],
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
                              },
                              child: SvgPicture.asset(
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 30, right: 30),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FindStation()),
          ),
          child: Container(
            height: 60,
            width: 60,
            decoration: ShapeDecoration(
              color: const Color(0xFF01CC01),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F0091D8),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset("assets/icon/thunder.svg"),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CustomNavBarItem {
  String? icon;
  String? title;
  CustomNavBarItem(this.icon, this.title);
}
