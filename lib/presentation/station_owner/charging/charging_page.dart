import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/common/qr_code_dialog.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/station_owner/charging/add_charger_owner.dart';
import 'package:voltly_app/presentation/station_owner/charging/charging_provider.dart';

class ChargingPageOwner extends StatelessWidget {
  const ChargingPageOwner({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChargingProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Center(
                    child: Text(
                      'My Chargers',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: InkWell(
                      onTap: () => context.push(RouterPath.addChargerHost),
                      child: Image.asset(
                        "assets/image/charging-station.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: provider.chargerList.isEmpty
                  ? _buildEmptyState(context)
                  : _buildChargerList(context, provider),
            ),
            vPad70,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouterPath.addChargerHost),
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/owner_charging.png",
              height: 200,
              width: 200,
            ),
            vPad10,
            const Text(
              'No EV Charger found',
              style: TextStyle(
                color: Color(0xFFF4F4F4),
                fontSize: 28,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            vPad10,
            PrimaryButton(
              text: "Add New Charger",
              onPressed: () => context.push(RouterPath.addChargerHost),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChargerList(BuildContext context, ChargingProvider provider) {
    return RefreshIndicator(
      onRefresh: () => provider.getChargingList(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: provider.chargerList.length,
        itemBuilder: (context, index) {
          final charger = provider.chargerList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildChargerCard(
              context: context,
              chargerName: charger.name ?? 'Unknown Charger',
              location: '123 St, Midtown expressway',
              price: "${charger.price ?? 0}/kWh",
              isActive: charger.isActive ?? false,
              qrImage: charger.scannerImage ?? "",
              provider: provider,
              index: index,
            ),
          );
        },
      ),
    );
  }

  Widget _buildChargerCard({
    required BuildContext context,
    required String chargerName,
    required String location,
    required String price,
    required bool isActive,
    required String qrImage,
    required ChargingProvider provider,
    required int index,
  }) {
    final statusColor = isActive ? primaryColor : Colors.grey;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFF182724),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.7, color: Color(0xFFD1D5DB)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icon/first_charger.svg",
              color: primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chargerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    statusColor == primaryColor ? 'Active' : 'Inactive',
                    style: TextStyle(color: statusColor),
                  ),
                  Switch(
                    value: isActive,
                    onChanged: (value) {
                      provider.chargerList[index].isActive = value;
                      provider.notifyListeners();
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (qrImage.isEmpty) {
                        CustomSnackbar.show(
                          context,
                          message: "QR Image not available for this charger",
                        );
                      } else {
                        QrPopupDialog.show(
                          context: context,
                          imageUrl: qrImage,
                          title: 'Charger QR Code',
                        );
                      }
                    },
                    icon: const Icon(Icons.qr_code, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Color(0xFFD1D5DB), fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
