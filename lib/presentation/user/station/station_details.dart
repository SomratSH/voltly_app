import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/common_map_chat_button.dart';
import 'package:voltly_app/common/commone_helper.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/helpers.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/common_page/messaging_provider.dart';
import 'package:voltly_app/presentation/user/profile/converstation_screen.dart';
import 'package:voltly_app/presentation/user/station/booking_page.dart';
import 'package:voltly_app/presentation/user/station/scanner_screen.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';
import 'package:voltly_app/presentation/user/station/widget/car_selector.dart';
import 'package:voltly_app/presentation/user/station/widget/choose_time.dart';
import 'package:voltly_app/presentation/user/station/widget/connector_type.dart';

class StationDetails extends StatelessWidget {
  const StationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();
    final providerMessage = context.watch<MessagingProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, provider),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Station Image
                      Container(
                        width: 60,
                        height: 60,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              provider.stationDetailsModel.image == null
                                  ? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"
                                  : "${AppUrls.imageUrl}${provider.stationDetailsModel.image}",
                            ),
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
                              provider.stationDetailsModel.stationName!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Row(
                              children: [
                                Icon(Icons.star, color: driverPrimaryColor, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'High score ${provider.stationDetailsModel.averageRating}/5',
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
                              children: [
                                Text(
                                  'Open',
                                  style: TextStyle(
                                    color: driverPrimaryColor,
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '${convertTo12HourFormat(provider.stationDetailsModel.openingTime!)} - ${convertTo12HourFormat(provider.stationDetailsModel.closingTime!)}',
                                  style: TextStyle(
                                    color: const Color(0xFFB5B5B5),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Divider(),
                  vPad10,
                  Row(
                    children: [
                      Icon(Icons.location_on, color: driverPrimaryColor, size: 16),
                      SizedBox(width: 8),
                      Text(
                        '${provider.stationDetailsModel.distanceKm} Km.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          provider.stationDetailsModel.address ?? "N/A",
                          style: TextStyle(
                            color: const Color(0xFFF2F2F2),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  vPad10,
                  MapChatButtons(
                    onTapMap: () async {
                      LoadingDialog.show(context);
                      await openMapToAddress(
                        destinationLang: provider.stationDetailsModel.longitude
                            .toString(),
                        destinationLat: provider.stationDetailsModel.latitude
                            .toString(),
                      );
                      LoadingDialog.hide(context);
                    },
                    onTapMessage: () async {
                      final data = await providerMessage.createChat(
                        provider.stationDetailsModel.host!.id!,
                      );
                      print(data);
                      if (data == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatPage(
                              chatId: providerMessage.createChatModel.id!,
                              name: providerMessage
                                  .createChatModel
                                  .host!
                                  .fullName!,
                              picture: providerMessage
                                  .createChatModel
                                  .host!
                                  .picture!,
                            ),
                          ),
                        );
                      } else {
                        CustomSnackbar.show(context, message: "Not connected");
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _ScanToChargeButton(),
            vPad15,

            _buildSectionTitle('Connector Type'),
            Divider(color: driverPrimaryColor),

            Column(
              children: List.generate(
                provider.stationDetailsModel.chargers!.length,
                (index) {
                  final charger = provider.stationDetailsModel.chargers![index];
                  print(charger.plugTypes!.length);
                  return ConnectorTypeCard(
                    mode: charger.mode!,
                    price: charger.price.toString(),
                    iconPath: "assets/icon/first_charger.svg",
                    plugTypes: charger.plugTypes!,
                    chargerId: charger.id!,
                    power: "50 kW",

                    isAvailable: charger.available!,
                    chargersName: charger.name!,
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return RescheduleSessionDialog();
                  },
                );
              },
              child: _buildServiceFeeItem('Choose Date & Time'),
            ),
            vPad10,
            InkWell(
              onTap: () {
                CarSelectorBottomSheet.show(context);
              },
              child: _buildServiceFeeItem('Choose Car'),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Reviews'),
            _buildReviews(),
            const SizedBox(height: 24),
            _buildReviewInput(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _BookNowButton(),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, StationProvider provider) {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Image.network(
            provider.stationDetailsModel.image == null
                ? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"
                : "${AppUrls.imageUrl}${provider.stationDetailsModel.image!}", // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 8.0),
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: Container(
              //       decoration: ShapeDecoration(
              //         color: const Color(0xFFF5F5F5),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //       ),
              //       padding: const EdgeInsets.all(8.0),
              //       child: SvgPicture.asset("assets/icon/ph_bell.svg"),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFFFCEFEF),
          fontSize: 18,
          fontFamily: 'Kanit',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildServiceFeeItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w400,
            ),
          ),
          SvgPicture.asset("assets/icon/arrow.svg", color: driverPrimaryColor),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.star, color: Colors.white, size: 24),
              Icon(Icons.star, color: Colors.white, size: 24),
              Icon(Icons.star, color: Colors.white, size: 24),
              Icon(Icons.star_border, color: Colors.white, size: 24),
              Icon(Icons.star_border, color: Colors.white, size: 24),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '10 review photos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,

              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildReviewPhoto('assets/image/station_one.jpg'),
              _buildReviewPhoto('assets/image/station_two.jpg'),
              _buildReviewPhoto('assets/image/station_three.jpg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewPhoto(String assetPath) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(assetPath), // Replace with your image asset
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildReviewInput() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFC5D0E6)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Review...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Icon(Icons.photo_library_outlined, color: Colors.white70),
          SizedBox(width: 8),
          SvgPicture.asset("assets/icon/send-2.svg", color: driverPrimaryColor),
        ],
      ),
    );
  }
}

class _GoToMapButton extends StatelessWidget {
  const _GoToMapButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2E3E2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF33D933)),
      ),
      child: const Text(
        'Go To Map',
        style: TextStyle(color: Color(0xFF33D933), fontSize: 12),
      ),
    );
  }
}

class _ScanToChargeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ScannerScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: driverPrimaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Scan to charge',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookNowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();
    return PrimaryButton(
      text: "Book Now",
      onPressed: () async {
        LoadingDialog.show(context);
        final data = await provider.createConfirmBooking();
        if (data['id'] != null) {
          LoadingDialog.hide(context);
          provider.getBookingDetailsUser(data["id"]);
          CustomSnackbar.show(
            context,
            message: "Booking creating successfully",
          );

          context.push(RouterPath.bookingSummary);
        } else {
          LoadingDialog.hide(context);
          CustomSnackbar.show(context, message: "Something wrong, try again");
        }
      },
    );
  }
}

class SeviceFee extends StatefulWidget {
  const SeviceFee();

  @override
  State<SeviceFee> createState() => SeviceFeeState();
}

class SeviceFeeState extends State<SeviceFee> {
  String? selectedTimeSlot;
  int selectedDayIndex = 3; // Wednesday

  final List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<String> timeSlots = [
    '10:00 AM - 11:00 AM',
    '12:30 PM - 01:30 PM',
    '2:30 PM - 03:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Color(0xFF121C24),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Charging Not Yet Complete?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 1.22,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Session Is ending Extend Time to continue charging seamlessly.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.57,
              ),
            ),

            _buildTimeSlotSelector(),
            Text(
              'If not extended, your session will stop automatically.\nReconnecting may require new availability confirmation.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.83,
              ),
            ),
            const SizedBox(height: 24),
            _buildRescheduleButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlotSelector() {
    return Column(
      children: timeSlots.map((slot) {
        bool isSelected = selectedTimeSlot == slot;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedTimeSlot = slot;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Color(0xFF01CC01)
                      : const Color(0xFF2E3E2E),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF33D933)
                            : Colors.white70,
                        width: 2,
                      ),
                      color: isSelected
                          ? const Color(0xFF33D933)
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Center(
                            child: Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.black,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    slot,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRescheduleButton(BuildContext context) {
    return PrimaryButton(
      text: "Extend Session",
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
