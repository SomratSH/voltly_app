import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class BookingListScreen extends StatelessWidget {
  const BookingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>()..getUserBookingList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Bookings', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.bookingListModel.length,
        itemBuilder: (context, index) {
          final booking = provider.bookingListModel[index];
          return InkWell(
            onTap: () async {
              LoadingDialog.show(context);
              await provider.getBookingDetailsUser(booking.id!);
              LoadingDialog.hide(context);
              context.push(RouterPath.bookingDetailsUser);
            },
            child: Card(
              color: const Color(0xFF121C24),
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Booking #${booking.id}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          booking.status!.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: booking.status == 'pending'
                                ? Colors.orange
                                : booking.status == 'completed'
                                ? Colors.greenAccent
                                : Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "User ID: ${booking.user}, Vehicle ID: ${booking.vehicle}, Plug ID: ${booking.plug}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Booking Date: ${booking.bookingDate}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Payment Date: ${booking.paymentDate}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Total: \$${booking.totalAmount} | Paid: ${booking.isPaid! ? 'Yes' : 'No'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
