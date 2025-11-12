import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/application/host/booking_repo/model/booking_model.dart';
import 'package:voltly_app/common/commone_helper.dart';
import 'package:voltly_app/common/custom_html_text.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/station_owner/resevation/reservation_provider.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservationProvider>();
    return Scaffold(
      appBar: AppBar(
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
            _buildSearchBar(provider),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // ✅ enable horizontal scroll
              child: Row(
                children: [
                  const SizedBox(width: 8), // small padding left
                  _buildAllButton(
                    "All",
                    const Color(0x1901CC01),
                    primaryColor,
                    () async => await provider.getBooking("all"),
                  ),
                  const SizedBox(width: 8),
                  _buildAllButton(
                    "Completed",
                    const Color(0x1901CC01),
                    primaryColor,
                    () async => await provider.getBooking("Completed"),
                  ),
                  const SizedBox(width: 8),
                  _buildAllButton(
                    "Confirmed",
                    const Color(0x1901CC01),
                    Colors.green.shade300,
                    () async => await provider.getBooking("confirmed"),
                  ),
                  const SizedBox(width: 8),
                  _buildAllButton(
                    "Pending",
                    const Color(0x19CA8A04),
                    const Color(0xFFCA8A04),
                    () async => await provider.getBooking("pending"),
                  ),
                  const SizedBox(width: 8),
                  _buildAllButton(
                    "Cancelled",
                    const Color.fromARGB(255, 27, 10, 10),
                    const Color.fromARGB(255, 238, 70, 59),
                    () async => await provider.getBooking("cancelled"),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),

            const SizedBox(height: 16),
            provider.bookingList.isEmpty
                ? Center(
                    child: Text(
                      "No booking is not availble!",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await provider.getBooking("all");
                      },
                      child: ListView(
                        children: List.generate(
                          provider.filteredBookings.length,
                          (index) {
                            final booking = provider.filteredBookings[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: _buildReservationCard(
                                context,
                                booking: booking,
                                provider: provider,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(ReservationProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.70, color: const Color(0xFFD1D5DB)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Color(0xFF5A5A5A)),
          hintText: 'Search Driver or Charger name or Car Name',
          hintStyle: TextStyle(color: Color(0xFF5A5A5A)),
          border: InputBorder.none,
        ),
        onChanged: (v) {
          provider.searchBooking(v);
        },
      ),
    );
  }

  Widget _buildAllButton(
    String text,
    Color color,
    Color borderColor,
    Function() onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(18),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
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
    required BookingModel booking,
    required ReservationProvider provider,
  }) {
    Color statusColor;
    switch (booking.status) {
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
              CircleAvatar(
                backgroundImage: NetworkImage(
                  booking.userPicture != null
                      ? "${AppUrls.imageUrl}${booking.userPicture}"
                      : 'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
                ),
                radius: 25,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.userName!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    Text(
                      booking.vehicleName!,
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
                  booking.status!,
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
                '${booking.bookingDate} • ${convertTo12HourFormat(booking.startTime!)} - ${convertTo12HourFormat(booking.endTime!)}',
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
                  '${booking.chargerType} • ${booking.locationArea}',
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
          const SizedBox(height: 8),

          booking.reviews == null
              ? SizedBox()
              : Row(
                  children: [
                    const Icon(Icons.comment, size: 16, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        booking.reviews!.first.comment!,
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
          booking.reviews == null ? SizedBox() : const SizedBox(height: 8),
          booking.reviews == null
              ? SizedBox()
              : Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${booking.reviews!.first.rating}/5",
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

          if (booking.status == "pending") const SizedBox(height: 16),
          if (booking.status == "pending")
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: PrimaryButton(
                      text: "Accept",
                      onPressed: () async {
                        LoadingDialog.show(context);
                        final response = await provider.bookingAccept(
                          booking.id.toString(),
                          "accept",
                        );
                        if (response["success"] != null) {
                          CustomSnackbar.show(
                            context,
                            message: response["success"],
                          );
                          provider.updateStatus(booking.id!, "confirmed");
                        }
                        LoadingDialog.hide(context);
                      },
                    ),
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
