// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Event {
  final String eventName;
  final DateTime date;
  final String location;
  final String created_by;
  Event({
    required this.eventName,
    required this.date,
    required this.location,
    required this.created_by,
  });

  Event copyWith({
    String? eventName,
    DateTime? date,
    String? location,
    String? created_by,
  }) {
    return Event(
      eventName: eventName ?? this.eventName,
      date: date ?? this.date,
      location: location ?? this.location,
      created_by: created_by ?? this.created_by,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventName': eventName,
      'date': date.millisecondsSinceEpoch,
      'location': location,
      'created_by': created_by,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventName: map['eventName'] as String,
      date: DateTime.parse(map['date'] as String),
      location: map['location'] as String,
      created_by: map['created_by'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Event(eventName: $eventName, date: $date, location: $location, created_by: $created_by)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;

    return other.eventName == eventName &&
        other.date == date &&
        other.location == location &&
        other.created_by == created_by;
  }

  @override
  int get hashCode {
    return eventName.hashCode ^ date.hashCode ^ location.hashCode ^ created_by.hashCode;
  }
}
