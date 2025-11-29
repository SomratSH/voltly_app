class AppUrls {
  // static String baseUrl = "http://10.10.13.20:8005/api/v1";
  // static String imageUrl = "http://10.10.13.20:8005";

  static String baseUrl =
      "https://api.admin.dockploy.89.116.157.176.sslip.io/api/v1";
  static String imageUrl = "https://api.admin.dockploy.89.116.157.176.sslip.io";
  //authetication
  static String login = "/login/";
  static String signUp = "/signup/";
  static String forgotPassword = "/forgot-password/";
  static String verfiyOtp = "/verify-otp/";
  static String resetPassword = "/reset-password/";

  //profile section
  static String profile = "/get-profile/";
  static String profileUpdate = "/profile/update/";
  static String changePassword = "/change-password/";

  //user
  static String getVehicleUrl = "/driver/user-vehicles/list/";
  static String getVehicleDetails = "/driver/vehicles/";
  static String getStationListUrl = "/driver/stations/nearby/";
  static String getStationDetails = "/driver/stations/nearby/";
  static String addCarUrl = "/driver/user-vehicles/add/";
  static String subscriptionListUrl = "/subscriptions/plans/";
  static String createBooking = "/bookings/create-booking/";
  static String getUserBookingList = "/bookings/booking-list/";
  static String statChargingUrl = "/bookings/start-charging/";
  static String endChargingUrl = "/bookings/finish-charging/";
  static String paymentCharging = "/bookings/pay-for-booking/";
  static String chargingHistory = "/bookings/charging-history/";
  static String charingHistoryDetails = "/bookings/charging/";

  //host
  static String getChargingList = "/host/my-chargers/";
  static String addHostCharger = "/host/add-charger/";
  static String bookingListUrl = "/host/bookings/";
  static String acceptBooking = "/host/bookings/";
  static String changeChargerStatus = "/host/chargers/change-status/";
  static String bookingDetails = "/bookings/get-booking/";
  static String subscripToPlan = "/subscriptions/subscribe-to-plan/";
  static String getChatList = "/chat/all-station-chats/";
  static String getEarningPayout = "/stripe/earnings-payout/";
  static String upcomingReservation = "/host/upcoming-reservations/";
  static String hostLinkStripe = "/stripe/stripe-connect/setup/";
  static String hostDashboard = "/host/host-dashboard/";
  static String hostWithdrawRquest = "/stripe/host-withdraw-now/";
  static String getChatListHost = "/chat/users-chat-with-station/";

  //terms and privacy
  static String privacyPolicy = "/common/privacy-policy/";
  static String termsCondition = "/common/terms-conditions/";

  static String chatHistory = "/chat/messages/";

  static String helpSupport = "/common/help-support/";

  static String getPlugConnector = "/host/get-plugs/";

  //CREATE CHAT
  static String createChat = "/chat/create/";

  static String loginGoogle = "/google-login/";
}
