import 'package:go_router/go_router.dart';
import 'package:voltly_app/presentation/common_page/authentication/forgot_password.dart';
import 'package:voltly_app/presentation/common_page/authentication/login_screen.dart';
import 'package:voltly_app/presentation/common_page/authentication/signup_screen.dart';
import 'package:voltly_app/presentation/common_page/authentication/update_password.dart';
import 'package:voltly_app/presentation/common_page/authentication/verify_email.dart';
import 'package:voltly_app/presentation/common_page/onboarding/onboarding_screen.dart';
import 'package:voltly_app/presentation/common_page/onboarding/onboarding_screen_second.dart';
import 'package:voltly_app/presentation/common_page/onboarding/splash_screen.dart';
import 'package:voltly_app/presentation/station_owner/charging/charging_page.dart';
import 'package:voltly_app/presentation/station_owner/earning/earning_page.dart';
import 'package:voltly_app/presentation/station_owner/home_page/home_page.dart';
import 'package:voltly_app/presentation/station_owner/landing_page/landing_owner_page.dart';
import 'package:voltly_app/presentation/station_owner/profile/host_udpate_profile.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_owner.dart';
import 'package:voltly_app/presentation/station_owner/resevation/reservation_page.dart';
import 'package:voltly_app/presentation/user/add_car/add_car.dart';
import 'package:voltly_app/presentation/user/home_page/home_page.dart';
import 'package:voltly_app/presentation/user/landing_page/landing_page.dart';
import 'package:voltly_app/presentation/user/profile/changed_password.dart';
import 'package:voltly_app/presentation/user/profile/profile_page.dart';
import 'package:voltly_app/presentation/user/profile/update_profile.dart';
import 'package:voltly_app/presentation/user/station/station_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: RouterPath.splash,
    routes: [
      // Auth routes
      GoRoute(
        path: RouterPath.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      // GoRoute(
      //   path: RouterPath.singUp,
      //   builder: (context, state) => const VoltlyCreateAccountPage(),
      // ),
      GoRoute(
        path: RouterPath.onBoardingOne,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: RouterPath.onBoardingTow,
        builder: (context, state) => const OnboardingScreenSecond(),
      ),
      GoRoute(
        path: RouterPath.login,
        builder: (context, state) => const LoginScreen(),
      ),
      // GoRoute(
      //   path: RouterPath.singUp,
      //   builder: (context, state) => const VoltlyCreateAccountPage(),
      // ),
      GoRoute(
        path: RouterPath.resetPassword,
        builder: (context, state) => const UpdatePassword(),
      ),
      GoRoute(
        path: RouterPath.verifyOtp,
        builder: (context, state) {
          final email = state.extra.toString() ?? '';
          return VerifyEmail(email: email);
        },
      ),

      GoRoute(
        path: RouterPath.forgotPassword,
        builder: (context, state) => ForgotPassword(),
      ),
      GoRoute(
        path: RouterPath.updateProfile,
        builder: (context, state) => UpdateProfile(),
      ),
      GoRoute(
        path: RouterPath.changePassword,
        builder: (context, state) => ChangedPassword(),
      ),

      //host
      GoRoute(
        path: RouterPath.updateProfileHost,
        builder: (context, state) => HostUpdateProfile(),
      ),
      GoRoute(
        path: RouterPath.profileHost,
        builder: (context, state) => ProfileOwner(),
      ),
      // Shell routing for protected pages driver
      ShellRoute(
        builder: (context, state, child) => LandingPage(child: child),
        routes: [
          GoRoute(
            path: RouterPath.home,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: RouterPath.addCar,
            builder: (context, state) => const AddCar(),
          ),
          GoRoute(
            path: RouterPath.stationPage,
            builder: (context, state) => const StationPage(),
          ),
          GoRoute(
            path: RouterPath.profile,
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),

      // Shell routing for protected pages host
      ShellRoute(
        builder: (context, state, child) => LandingOwnerPage(child: child),
        routes: [
          GoRoute(
            path: RouterPath.homeOwner,
            builder: (context, state) => const HomePageOwner(),
          ),
          GoRoute(
            path: RouterPath.reservationHost,
            builder: (context, state) => const ReservationPage(),
          ),
          GoRoute(
            path: RouterPath.chargingHost,
            builder: (context, state) => const ChargingPageOwner(),
          ),
          GoRoute(
            path: RouterPath.earningHost,
            builder: (context, state) => const EarningPage(),
          ),
        ],
      ),
    ],
  );
}

class RouterPath {
  //splash screen
  static String splash = "/splash";
  static String onBoardingOne = "/onboarding-one";
  static String onBoardingTow = "/onBoarding-two";
  static String login = "/login";
  static String singUp = "/signUp";
  static String forgotPassword = "/forgot-password";
  static String verifyOtp = "/verify-otp";
  static String resetPassword = "/reset-password";

  //driver page
  static String home = "/home";
  static String addCar = "/add-car";
  static String stationPage = "/station-page";
  static String profile = "/profile";
  static String updateProfile = "/update-profile";
  static String changePassword = "/change-password";

  //host page
  static String homeOwner = "/home-owner";
  static String reservationHost = "/reservation";
  static String chargingHost = "/charging-owner";
  static String earningHost = "/earning";

  static String updateProfileHost = "/update-profile-host";

  static String profileHost = "/profile-host";
}
