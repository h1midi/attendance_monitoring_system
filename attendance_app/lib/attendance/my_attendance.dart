import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Event.dart';
import '../user/user_provider.dart';
import 'Attendance.dart';
import 'attendance_provider.dart';
import 'package:intl/intl.dart';

class MyAttendance extends StatefulWidget {
  const MyAttendance({super.key});

  @override
  State<MyAttendance> createState() => _MyAttendanceState();
}

class _MyAttendanceState extends State<MyAttendance> {
  late final AttendanceProvider attendanceProvider;
  Future<void> getAttendance(userProvider, attendanceProvider) async {
    final String url = 'http://localhost:8080/my-attendance/${userProvider.uid}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final attendanceData = jsonData['attendanceData'];
      for (var attendance in attendanceData) {
        attendanceProvider.addAttendance(Attendance(
            user: attendance['user'],
            event: Event.fromMap(attendance['event']),
            timestamp: DateTime.parse(attendance['timestamp'])));
      }
    } else {}
  }

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false);
    getAttendance(userProvider, attendanceProvider);
    super.initState();
  }

  @override
  dispose() {
    attendanceProvider.clearAttendance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Attendance> attendanceList = Provider.of<AttendanceProvider>(context).attendanceList;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 226, 239),
      appBar: AppBar(
        title: const Text('My Attendance History'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: attendanceList.length,
        itemBuilder: (context, index) {
          Attendance attendance = attendanceList[index];
          return Card(
            color: const Color.fromARGB(255, 200, 226, 239),
            child: ListTile(
              title: Text(
                  '${attendance.event.eventName} | ${attendance.event.location} | ${DateFormat('yyyy-MM-dd').format(attendance.event.date)}'),
              subtitle: Text('Registered at ${DateFormat('HH:mm').format(attendance.timestamp)}'),
            ),
          );
        },
      ),
    );
  }
}
