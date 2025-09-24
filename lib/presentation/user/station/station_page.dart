import 'package:flutter/material.dart';
import 'package:voltly_app/common/custom_appbar.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/station_custom_card.dart';
import 'package:voltly_app/presentation/user/station/station_details.dart';

class StationPage extends StatelessWidget {
  const StationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nearby Stations',
              style: TextStyle(
                color: Color(0xFFF2F2F2),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.50,
              ),
            ),
            vPad15,
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return EvStationCard(
                    iconPath: "assets/icon/bi_ev-station.svg",
                    title: "Midtown expressway",
                    subtitle: "10mins drive",
                    rating: "4.5",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => StationDetails()),
                      );
                    },
                  );
                },
              ),
            ),
            vPad50,
          ],
        ),
      ),
    );
  }
}
