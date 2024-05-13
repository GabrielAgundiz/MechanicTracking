import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String auto;
  final DateTime date;
  final String motivo;
  final String status;

  Appointment(this.id, this.auto, this.date, this.motivo, this.status);

  factory Appointment.fromJson(String id, Map<String, dynamic> json) {
    return Appointment(
      id,
      json['automovil'] as String,
      (json['date'] as Timestamp).toDate(),
      json['motivo'] as String,
      json['status'] as String,
    );
  }
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
