// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../Event.dart';

class Attendance {
  final String user;
  final Event event;
  final DateTime timestamp;
  Attendance({
    required this.user,
    required this.event,
    required this.timestamp,
  });

  Attendance copyWith({
    String? user,
    Event? event,
    DateTime? timestamp,
  }) {
    return Attendance(
      user: user ?? this.user,
      event: event ?? this.event,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'event': event.toMap(),
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      user: map['user'] as String,
      event: Event.fromMap(map['event'] as Map<String, dynamic>),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) => Attendance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Attendance(user: $user, event: $event, timestamp: $timestamp)';

  @override
  bool operator ==(covariant Attendance other) {
    if (identical(this, other)) return true;

    return other.user == user && other.event == event && other.timestamp == timestamp;
  }

  @override
  int get hashCode => user.hashCode ^ event.hashCode ^ timestamp.hashCode;
}
