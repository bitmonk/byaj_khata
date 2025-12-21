class AppEndpoints {
  // static const String baseUrl = 'http://192.168.10.80:8000/api';
  static const String baseUrl = 'http://52.63.119.148/api';

  //Auth -->
  static const String login = '/login';
  static const String logout = '/logout';
  static const String uniqueEmailCheck = '/unique-email/check';
  static const String deleteAccount = '/user/deleteAccount';
  static const String sendOtp = '/send-otp';
  static const String forgotPassword = '/forgot-password';
  static const String verifyEmailOtp = '/verify-email-otp';
  static const String resendEmailOtp = '/resend-email-otp';
  static const String resetPassword = '/reset-password';
  static const String verifyOtp = '/verify-otp';
  static const String resendOtp = '/resend-otp';
  static const String registerUser = '/register';
  static const String interests = '/interests';
  static const String addUserInterests = '/addUserInterests';
  static const String getNotificationPreference = '/notificationPreferences';
  static const String setNotificationPreference =
      '/updateOrCreateNotificationPreference';

  // Settings -->
  static const String termsAndConditions = '/terms-and-conditions';
  static const String privacyPolicy = '/privacy-policy';
  static const String getFaq = '/faq';
  static const String changePassword = '/user/change-password';
  static const String inviteFriends = '/user/invite';
  static const String help = '/user/help';
  static const String accountPrivacy = '/user/privacy';
  static const String getProfile = '/profile';
  static const String postStatus = '/user/status';
  static const String postProfilePicture = '/updateProfilePicture';
  static const String editProfile = '/updateProfile';
  static const String blockUsers = '/block-users';
  static const String unblockUser = '/user/unblock/';
  static const String favouriteEventsProfile = '/events/favorites';

  // Home -->
  static const String upcomingEvents = '/events/upcoming';
  static const String homeAll = '/events/all';
  static const String events = '/events';
  static const String eventAll = '/events/different-flags';
  static const String eventsAroundYou = '/events/events-around-you';
  static const String myEvents = '/users/events';
  static const String recommendedEvents = '/events/recommended';
  static const String connectionRequest = '/connection-request';
  static const String filterEvents = '/filter';
  static const String userDetails = '/user/';
  static const String requestConnection = '/connection-request';
  static const String checkinsList = '/users/checkins';
  static String getRemove({required int id}) => '/connection/remove/$id';
  // Chat
  static const String initialChat = '/initial-chat/user/';
  static const String postFile = '/file-upload';
  static const String blockUer = '/user/block/';
  static const String reportUser = '/user/report/';

  //Helpful Resources
  static const String getHelpfulResources = '/getResourceList';
  static String getHelpfulResourcesDetails({required String slug}) =>
      '/getResourceDetails?slug=$slug';
  static String getFavouriteEvents({required String type}) =>
      '/events/favorites?type=$type';
  static String postFavouriteEvents({required int eventID}) =>
      '/events/$eventID/favorite';
  static String postFavouritePlaces({required int placeID}) =>
      '/places/$placeID/favorite';
  static const String getMapList = '/events/map';

  //Places
  static const getPlaces = '/places/different-flags';
  static const getEventAtLocation = '/events-at-location';
  static String getPlacesDetails({required int placesID}) =>
      '/places/$placesID';
  static String getPlacesViewAll({required int placesID}) =>
      '/categories/$placesID/places';

  /// Get list of users who have checked in at a place.
  ///
  /// Parameters:
  /// [placesID] - The ID of the place.
  ///

  static String getPlacesCheckinUser({required int placesID}) =>
      '/places/$placesID/checkin-users';
  static String postPlacesCheckOut({required int placesID}) =>
      '/places/$placesID/checkout';
  static String postPlacesCheckIn({required int eventID}) =>
      '/places/$eventID/checkin';

  //Trending Venues
  static const getTrendingVenues = '/places/trending';

  //Popular Outdoor Venues
  static const getPopularOutdoorVenues = '/places/popular-Outdoor-Places';
  static const getNotificationList = '/notifications/list';
  static const getConnectionRequestList = '/connection-request/list';
  static const getConnectionList = '/connection/list';
  static const cancelConnectionRequest = '/unsent-connection-request';
  static const emailNotification = '/email-notification-preferences';
  static const updateOrCreateEmailNotificationPreference =
      '/updateOrCreateEmailNotificationPreference';
  static String postacceptRejectRequest({required int senderID}) =>
      '/connection-request/$senderID/respond';
  static const sendConnectionRequest = '/connection-request';
  static const getAllEvents = '/events-list';
  static const getAllPlaces = '/places-list';
}

class ExternalEndpoints {}
