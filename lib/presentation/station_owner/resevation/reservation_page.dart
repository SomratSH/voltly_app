import 'package:flutter/material.dart';
import 'package:voltly_app/common/primary_button.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),
        title: const Text(
          'Reservations',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildAllButton(
                    "All",
                    const Color(0x1901CC01),
                    const Color(0xFF01CC01),
                  ),
                ),
                Expanded(
                  child: _buildAllButton(
                    "Confirmed",
                    const Color(0x1901CC01),
                    const Color(0xFF01CC01),
                  ),
                ),
                Expanded(
                  child: _buildAllButton(
                    "Pending",
                    const Color(0x19CA8A04),
                    const Color(0xFFCA8A04),
                  ),
                ),
                Expanded(
                  child: _buildAllButton(
                    "Cancelled",
                    Colors.transparent,
                    Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildReservationCard(
                    context,
                    name: 'Sarah Johnson',
                    carModel: 'Tesla Model 3',
                    status: 'Pending',
                    date: 'Sep 15, 2025',
                    time: '2:30 PM',
                    chargerType: 'Type 1 (AC) charging',
                    location: 'Midtown expressway',
                    showButtons: true,
                  ),
                  const SizedBox(height: 16),
                  _buildReservationCard(
                    context,
                    name: 'Saima Akther',
                    carModel: 'BMW i4',
                    status: 'Confirmed',
                    date: 'Sep 15, 2025',
                    time: '2:30 PM',
                    chargerType: 'Type 1 (AC) charging',
                    location: 'Midtown',
                    showButtons: false,
                  ),
                  const SizedBox(height: 16),
                  _buildReservationCard(
                    context,
                    name: 'Emma Davis',
                    carModel: 'Nissan Leaf',
                    status: 'Completed',
                    date: 'Sep 15, 2025',
                    time: '12:30 AM',
                    chargerType: 'Type 1 (AC) charging',
                    location: 'Midtown expressway',
                    showButtons: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.70, color: const Color(0xFFD1D5DB)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Color(0xFF5A5A5A)),
          hintText: 'Search Driver or Charger name',
          hintStyle: TextStyle(color: Color(0xFF5A5A5A)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildAllButton(String text, Color color, Color borderColor) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 4,
      ), // spacing between buttons
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(18),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x33000000), // lighter shadow
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: borderColor, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildReservationCard(
    BuildContext context, {
    required String name,
    required String carModel,
    required String status,
    required String date,
    required String time,
    required String chargerType,
    required String location,
    required bool showButtons,
  }) {
    Color statusColor;
    switch (status) {
      case 'Pending':
        statusColor = const Color(0xFFFFC107);
        break;
      case 'Confirmed':
        statusColor = const Color(0xFF6AB04A);
        break;
      case 'Completed':
        statusColor = const Color(0xFF888888);
        break;
      default:
        statusColor = Colors.white;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFF182724),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 15,
            offset: Offset(0, 10),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
                ),
                radius: 25,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    Text(
                      carModel,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
                color: Color(0xFF888888),
              ),
              const SizedBox(width: 8),
              Text(
                '$date • $time',
                style: TextStyle(
                  color: const Color(0xFFD1D5DB),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.flash_on, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$chargerType • $location',
                  style: TextStyle(
                    color: const Color(0xFFD1D5DB),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (showButtons) const SizedBox(height: 16),
          if (showButtons)
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: PrimaryButton(text: "Accept", onPressed: () {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
