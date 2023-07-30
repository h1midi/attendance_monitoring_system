import 'package:attendance_monitoring_system/qr_scanner.dart';
import 'package:attendance_monitoring_system/user/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'attendance/my_attendance.dart';
import 'user/user_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> scannQr(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QrScanner(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 200, 226, 239),
        appBar: AppBar(
          title: const Text('Attendance'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyAttendance(),
                  ),
                );
              },
              icon: const Icon(Icons.history),
            ),
            IconButton(
              onPressed: () {
                userProvider.clearUser();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Text(
                  'Steps to register your attendance',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 8.0, right: 10.0, bottom: 8.0),
                    child: Image.asset('assets/images/step-1.png', height: 50),
                  ),
                  const Text(
                    'Ask your teacher for the QR code',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 8.0, right: 10.0, bottom: 8.0),
                    child: Image.asset('assets/images/step-2.png', height: 50),
                  ),
                  const Text(
                    'Scan the QR code with this app',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 8.0, right: 10.0, bottom: 8.0),
                    child: Image.asset('assets/images/step-3.png', height: 50),
                  ),
                  const Text(
                    'Wait for the confirmation',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 8.0, right: 10.0, bottom: 8.0),
                    child: Image.asset('assets/images/done.png', height: 50),
                  ),
                  const Text(
                    'You are done!',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              InkWell(
                highlightColor: Colors.transparent,
                // splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                onTap: () => scannQr(context),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 4),
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 16,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Scan QR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
