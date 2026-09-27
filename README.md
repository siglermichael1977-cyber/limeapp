# Lime App - Caribbean Social Media Platform

A Flutter-based social media application designed for Caribbean communities with support for multiple languages.

## 📋 Project Structure

```
lime_app/
├── lib/
│   ├── main.dart              # App entry point
│   ├── screens/               # All screen implementations
│   │   ├── feed_screen.dart
│   │   ├── search_screen.dart
│   │   ├── create_post_screen.dart
│   │   ├── messages_screen.dart
│   │   ├── profile_screen.dart
│   │   └── explore_screen.dart
│   ├── widgets/               # Reusable UI components
│   │   ├── bottom_nav_bar.dart
│   │   ├── post_card.dart
│   │   ├── notification_item.dart
│   │   └── message_item.dart
│   ├── models/                # Data structures
│   │   ├── post.dart
│   │   ├── user.dart
│   │   ├── message.dart
│   │   └── notification.dart
│   └── constants/             # App constants
│       ├── colors.dart        # Theme colors and gradients
│       └── strings.dart       # UI text strings
├── pubspec.yaml               # Flutter dependencies
└── README.md                  # This file
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed ([https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install))
- Xcode (for iOS) or Android Studio (for Android)
- Apple Developer Account (for iOS submission)
- Google Play Developer Account (for Android submission)

### Installation

1. Navigate to project directory:
```bash
cd lime_app
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📱 Features Implemented

### Screens
- **Feed Screen**: View posts from users, like and comment on posts
- **Search Screen**: Trending hashtags and popular users discovery
- **Create Post Screen**: Write captions and add media (photos, videos, music)
- **Messages Screen**: View conversations and message history
- **Profile Screen**: View user profile, stats, and posts
- **Explore Screen**: Featured content and category browsing

### Components
- Bottom navigation bar (5 main tabs)
- Post cards with engagement metrics
- Notification items with emoji indicators
- Message list with unread counts
- User profile cards

### Design Features
- Neon gradient theme (Electric Blue to Neon Green)
- Consistent spacing and typography
- Responsive layout
- Dark-friendly UI palette
- Interactive elements with feedback

## 🎨 Design System

### Colors
- **Primary Blue**: #0080FF
- **Accent Green**: #00FF41
- **Background**: #FAF9F5
- **Card Background**: #FFFFFF
- **Text Primary**: #0F0C08
- **Text Secondary**: #666666
- **Text Tertiary**: #999999

### Typography
- Font Family: Segoe UI (system font)
- Headlines: 20px, weight 600-700
- Body: 14px, weight 400-600
- Small: 12px, weight 400-600

## 📦 Building for App Store Submission

### iOS Submission

1. Open Xcode project:
```bash
open ios/Runner.xcworkspace
```

2. Configure signing:
   - Select "Runner" in project navigator
   - Select "Runner" target
   - Go to "Signing & Capabilities"
   - Select your development team
   - Update bundle identifier to your unique ID

3. Build for release:
```bash
flutter build ipa
```

4. Upload to App Store Connect via Xcode or Transporter

### Android Submission

1. Configure keystore (create once):
```bash
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

2. Create key.properties file at `android/key.properties`:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=key
storeFile=../key.jks
```

3. Build AAB for Play Store:
```bash
flutter build appbundle
```

4. Upload to Google Play Console

## 🔧 Configuration Needed

### Before Submission

1. **Update App Name & Metadata**
   - Change `app_name` in `android/app/src/main/AndroidManifest.xml`
   - Update bundle identifier in iOS settings

2. **Add App Icon**
   - iOS: Replace icon in `ios/Runner/Assets.xcassets`
   - Android: Replace icon in `android/app/src/main/res/`

3. **Add Splash Screen**
   - iOS: Configure in Xcode
   - Android: Create resources in appropriate drawable folders

4. **Connect Backend API**
   - Update API endpoints in services/api_service.dart (create this file)
   - Implement authentication with your backend

5. **Add Localization** (for 5 Caribbean languages)
   - Use `flutter_localizations`
   - Create .arb files for each language
   - Update strings.dart to use localized strings

## 📝 Next Steps

1. **Test on Devices**: Run on iOS and Android devices
2. **Backend Integration**: Connect to real API endpoints
3. **Add Missing Features**:
   - Image/video upload
   - Real-time messaging
   - Push notifications
   - User authentication
4. **Internationalization**: Add translations for 5 Caribbean languages
5. **Submit**: Follow app store submission guidelines

## 🆘 Troubleshooting

### Flutter issues
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Build errors
- Check Flutter doctor: `flutter doctor`
- Update dependencies: `flutter pub upgrade`
- Check SDK versions in pubspec.yaml

### iOS issues
- Clean build: `cd ios && rm -rf Pods && rm Podfile.lock && cd ..`
- Update Pods: `cd ios && pod install && cd ..`

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [App Store Submission](https://developer.apple.com/app-store-connect/)
- [Google Play Submission](https://play.google.com/console)
- [Flutter Pub.dev](https://pub.dev)

## 📄 License

Proprietary - Lime App

## 👨‍💻 Development Notes

- Built with Flutter 3.0+
- No external API calls yet (mock data)
- Scalable component architecture
- Ready for backend integration
- UI matches design mockups

---

**Ready to submit?** Follow the "Building for App Store Submission" section above.
