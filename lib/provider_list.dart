import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:voltly_app/presentation/common_page/authentication/auth_provider.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_provider.dart';
import 'package:voltly_app/presentation/user/profile/profile_provider.dart';

class ProviderList {
  static List<SingleChildWidget> get providers => [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()..getProfile()),
    ChangeNotifierProvider(
      create: (_) => HostProfileProvider()..getProfileHost(),
    ),
  ];
}
