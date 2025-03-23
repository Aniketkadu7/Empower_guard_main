import 'package:flutter/material.dart';
import 'package:pbl_3/screens/track_loved_ones_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/track_loved_ones_screen.dart';
import 'screens/share_location_screen.dart';
import 'screens/complaint_form_screen.dart';
import 'screens/nearby_complaints_screen.dart';
import 'screens/police_stations_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const EmpowerGuardApp());
}

class EmpowerGuardApp extends StatelessWidget {
  const EmpowerGuardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empower Guard',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/tracked_loved_ones': (context) => const TrackedLovedOnesScreen(),
        '/share_location': (context) => const ShareLocationScreen(),
        '/complaint_form': (context) => const ComplaintFormScreen(),
        '/nearby_complaints': (context) => const NearbyComplaintsScreen(),
        '/police_stations': (context) => const PoliceStationsScreen(),
      },
    );
  }
}

