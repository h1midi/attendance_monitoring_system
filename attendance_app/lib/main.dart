import 'package:attendance_monitoring_system/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'attendance/attendance_provider.dart';
import 'user/user_provider.dart';

import 'user/login.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AttendanceProvider()),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: SafeArea(
              child: context.watch<UserProvider>().uid == null ? const LoginPage() : const Home(),
            ),
          ),
        );
      },
    );
  }
}
