import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:voltly_app/presentation/common_page/authentication/auth_provider.dart';
import 'package:voltly_app/presentation/station_owner/charging/charging_provider.dart';
import 'package:voltly_app/presentation/station_owner/home_page/host_home_provider.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_provider.dart';
import 'package:voltly_app/presentation/user/add_car/car_add_provider.dart';
import 'package:voltly_app/presentation/user/home_page/home_provider.dart';
import 'package:voltly_app/presentation/user/profile/profile_provider.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class ProviderList {
  static List<SingleChildWidget> get providers => [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(
      create: (_) => ChargingProvider()..getChargingList(),
    ),
    ChangeNotifierProvider(create: (_) => HostHomeProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()..getProfile()),
    ChangeNotifierProvider(
      create: (_) => HostProfileProvider()..getProfileHost(),
    ),
    ChangeNotifierProvider(create: (_) => CarAddProvider()..getVehicleList()),
    ChangeNotifierProvider(
      create: (_) => StationProvider()..getNeayByStation(),
    ),
  ];
}
