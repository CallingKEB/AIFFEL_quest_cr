import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'channel_screen.dart';
import 'calendar_screen.dart';
import 'home_screen.dart';
import 'add_habit_screen.dart';
import 'recommendation_screen.dart';
import 'attendance_screen.dart';
import 'habit_management_screen.dart';

void main() {
  runApp(HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/channel': (context) => ChannelScreen(),
        '/calendar': (context) => CalendarScreen(),
        '/home': (context) => HomeScreen(),
        '/add': (context) => AddHabitScreen(),
        '/recommend': (context) => RecommendationScreen(),
        '/attendance': (context) => AttendanceScreen(),
        '/habitManagement': (context) => HabitManagementScreen(),
      },
    );
  }
}