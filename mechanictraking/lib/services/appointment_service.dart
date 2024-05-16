import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanictracking/model/appointment.dart';

class AppointmentService {
  //obtener un documento particular de firebase(tabla)
  //se crea la referencia (el path) del nombre de la collection(tabla)
  //.get se obtienen todos las citas
  //withConverter ayuda a convertir de inmediato la data (snapshot (objeto que devuelve firestore) a nuestras clases
  final appointmentRef = FirebaseFirestore.instance
      .collection('citas')
      .withConverter(
        fromFirestore: (snapshot, _) =>
            Appointment.fromJson(snapshot.id, snapshot.data()!),
        toFirestore: (citas, _) => citas
            .toJson(), //recibe como parametro un modelo y lo convierto a Json con mi metodo toJson de appointment
      ); //convierto de firestore a mis clases con mi metodo hecho en appointment

  //TODO modificar este metodo para obtener todas las citas con valor pendiente en status
  Future<List<Appointment>> getAllAppointment() async {
    //nos devuelve un future que devuelve una lista de citas
    //apartir de mi referencia obtengo los datos y regresa la respuesta (query que contiene book)
    var result = await appointmentRef.get().then((value) => value);
    //obtiene los tres ultimos
    List<Appointment> appointment = []; //lista vacia

    for (var doc in result.docs) {
      //se itera para cada uno de los docs(tablas) que vienen en mi resultado
      //se agrega la cita que viene en cada doc en su data a mi lista de citas appointment
      appointment.add(doc.data());
    }
    //refresa un future value de la lista de libros obtenida
    return Future.value(appointment);
  }

  Future<Appointment> getAppointment(String appointmentId) async {
    //nos devuelve un future que devuelve una lista de libros
    // obtiene un libro especifico a partir de su id
    var result =
        await appointmentRef.doc(appointmentId).get().then((value) => value);

    if (result.exists) {
      return Future.value(result.data());
    }
    throw const HttpException("Cita no encontrado");
  }

  Future<List<Appointment>> getAllAppointmentId(
      String userId, String status) async {
    var result = await appointmentRef
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: status)
        .get();

    List<Appointment> appointments = [];
    for (var doc in result.docs) {
      appointments.add(doc.data());
    }
    //refresa un future value de la lista de libros obtenida
    return Future.value(appointments);
  }

  Future<List<Appointment>> getAllAppointments(
      String userId, String status) async {
    var result = await appointmentRef.where('status', isEqualTo: status).get();

    List<Appointment> appointments = [];
    for (var doc in result.docs) {
      appointments.add(doc.data());
    }
    //refresa un future value de la lista de libros obtenida
    return Future.value(appointments);
  }

  Future<List<Appointment>> getAllAppointments1(String userId) async {
    var result = await appointmentRef.get();

    List<Appointment> appointments = [];
    for (var doc in result.docs) {
      appointments.add(doc.data());
    }
    //refresa un future value de la lista de libros obtenida
    return Future.value(appointments);
  }

  Future<Diagnostico> getAppointmentTraking(
      String appointmentId, String diagnosticoId) async {
    var result = await appointmentRef
        .doc(appointmentId)
        .collection("citasDiagnostico")
        .doc(diagnosticoId)
        .get();

    if (result.exists) {
      var data = result.data();
      if (data != null) {
        Diagnostico diagnostico = Diagnostico.fromJson(result.id, data);
        return diagnostico;
      }
      throw Exception("Los datos de la cita están vacíos");
    }
    throw Exception("Cita no encontrada");
  }
}
