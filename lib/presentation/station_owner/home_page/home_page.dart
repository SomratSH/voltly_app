import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voltly_app/common/custom_appbar.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/presentation/common_page/notification.dart';
import 'package:voltly_app/presentation/station_owner/charging/add_charger_owner.dart';
import 'package:voltly_app/presentation/station_owner/home_page/station_map.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_owner.dart';
import 'package:voltly_app/presentation/user/profile/profile_page.dart';

class HomePageOwner extends StatelessWidget {
  const HomePageOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileOwner()),
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNV2dimRVLDjbd9FtA7z4Qz8wJIVQ_UljnUiB6Zd-5TCWz8-5TFzTZf90&s",
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
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildEarningsOverview(),
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
              _buildReservationCard(
                name: 'Rafsan Mahmud',
                carModel: 'Tesla Model 3',
                status: 'Confirmed',
                statusColor: Colors.green,
                time: 'Today, 2:00 PM - 4:00 PM',
              ),
              const SizedBox(height: 16),
              _buildReservationCard(
                name: 'Salma Akther',
                carModel: 'BMW i3',
                status: 'Pending',
                statusColor: Colors.orange,
                time: 'Tomorrow, 9:00 AM - 11:00 AM',
              ),
              const SizedBox(height: 24),
              _buildChargerStatus(),
              const SizedBox(height: 24),
              _buildQuickActions(context),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNV2dimRVLDjbd9FtA7z4Qz8wJIVQ_UljnUiB6Zd-5TCWz8-5TFzTZf90&s",
                    ),
                  ),
                  hPad5,
                  Text(
                    'Welcome back,\nMd. Julian!!',
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
                '123 St ,ABC, Midtown expressway',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),

              SizedBox(height: 8),
              Text(
                'Change your Location?\n',
                style: TextStyle(
                  color: const Color(0xFFD1D5DB),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.50,
                ),
              ),

              Text(
                'Go Now',
                style: TextStyle(
                  color: const Color(0xFF01CC01),
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
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MapScreen()),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                height: 150,
                width: 200,
                image: AssetImage('assets/image/map_image.png'), // Placeholder
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEarningsOverview() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildEarningColumn('Today', '\$45'),
              _buildEarningColumn('This Week', '\$210'),
              _buildEarningColumn('This Month', '\$980'),
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
            color: const Color(0xFF01CC01),
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
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFF01CC01)),
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNV2dimRVLDjbd9FtA7z4Qz8wJIVQ_UljnUiB6Zd-5TCWz8-5TFzTZf90&s',
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

  Widget _buildChargerStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Charger Status',
              style: TextStyle(
                color: const Color(0xFFEAEAEA),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
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
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: const Color(0xFF01CC01)),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tesla Wall Connector (Type 1 (AC))',
                      style: TextStyle(
                        color: const Color(0xFFF2F2F2),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '123 Main St, Midtown expressway',
                      style: TextStyle(
                        color: const Color(0xFF7C818B),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF33D933),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Active',
                          style: TextStyle(
                            color: Color(0xFF33D933),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Switch(
                value: true,
                onChanged: (bool value) {},
                activeColor: const Color(0xFF33D933),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.white10,
              ),
            ],
          ),
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
