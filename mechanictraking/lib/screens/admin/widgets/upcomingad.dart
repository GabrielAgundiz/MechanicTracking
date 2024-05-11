import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mechanictracking/model/appointment.dart';
import 'package:mechanictracking/screens/admin/scheduledetailsad.dart';
import 'package:mechanictracking/services/appointment_service.dart';
import 'package:intl/intl.dart';

class UpcomingScheduleAD extends StatelessWidget {
  const UpcomingScheduleAD({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Proximas Citas",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const CardAppointment(
                  "mWJIPxmUfO593KyCwNr0"), //widget de info de las citas
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class CardAppointment extends StatefulWidget {
  final String appointmentId;
  const CardAppointment(this.appointmentId, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CardAppointmentState();
  }
}

class _CardAppointmentState extends State<CardAppointment> {
  Appointment? _appointment; //state local

  @override
  void initState() {
    super.initState();
    _getAppointment(widget.appointmentId);
  }

  void _getAppointment(String appointmentId) async {
    var appointment = await AppointmentService().getAppointment(appointmentId);
    setState(() {
      _appointment = appointment;
    });
  }

  Future<void> _cancelCite() async {
  await FirebaseFirestore.instance
      .collection('citas')
      .doc(_appointment!.id)
      .update({'status': 'Cancelado'});

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('La cita se ha cancelado correctamente'),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    if (_appointment == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (_appointment!.status == "Pendiente") {
      return Column(
        children: [
          ListTile(
            title: Text(
              _appointment!.auto, //signo porque puede ser nulo
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_appointment!.motivo),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              thickness: 1,
              height: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat('dd/MM/yyyy').format(_appointment!.date),
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_filled,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat.jm().format(_appointment!.date),
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Pendiente",
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: _cancelCite,
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Cancelar",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ScheduleDetailsPageAD()), // Navega a la página de registro.
                  );
                },
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Ver detalles",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );
    } else {
      return const Column(
        children: [
          Text(
            "No tiene citas pendientes",
            style: TextStyle(color: Colors.black54),
          )
        ],
      );
    }
  }
}
