import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/user/profile/profile_provider.dart';
import 'package:voltly_app/presentation/user/station/charging_page.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class AddCharing extends StatelessWidget {
  const AddCharing({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();
    final profileProvider = context.watch<ProfileProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, profileProvider),
            vPad70,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Please plug in the charging connector to the car and tap',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: ' Charging.',
                          style: TextStyle(
                            color: const Color(0xFF06775C),
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  vPad15,
                  PrimaryButton(
                    text: "Charging",
                    onPressed: () async {
                      LoadingDialog.show(context);
                      final response = await provider.startChargingUser(
                        provider.bookingDetailsModel.bookingDetails!.bookingId!,
                      );
                      if (response['booking_id'] != null) {
                        LoadingDialog.hide(context);
                        CustomSnackbar.show(
                          context,
                          message: response["message"],
                        );
                        context.go(RouterPath.charging);
                      } else {
                        LoadingDialog.hide(context);
                        CustomSnackbar.show(
                          context,
                          message: "Somethign wrong, try again",
                        );
                      }
                    },
                  ),
                  vPad10,
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        color: const Color(0xFFCC6F6C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context, ProfileProvider provider) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      SizedBox(
        height: 250,
        width: double.infinity,
        child: Image.asset(
          'assets/icon/add_charger.png', // Replace with your image asset
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {},
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
          ],
        ),
      ),
      Positioned(
        bottom: -40,
        left: 20,
        child: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
            provider.profileModel.data!.picture != null
                ? "${AppUrls.imageUrl}${provider.profileModel.data!.picture}"
                : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNV2dimRVLDjbd9FtA7z4Qz8wJIVQ_UljnUiB6Zd-5TCWz8-5TFzTZf90&s",
          ),
        ),
      ),
    ],
  );
}
