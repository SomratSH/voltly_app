import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/station_custom_card.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_provider.dart';
import 'package:voltly_app/presentation/user/add_car/car_add_provider.dart';
import 'package:voltly_app/presentation/user/ai_chat/ai_chat.dart';
import 'package:voltly_app/presentation/user/home_page/home_provider.dart';
import 'package:voltly_app/presentation/user/profile/profile_provider.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final stationProvider = context.watch<StationProvider>();
    final homeprovider = context.watch<HomeProvider>();
    // final carProvider = context.watch<CarAddProvider>();
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
            child: InkWell(
              onTap: () => const Color(0xFF182724),
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
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
                          image: DecorationImage(
                            image: NetworkImage(
                              profileProvider.profileModel.data == null ||
                                      profileProvider
                                              .profileModel
                                              .data!
                                              .picture ==
                                          null
                                  ? "https://marketplace.canva.com/EAFSZhFumYM/2/0/1600w/canva-dark-red-neon-futuristic-instagram-profile-picture-1u1wshkWxIM.jpg"
                                  : "${AppUrls.imageUrl}${profileProvider.profileModel.data!.picture}",
                            ),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(99)),
                          ),
                        ),
                      ),
                      hPad10,
                      Text(
                        profileProvider.profileModel.data == null ||
                                profileProvider.profileModel.data!.fullName ==
                                    null
                            ? 'N/A'
                            : profileProvider.profileModel.data!.fullName!,
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
                  homeprovider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              homeprovider.carList.isNotEmpty
                                  ? homeprovider
                                        .carList
                                        .first
                                        .vehicleDetails!
                                        .name!
                                  : 'My Car',
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
                              homeprovider.carList.isNotEmpty
                                  ? homeprovider
                                        .carList
                                        .first
                                        .registrationNumber!
                                  : 'Tesla CS23',
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
                              child: homeprovider.carList.isNotEmpty
                                  ? Image.network(
                                      "${AppUrls.imageUrl}${homeprovider.carList.first.vehicleDetails!.image}",
                                      width: 200,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
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
                        child: GoogleMap(
                          onMapCreated: homeprovider.onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: homeprovider.sourceLocation,
                            zoom: 16.0,
                          ),
                          markers: homeprovider.markers,
                          mapType: MapType.normal,
                          trafficEnabled: true,
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: false,
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
                  InkWell(
                    onTap: () => context.push(RouterPath.stationPage),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: driverPrimaryColor,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ),
                  ),
                ],
              ),

              vPad10,

              // stationProvider.stationList.isEmpty
              //     ? Center(child: Text("No station available", style: Te,))
              //     : Column(
              //         children: [
              //           EvStationCard(
              //             iconPath:
              //                 "${AppUrls.imageUrl}${stationProvider.stationList[0].details!.image}",
              //             title: "${stationProvider.stationList[0].name}",
              //             subtitle:
              //                 "${stationProvider.stationList[0].timeToReachMin}mins drive",
              //             rating: "4.5",
              //             onTap: () {
              //               stationProvider.selectedStationFunc(
              //                 stationProvider.stationList[0],
              //               );
              //               context.push(RouterPath.stationDetails);
              //             },
              //           ),
              //           EvStationCard(
              //             iconPath:
              //                 "${AppUrls.imageUrl}${stationProvider.stationList[1].details!.image}",
              //             title: "${stationProvider.stationList[1].name}",
              //             subtitle:
              //                 "${stationProvider.stationList[1].timeToReachMin}mins drive",
              //             rating: "4.5",
              //             onTap: () {
              //               stationProvider.selectedStationFunc(
              //                 stationProvider.stationList[1],
              //               );
              //               context.push(RouterPath.stationDetails);
              //             },
              //           ),
              //         ],
              //       ),
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
                      onTap: () => context.push(RouterPath.aiChat),
                      child: Container(
                        width: 60,
                        height: 46,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.50, 0.10),
                            end: Alignment(0.50, 0.50),
                            colors: [driverPrimaryColor, Color(0xFF121C24)],
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
                      color: driverPrimaryColor,
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
                                color: driverPrimaryColor,
                                "assets/icon/standard+charge.svg",
                              ),
                            ),
                          ),
                        ),
                        vPad10,
                        Text(
                          'Standard Charger',
                          style: TextStyle(
                            color: driverPrimaryColor,
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
                                color: driverPrimaryColor,
                                "assets/icon/first_charger.svg",
                              ),
                            ),
                          ),
                        ),
                        vPad10,
                        Text(
                          'Fast Charger',
                          style: TextStyle(
                            color: driverPrimaryColor,
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
                                color: driverPrimaryColor,
                                "assets/icon/rapid_charger.svg",
                              ),
                            ),
                          ),
                        ),
                        vPad10,
                        Text(
                          'Rapid Charger',
                          style: TextStyle(
                            color: driverPrimaryColor,
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
                                color: driverPrimaryColor,
                                "assets/icon/tesla_chargers.svg",
                              ),
                            ),
                          ),
                        ),
                        vPad10,
                        Text(
                          'Tesla chargers',
                          style: TextStyle(
                            color: driverPrimaryColor,
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
              SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}
