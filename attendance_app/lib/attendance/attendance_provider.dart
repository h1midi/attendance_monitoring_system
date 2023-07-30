import 'package:flutter/material.dart';
import 'Attendance.dart';

class AttendanceProvider extends ChangeNotifier {
  final List<Attendance> _attendanceList = []; // List to store attendance records

  // Function to add a new attendance record
  void addAttendance(Attendance attendance) {
    _attendanceList.add(attendance);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Function to remove an attendance record
  void removeAttendance(Attendance attendance) {
    _attendanceList.remove(attendance);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Function to remove an attendance record
  void clearAttendance() {
    _attendanceList.clear();
  }

  // Function to get a copy of the current attendance list
  List<Attendance> get attendanceList => List.from(_attendanceList);
}
