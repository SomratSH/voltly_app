import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/application/driver/station/model/station_details_model.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class ConnectorTypeCard extends StatelessWidget {
  final String iconPath;
  final int chargerId;
  final List<PlugType> plugTypes; // list of plug objects
  final String power;
  final bool isAvailable;
  final String chargersName;
  final String mode;
  final String price;

  const ConnectorTypeCard({
    super.key,
    required this.iconPath,
    required this.chargerId,
    required this.plugTypes,
    required this.power,
    required this.isAvailable,
    required this.chargersName,
    required this.mode,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final plugProvider = Provider.of<StationProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
        color: Colors.black.withOpacity(0.15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- HEADER ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  iconPath,
                  color: Colors.greenAccent,
                  width: 28,
                  height: 28,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    chargersName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                isAvailable ? "Available" : "Closed",
                style: TextStyle(
                  color: isAvailable ? Colors.greenAccent : Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          vPad15,

          // ---------------- PLUG TYPE LIST ----------------
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: plugTypes.map((plug) {
              final isSelected =
                  plugProvider.selectedChargerId == chargerId &&
                  plugProvider.selectedPlugId == plug.id;

              return GestureDetector(
                onTap: () {
                  plugProvider.selectPlug(chargerId, plug.id!);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.greenAccent : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? Colors.greenAccent : Colors.white54,
                    ),
                  ),
                  child: Text(
                    plug.name ?? "Unknown", // safe handling
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 8),

          // ---------------- POWER INFO ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                power,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                "${price}/${mode}",
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
