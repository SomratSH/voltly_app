import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/presentation/user/profile/history_details.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class ChargingHistory extends StatelessWidget {
  const ChargingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: Text("Charging History", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Car',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFEDEDED),
                fontSize: 22,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            vPad10,
            DecoratedBox(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.bookingDetailsModel.vehicle!.model!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFBEBEBE),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      provider.bookingDetailsModel.vehicle!.plugType!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFD7D7D7),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            vPad15,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Date',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF858585),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    hPad5,
                    Text(
                      '15/09/25',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    hPad5,
                    Icon(Icons.arrow_drop_down_sharp, color: Colors.green),
                  ],
                ),
              ],
            ),
            Column(
              children: List.generate(
                provider.charingHistoryModel.history!.length,

                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF9CA3AF),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/image/station_details.png",
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Station',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                provider
                                    .charingHistoryModel
                                    .history![index]
                                    .stationName!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Usages',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                provider
                                    .charingHistoryModel
                                    .history![index]
                                    .usageKwh!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '${provider.charingHistoryModel.history![index].price} \$',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              LoadingDialog.show(context);
                              await provider.getCharingHistoryDetailsUser(
                                provider
                                    .charingHistoryModel
                                    .history![index]
                                    .bookingId!,
                              );
                              LoadingDialog.show(context);
                              context.push(RouterPath.chargingHistoryDetails);
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
