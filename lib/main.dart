import 'package:flutter/material.dart';
import 'package:lime_app/constants/colors.dart';
import 'package:lime_app/screens/feed_screen.dart';
import 'package:lime_app/screens/search_screen.dart';
import 'package:lime_app/screens/create_post_screen.dart';
import 'package:lime_app/screens/messages_screen.dart';
import 'package:lime_app/screens/profile_screen.dart';
import 'package:lime_app/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const LimeApp());
}

class LimeApp extends StatelessWidget {
  const LimeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lime - Caribbean Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: LimeColors.primaryBlue,
        useMaterial3: true,
        fontFamily: 'Segoe UI',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: LimeColors.textPrimary),
        ),
      ),
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  // List of screens
  final List<Widget> _screens = [
    const FeedScreen(),
    const SearchScreen(),
    const CreatePostScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
