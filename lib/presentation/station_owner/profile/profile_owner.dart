import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/application/host/home/repo/dashboard_host_repo.dart';
import 'package:voltly_app/common/custom_dialog.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/constant/app_urls.dart' show AppUrls;
import 'package:voltly_app/presentation/station_owner/home_page/host_home_provider.dart';
import 'package:voltly_app/presentation/station_owner/profile/connect_account.dart';
import 'package:voltly_app/presentation/station_owner/profile/contact_us.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_provider.dart';
import 'package:voltly_app/presentation/station_owner/profile/review_page.dart';
import 'package:voltly_app/presentation/station_owner/profile/subscription/subscription_page.dart';
import 'package:voltly_app/presentation/user/payment/payment_charging.dart';
import 'package:voltly_app/presentation/user/profile/changed_password.dart';
import 'package:voltly_app/presentation/user/profile/charging_history.dart';
import 'package:voltly_app/presentation/user/profile/message_page.dart';
import 'package:voltly_app/presentation/user/profile/privacy_policy.dart';
import 'package:voltly_app/presentation/user/profile/terms_condition.dart';
import 'package:voltly_app/presentation/user/profile/update_profile.dart';

Widget _buildSettingsAndSupportSection(BuildContext context) {
  return DecoratedBox(
    decoration: ShapeDecoration(
      color: const Color(0xFF182724),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings & Support',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSwitchItem(Icons.notifications_none, 'Notifications'),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ContactUs()),
                ),
                child: _buildMenuItemIcon(
                  Icons.help_outline,
                  'Help Center',
                  showDivider: false,
                ),
              ),

              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChangedPassword()),
                ),
                child: _buildMenuItemIcon(
                  Icons.lock,
                  'Change Password',
                  showDivider: false,
                ),
              ),

              InkWell(
                onTap: () => showAccountDeleteDialog(context),
                child: const Text(
                  'Delete Account !',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TermsScreen()),
                    ),
                    child: Text(
                      'Terms & Conditions',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  vPad10,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PrivacyPolicy()),
                      );
                    },
                    child: Text(
                      'Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class ProfileOwner extends StatelessWidget {
  const ProfileOwner({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<HostProfileProvider>();
    final hostDashbaord = context.watch<HostHomeProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: ShapeDecoration(
                  color: const Color(0xFF182724),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Account Information',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.56,
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                context.push(RouterPath.updateProfileHost),
                            child: Text(
                              'Edit Info',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      vPad10,
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  profileProvider.hostProfileModel.data ==
                                              null ||
                                          profileProvider
                                                  .hostProfileModel
                                                  .data!
                                                  .picture ==
                                              null
                                      ? "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D"
                                      : "${AppUrls.imageUrl}${profileProvider.hostProfileModel.data!.picture!}",
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          hPad15,
                          Text(
                            '${profileProvider.hostProfileModel.data == null || profileProvider.hostProfileModel.data!.fullName == null ? "N/A" : profileProvider.hostProfileModel.data!.fullName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.07,
                              letterSpacing: 0.14,
                            ),
                          ),
                        ],
                      ),
                      vPad20,
                      Row(
                        children: [
                          Icon(Icons.mail, color: const Color(0xFFD1D5DB)),
                          hPad10,
                          Text(
                            '${profileProvider.hostProfileModel.data == null || profileProvider.hostProfileModel.data!.email == null ? "N/A" : profileProvider.hostProfileModel.data!.email}',
                            style: TextStyle(
                              color: const Color(0xFFD1D5DB),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                        ],
                      ),
                      vPad10,
                      Row(
                        children: [
                          Icon(Icons.call, color: const Color(0xFFD1D5DB)),
                          hPad10,
                          Text(
                            '${profileProvider.hostProfileModel.data == null || profileProvider.hostProfileModel.data!.phone == null ? "N/A" : profileProvider.hostProfileModel.data!.phone}',
                            style: TextStyle(
                              color: const Color(0xFFD1D5DB),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              vPad10,
              GestureDetector(
                onTap: () {
                  context.push(RouterPath.messaginHost);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF007F5F), Color(0xFF2B9348)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/image/comment.png",
                          height: 22,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Message",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              vPad10,
              SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: const Color(0xFF182724),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Setup',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        vPad15,

                        hostDashbaord
                                    .hostDashboardModel
                                    .paymentSetup!
                                    .stripeStatus ==
                                "No Stripe account linked"
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "No Stripe account linked",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: PrimaryButton(
                                      text: "Link Stripe",
                                      onPressed: () async {
                                        LoadingDialog.show(context);
                                        final response = await hostDashbaord
                                            .linkStripeAccountHost();
                                        if (response["onboarding_url"] !=
                                            null) {
                                          LoadingDialog.hide(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ConnectAccount(
                                                url: response["onboarding_url"],
                                              ),
                                            ),
                                          );
                                        } else {
                                          LoadingDialog.hide(context);
                                          CustomSnackbar.show(
                                            context,
                                            message: response['error'],
                                            backgroundColor: Colors.red,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icon/stripe.svg",
                                          ),
                                          hPad5,
                                          Text(
                                            'Stripe Connect',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 1.50,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Color(0xFF01CC01),
                                          ),
                                          hPad5,
                                          Text(
                                            'Verified',
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 16,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 1.50,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  vPad15,
                                  PrimaryButton(
                                    text: "Update Payment Method",
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),

              vPad15,
              DecoratedBox(
                decoration: ShapeDecoration(
                  color: const Color(0xFF182724),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subscription Plan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      vPad10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Current Plan',
                            style: TextStyle(
                              color: const Color(0xFFD1D5DB),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                          Text(
                            hostDashbaord
                                .hostDashboardModel
                                .subscriptionPlan!
                                .currentPlan!,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                        ],
                      ),
                      vPad10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Next Billing',
                            style: TextStyle(
                              color: const Color(0xFFD1D5DB),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                          Text(
                            hostDashbaord
                                    .hostDashboardModel
                                    .subscriptionPlan!
                                    .nextBillingDate ??
                                "N/A",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                        ],
                      ),
                      vPad15,
                      PrimaryButton(
                        text: "Manage Plan",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SubscriptionScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              vPad15,
              DecoratedBox(
                decoration: ShapeDecoration(
                  color: const Color(0xFF182724),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        'My Chargers',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                hostDashbaord
                                    .hostDashboardModel
                                    .chargers!
                                    .activeChargers
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Active',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                hostDashbaord
                                    .hostDashboardModel
                                    .chargers!
                                    .inactiveChargers
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Inactive',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      vPad20,
                      PrimaryButton(text: "Add New Chargers", onPressed: () {}),
                    ],
                  ),
                ),
              ),
              vPad15,
              DecoratedBox(
                decoration: ShapeDecoration(
                  color: const Color(0xFF182724),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ratings & Reviews',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      vPad10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: List.generate(
                                  hostDashbaord
                                      .hostDashboardModel
                                      .ratingsAndReviews!
                                      .averageRating!
                                      .toInt(),
                                  (index) =>
                                      Icon(Icons.star, color: Colors.amber),
                                ),
                              ),
                              hPad5,
                              Text(
                                hostDashbaord
                                    .hostDashboardModel
                                    .ratingsAndReviews!
                                    .averageRating
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.56,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${hostDashbaord.hostDashboardModel.ratingsAndReviews!.totalReviews!} reviews',
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                        ],
                      ),
                      vPad20,
                      SizedBox(
                        width: double.infinity,
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ReviewPage()),
                          ),
                          child: DecoratedBox(
                            decoration: ShapeDecoration(
                              color: Colors.black.withValues(alpha: 0),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: primaryColor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'View All Feedback',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              vPad15,
              _buildSettingsAndSupportSection(context),
              const SizedBox(height: 24),
              InkWell(
                onTap: () => showLogoutDialog(context),
                child: _buildFooter(),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

Widget _buildFooter() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            'Logout',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primaryColor,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 1.38,
              letterSpacing: 0.16,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildMenuItemIcon(
  IconData? icon,
  String title, {
  bool showDivider = true,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 16),
            ],
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildSwitchItem(IconData icon, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Text(
              'Notifications',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ],
        ),
        Transform.scale(
          scale: 0.6,
          child: Switch(
            value: true,
            onChanged: (bool value) {},
            activeColor: const Color(0xFF33D933),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.white10,
          ),
        ),
      ],
    ),
  );
}
