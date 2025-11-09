import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/application/driver/profile/model/profile_model.dart';
import 'package:voltly_app/common/custom_appbar.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/user/profile/profile_provider.dart';
import 'package:voltly_app/presentation/user/station/add_charing.dart';

class ConnectCharger extends StatefulWidget {
  const ConnectCharger({super.key});

  @override
  State<ConnectCharger> createState() => _ConnectChargerState();
}

class _ConnectChargerState extends State<ConnectCharger> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 4),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddCharing()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    provider.profileModel.data!.picture != null
                        ? "${AppUrls.imageUrl}${provider.profileModel.data!.picture}"
                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNV2dimRVLDjbd9FtA7z4Qz8wJIVQ_UljnUiB6Zd-5TCWz8-5TFzTZf90&s",
                  ),
                ),
                hPad5,
                SvgPicture.asset("assets/icon/connecting.svg"),
                hPad5,
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    "assets/image/station_details.png",
                  ),
                ),
              ],
            ),
            vPad50,
            Text(
              'Connecting to ABC...',
              style: TextStyle(
                color: const Color(0xFFB3B2B9),
                fontSize: 18,
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
