class AppUrls {
  static String baseUrl = "http://10.10.13.20:8005/api/v1";
  static String imageUrl = "http://10.10.13.20:8005";
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
  static String getVehicleUrl = "/driver/vehicles/";

  static String getVehicleDetails = "/driver/vehicles/";

  static String getStationListUrl = "/driver/stations/nearby/";
  static String getStationDetails = "/driver/stations/nearby/";

  static String addCarUrl = "/driver/vehicles/";

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
}
