import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String auto;
  final DateTime date;
  final String motivo;
  final bool status;

  Appointment(this.id, this.auto, this.date, this.motivo, this.status);

  Appointment.fromJson(String id, Map<String, dynamic> json)
      : this(
          id,
          json['automovil'] as String,
          (json['date'] as Timestamp).toDate(),
          json['motivo'] as String,
          json['status'] as bool,
        );

  toJson() {
    return {
      'id': id,
      'automovil': auto,
      'date': date.toIso8601String(),
      'motivo': motivo,
      'status': status,
    };
  }
}