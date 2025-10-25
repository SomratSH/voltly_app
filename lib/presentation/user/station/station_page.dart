import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_appbar.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/station_custom_card.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/user/station/station_details.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class StationPage extends StatelessWidget {
  const StationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();
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
                itemCount: provider.stationList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final station = provider.stationList[index];
                  return EvStationCard(
                    iconPath: "${AppUrls.imageUrl}${station.details!.image}",
                    title: "${station.name}",
                    subtitle: "${station.timeToReachMin}mins drive",
                    rating: "4.5",
                    onTap: () {
                      provider.selectedStationFunc(station);
                      context.push(RouterPath.stationDetails);
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
