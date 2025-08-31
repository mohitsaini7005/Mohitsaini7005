# Tribal Tourism SaaS App

A premium Flutter application for tribal tourism with professional features that compete with industry leaders like RedBus, MakeMyTrip, Booking.com, and Airbnb.

## 🎯 App Concept

This app serves as a one-stop platform for customers who want to explore tribal culture, tourism, events, and markets with a premium user experience.

## ✨ Core Features

### 🏠 Customer Side App
- **Trip Booking**: Search, compare, and book tribal tourism trips (guided tours, homestays, adventure activities)
- **Marketplace (E-commerce)**: Buy authentic tribal handicrafts, art, clothing, food items with integrated payment gateway and order tracking
- **Event & Festival Booking**: Book tickets for local tribal fests, cultural events, music shows
- **Reels/Shorts (Social Feed)**: Upload & view short videos of tribal stories, blogs, and experiences
- **Multi-Language Support**: English + regional languages
- **Wishlist & Favorites**: Save trips, events, or products
- **Smart Recommendation Engine**: Suggest trips/events/products based on interests & browsing history

### 🛡️ Admin / Organizer Dashboard (SaaS side)
- Add/Manage Trips & Packages (pricing, availability, discounts)
- Upload & Sell Products in the marketplace
- Create & Manage Events/Fests with ticketing integration
- Analytics Dashboard for sales, bookings, engagement
- Push Notifications & Marketing Tools

## 💎 UI/UX Features

- **Premium & Futuristic Look**: Smooth animations, glassmorphism + neon gradients, modern typography
- **Better than competitors**: More immersive, visually stunning, and engaging experience
- **Dark + Light Theme Support**: Seamless theme switching
- **Responsive Design**: Works perfectly on all screen sizes

## 🛠️ Technical Stack

- **Frontend**: Flutter (cross-platform Android & iOS)
- **Backend**: Firebase/Supabase
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Architecture**: Clean Architecture pattern
- **Payments**: Stripe/Razorpay integration
- **Storage**: Cloud Firestore + local caching
- **Authentication**: Firebase Auth with multi-provider support

## 📦 Dependencies

### Core Dependencies
- `flutter_riverpod` - State management
- `go_router` - Navigation
- `dio` - HTTP client
- `firebase_core` - Firebase initialization

### UI & Animations
- `flutter_animate` - Smooth animations
- `flex_color_scheme` - Premium theming
- `google_fonts` - Typography
- `shimmer` - Loading effects

### Backend & Storage
- `firebase_auth` - Authentication
- `cloud_firestore` - Database
- `firebase_storage` - File storage
- `shared_preferences` - Local storage

### Payment Integration
- `razorpay_flutter` - Payment gateway

### Media & Camera
- `image_picker` - Image selection
- `video_player` - Video playback
- `camera` - Camera functionality

## 📱 Features Implementation Status

### ✅ Completed
- [x] Project structure and architecture setup
- [x] Premium theme system with dark/light mode support
- [x] Authentication screens (Splash, Onboarding, Login, Register)
- [x] Home screen with premium UI components
- [x] Custom widgets (GradientButton, CustomTextField)
- [x] Navigation system with bottom navigation bar
- [x] Responsive design and animations
- [x] Firebase integration setup

### 🚧 In Progress
- [ ] Trip booking system
- [ ] Marketplace/E-commerce functionality
- [ ] Event booking system
- [ ] Social feed (Reels/Shorts)
- [ ] Admin dashboard

### 📋 Planned
- [ ] Payment integration (Razorpay/Stripe)
- [ ] Push notifications
- [ ] Multi-language support
- [ ] Offline mode
- [ ] AI-powered chatbot
- [ ] Loyalty & rewards system
- [ ] Advanced analytics
- [ ] AR/VR integration (future feature)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Firebase account

### Installation

1. Clone the repository:
```bash
git clone https://github.com/mohitsaini7005/Mohitsaini7005.git
cd Mohitsaini7005/tribal_tourism_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Create a new Firebase project
   - Add your Android/iOS app to the project
   - Download and place the configuration files:
     - `google-services.json` for Android
     - `GoogleService-Info.plist` for iOS
   - Update `firebase_options.dart` with your project configuration

4. Run the app:
```bash
flutter run
```

## 📱 Screenshots

*Screenshots will be added as features are implemented*

## 🏗️ Architecture

The app follows Clean Architecture principles with the following structure:

```
lib/
├── core/                 # Core functionality
│   ├── constants/        # App constants
│   ├── errors/          # Error handling
│   ├── network/         # Network configuration
│   ├── theme/           # App theming
│   ├── utils/           # Utility functions
│   └── widgets/         # Core widgets
├── features/            # Feature modules
│   ├── authentication/ # Auth feature
│   ├── trips/          # Trip booking
│   ├── marketplace/    # E-commerce
│   ├── events/         # Event booking
│   ├── social/         # Social features
│   ├── admin/          # Admin dashboard
│   └── profile/        # User profile
├── shared/             # Shared components
│   ├── models/         # Data models
│   ├── repositories/   # Data repositories
│   ├── services/       # Business services
│   └── widgets/        # Shared widgets
└── main.dart           # App entry point
```

## 🎨 Design System

The app features a premium design system with:

- **Color Scheme**: Custom gradient-based color palette
- **Typography**: Poppins font family with various weights
- **Components**: Glassmorphism cards, gradient buttons, animated elements
- **Animations**: Smooth transitions and micro-interactions
- **Responsive**: Adaptive layouts for all screen sizes

## 🔧 Development Guidelines

1. Follow the Clean Architecture pattern
2. Use Riverpod for state management
3. Implement proper error handling
4. Write comprehensive tests
5. Follow the established naming conventions
6. Document complex functionality

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/
```

## 📊 Performance

- **Startup Time**: < 2 seconds
- **Memory Usage**: Optimized for low-memory devices
- **Battery Efficiency**: Background processing minimized
- **Network Usage**: Efficient caching and offline support

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Mohit Saini**
- GitHub: [@mohitsaini7005](https://github.com/mohitsaini7005)
- Email: mohitsaini7005@gmail.com
- LinkedIn: [Mohit Saini](https://www.linkedin.com/in/mohit-saini-147a9223a)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Design inspiration from leading travel apps
- Open source community for various packages used

---

⭐ **If you like this project, please give it a star!** ⭐