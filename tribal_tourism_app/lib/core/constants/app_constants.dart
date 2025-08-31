class AppConstants {
  // App Information
  static const String appName = 'Tribal Tourism';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Discover Tribal Culture & Tourism';
  
  // API Configuration
  static const String baseUrl = 'https://api.tribaltourism.com';
  static const String apiVersion = 'v1';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String tripsCollection = 'trips';
  static const String productsCollection = 'products';
  static const String eventsCollection = 'events';
  static const String bookingsCollection = 'bookings';
  static const String reviewsCollection = 'reviews';
  static const String postsCollection = 'posts';
  
  // Storage Paths
  static const String profileImagesPath = 'profile_images';
  static const String tripImagesPath = 'trip_images';
  static const String productImagesPath = 'product_images';
  static const String eventImagesPath = 'event_images';
  static const String postVideosPath = 'post_videos';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;
  
  // Cache Duration
  static const Duration cacheDuration = Duration(minutes: 30);
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 300);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;
  
  // Payment
  static const String razorpayKey = 'rzp_test_your_key';
  
  // Support
  static const String supportEmail = 'support@tribaltourism.com';
  static const String supportPhone = '+91-98855-01077';
}