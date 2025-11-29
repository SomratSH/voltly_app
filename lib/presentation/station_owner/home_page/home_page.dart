import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_appbar.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/common_page/notification.dart';
import 'package:voltly_app/presentation/station_owner/charging/add_charger_owner.dart';
import 'package:voltly_app/presentation/station_owner/charging/charging_provider.dart';
import 'package:voltly_app/presentation/station_owner/home_page/host_home_provider.dart';
import 'package:voltly_app/presentation/station_owner/home_page/station_map.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_owner.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_provider.dart';
import 'package:voltly_app/presentation/user/profile/profile_page.dart';

class HomePageOwner extends StatelessWidget {
  const HomePageOwner({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<HostProfileProvider>();
    final homeProvider = context.watch<HostHomeProvider>();
    final chagingProvider = context.watch<ChargingProvider>();
    return Scaffold(
      appBar: AppBar(
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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NotificationScreen()),
                );
              },
              child: Container(
                decoration: ShapeDecoration(
                  color: const Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/icon/ph_bell.svg"),
              ),
            ),
          ),
          hPad10,
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                context.push(RouterPath.profileHost);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  profileProvider.hostProfileModel.data == null ||
                          profileProvider.hostProfileModel.data!.picture == null
                      ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNV2dimRVLDjbd9FtA7z4Qz8wJIVQ_UljnUiB6Zd-5TCWz8-5TFzTZf90&s"
                      : "${AppUrls.imageUrl}${profileProvider.hostProfileModel.data!.picture}",
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, profileProvider, homeProvider),
              const SizedBox(height: 24),
              _buildEarningsOverview(profileProvider),
              const SizedBox(height: 24),
              Text(
                'Upcoming Reservations',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  height: 1.56,
                ),
              ),
              const SizedBox(height: 16),

              profileProvider.upcomingReservationModel.upcomingReservations ==
                      null
                  ? Center(
                      child: Text(
                        "No reservation avaiable",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Column(
                      children: List.generate(
                        profileProvider
                            .upcomingReservationModel
                            .upcomingReservations!
                            .length,
                        (index) {
                          final reservation = profileProvider
                              .upcomingReservationModel
                              .upcomingReservations![index];

                          // Map API status to display text
                          String statusText;
                          switch (reservation.status?.toLowerCase()) {
                            case 'pending':
                              statusText = "Pending";
                              break;
                            case 'confirmed':
                              statusText = "Confirmed";
                              break;
                            case 'completed':
                              statusText = "Completed";
                              break;
                            default:
                              statusText = "n/A";
                          }

                          return _buildReservationCard(
                            image: "",
                            name: reservation.userName!,
                            carModel: reservation.vehicleName!,
                            status: statusText,
                            statusColor: getStatusColor(
                              reservation.status ?? "",
                            ),
                            time:
                                '${reservation.bookingDate}\n${reservation.startTime} - ${reservation.endTime}', // replace with dynamic if needed
                          );
                        },
                      ),
                    ),
              const SizedBox(height: 24),
              _buildChargerStatus(chagingProvider, context),
              const SizedBox(height: 24),
              _buildQuickActions(context),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    HostProfileProvider profileProvider,
    HostHomeProvider homeProvider,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      profileProvider.hostProfileModel.data == null ||
                              profileProvider.hostProfileModel.data!.picture ==
                                  null
                          ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNV2dimRVLDjbd9FtA7z4Qz8wJIVQ_UljnUiB6Zd-5TCWz8-5TFzTZf90&s"
                          : "${AppUrls.imageUrl}${profileProvider.hostProfileModel.data!.picture}",
                    ),
                  ),
                  hPad5,
                  Text(
                    profileProvider.hostProfileModel.data == null ||
                            profileProvider.hostProfileModel.data!.fullName ==
                                null
                        ? 'Welcome back,\nN/A!!'
                        : 'Welcome back,\n${profileProvider.hostProfileModel.data!.fullName}!!',
                    style: TextStyle(
                      color: const Color(0xFFD1D5DB),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                homeProvider.address ?? "N/A",
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),

              SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  LoadingDialog.show(context);
                  await homeProvider.getCurrentLocation();
                  LoadingDialog.hide(context);
                },
                child: Text(
                  'Change your Location?\n',
                  style: TextStyle(
                    color: const Color(0xFFD1D5DB),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),

              Text(
                'Go Now',
                style: TextStyle(
                  color: hostprimaryColor,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,

                  height: 1.50,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 120,
              child: homeProvider.sourceLocation == null
                  ? Container(
                      color: Colors.grey[300],
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : GoogleMap(
                      onMapCreated: homeProvider.onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: homeProvider.sourceLocation!,
                        zoom: 15,
                      ),
                      markers: homeProvider.markers,
                      style: homeProvider.mapTheme,
                      zoomControlsEnabled: false,
                      trafficEnabled: true,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEarningsOverview(HostProfileProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFF182724),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadows: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Earnings Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          provider.earningPayoutModel.earningsOverview == null
              ? SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildEarningColumn(
                      'Today',
                      '${provider.earningPayoutModel.earningsOverview!.today ?? "\$ 0.0"}',
                    ),
                    _buildEarningColumn(
                      'This Week',
                      '${provider.earningPayoutModel.earningsOverview!.thisWeek ?? "\$ 0.0"}',
                    ),
                    _buildEarningColumn(
                      'This Month',
                      '${provider.earningPayoutModel.earningsOverview!.thisMonth ?? "\$ 0.0"}',
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  static Widget _buildEarningColumn(String title, String amount) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFFD1D5DB),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 1.43,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: hostprimaryColor,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 1.40,
          ),
        ),
      ],
    );
  }

  Widget _buildReservationCard({
    required String name,
    required String carModel,
    required String status,
    required Color statusColor,
    required String time,
    required String image,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: hostprimaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  image.isNotEmpty
                      ? "${AppUrls.imageUrl}${image}"
                      : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNV2dimRVLDjbd9FtA7z4Qz8wJIVQ_UljnUiB6Zd-5TCWz8-5TFzTZf90&s',
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
                  name,
                  style: TextStyle(
                    color: const Color(0xFFD7D7D7),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),
                ),
                Text(
                  carModel,
                  style: TextStyle(
                    color: const Color(0xFF7C818B),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: const Color(0xFFD9D9D9),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChargerStatus(ChargingProvider provider, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Charger Status',
              style: TextStyle(
                color: Color(0xFFEAEAEA),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                height: 1.50,
              ),
            ),
            InkWell(
              onTap: () => context.go(RouterPath.chargingHost),
              child: Text(
                'See all',
                style: TextStyle(
                  color: hostprimaryColor,
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Loop through chargers that are default
        provider.chargerList.isEmpty
            ? Center(
                child: Text(
                  "No charger available",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Column(
                children: provider.chargerList
                    .where(
                      (charger) => charger.isActive == true,
                    ) // ✅ filter default chargers
                    .map((charger) {
                      final isActive =
                          (charger.isActive ?? false); // active status

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: isActive ? hostprimaryColor : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x0C000000),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    charger.name ?? "Charger Name",
                                    style: const TextStyle(
                                      color: Color(0xFFF2F2F2),
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: isActive
                                              ? hostprimaryColor
                                              : Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        isActive ? 'Active' : 'Inactive',
                                        style: TextStyle(
                                          color: isActive
                                              ? hostprimaryColor
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: isActive,
                              onChanged: (bool value) {
                                // Call provider method to toggle charger status
                                // provider.toggleCharger(charger.id, value);
                              },
                              activeColor: hostprimaryColor,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.white10,
                            ),
                          ],
                        ),
                      );
                    })
                    .toList(),
              ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            height: 1.75,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddChargerOwner()),
              ),
              child: _buildQuickActionButton(
                color: Color(0xff01CC01),
                icon: Icons.add,
                label: 'Add New\nCharger',
              ),
            ),
            _buildQuickActionButton(
              color: Color(0xff2563EB),
              icon: Icons.calendar_month,
              label: 'Manage\nAvailability',
            ),
            _buildQuickActionButton(
              color: Color(0xffCA8A04),
              icon: Icons.attach_money,
              label: 'View\nPayouts',
            ),
          ],
        ),
      ],
    );
  }

  static Widget _buildQuickActionButton({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF243026),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return Colors.orange;
    case 'confirmed':
      return Colors.blue;
    case 'completed':
      return Colors.green;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
