import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/application/host/home/repo/dashboard_host_repo.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/station_owner/home_page/host_home_provider.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_provider.dart';

class EarningPage extends StatelessWidget {
  const EarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HostProfileProvider>();
    final dashboardProvider = context.watch<HostHomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Earnings & Payout',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEarningsOverview(provider),
            const SizedBox(height: 16),
            _buildNextPayoutCard(provider),
            const SizedBox(height: 16),
            _buildWithdrawButton(dashboardProvider, context),
            const SizedBox(height: 16),
            _buildExportReportButton(),
            const SizedBox(height: 24),
            const Text(
              'Transaction History',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildTransactionCard(
              date: 'Sep 14, 2025',
              description: 'Stripe',
              amount: '\$35.00',
              status: 'Paid',
            ),
            const SizedBox(height: 16),
            _buildTransactionCard(
              date: 'Sep 10, 2025',
              description: 'Stripe',
              amount: '\$42.00',
              status: 'Paid',
            ),
            vPad70,
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsOverview(HostProfileProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
          const SizedBox(height: 16),
          provider.earningPayoutModel.earningsOverview == null
              ? SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildEarningsItem(
                      label: 'Today',
                      amount:
                          '${provider.earningPayoutModel.earningsOverview!.today ?? "\$ 0.0"}',
                    ),
                    _buildEarningsItem(
                      label: 'This Week',
                      amount:
                          '${provider.earningPayoutModel.earningsOverview!.thisWeek ?? "\$ 0.0"}',
                    ),
                    _buildEarningsItem(
                      label: 'This Month',
                      amount:
                          '${provider.earningPayoutModel.earningsOverview!.thisMonth ?? "\$ 0.0"}',
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildEarningsItem({required String label, required String amount}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFFD1D5DB),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 1.43,
          ),
        ),
        const SizedBox(height: 4),
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

  Widget _buildNextPayoutCard(HostProfileProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.50),
          end: Alignment(1.00, 0.50),
          colors: [const Color(0x33182724), const Color(0x192ECC71)],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0x4C2ECC71)),
          borderRadius: BorderRadius.circular(16),
        ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Next Payout\nScheduled',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('Estimated', style: TextStyle(color: Color(0xFF888888))),
                  Text('Amount', style: TextStyle(color: Color(0xFF888888))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                provider.earningPayoutModel.nextPayout!.scheduledDate ?? "N/A",
                style: TextStyle(
                  color: hostprimaryColor,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                ),
              ),
              Text(
                provider.earningPayoutModel.nextPayout!.estimatedAmount ??
                    '\$0.00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(text: "View Details", onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawButton(HostHomeProvider provider, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        text: "Withdraw Now",
        onPressed: () async {
          LoadingDialog.show(context);
          final response = await provider.hostWithdrawRquest();
          if (response["error"] != null) {
            LoadingDialog.hide(context);
            CustomSnackbar.show(
              context,
              message: response["error"],
              backgroundColor: Colors.red,
            );
          }
        },
      ),
    );
  }

  Widget _buildExportReportButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.download, color: Color(0xFF01CC01)),
        label: Text(
          'Export Report',
          style: TextStyle(color: hostprimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTransactionCard({
    required String date,
    required String description,
    required String amount,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset("assets/icon/stripe.svg"),
                    hPad10,
                    Text(
                      description,
                      style: const TextStyle(color: Color(0xFF888888)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DecoratedBox(
                decoration: ShapeDecoration(
                  color: const Color(0x332ECC71),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: hostprimaryColor,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              vPad10,
              Text(
                amount,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
