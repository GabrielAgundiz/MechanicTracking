class Appointment {
  final String id;
  final String auto;
  //final String date;
  final String motivo;
  final bool status;

  Appointment(this.id, this.auto, this.motivo, this.status);

  Appointment.fromJson(String id, Map<String, dynamic> json)
      : //dynamic es el contenido y el string son las key
        this(
          id,
          json['automovil'] as String, //se debe parsear cada elemento
          //json['date'] as String,
          json['motivo'] as String,
          json['status'] as bool,
        );
  toJson() {
    throw Exception();
  }
}
