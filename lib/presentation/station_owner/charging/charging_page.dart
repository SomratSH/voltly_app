import 'package:flutter/material.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/presentation/station_owner/charging/add_charger_owner.dart';

class ChargingPageOwner extends StatelessWidget {
  const ChargingPageOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/image/owner_charging.png",
                height: 200,
                width: 200,
              ),
              Text(
                'No EV Charger found',
                style: TextStyle(
                  color: const Color(0xFFF4F4F4),
                  fontSize: 32,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              vPad10,
              PrimaryButton(
                text: "Add New Charger",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddChargerOwner()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
