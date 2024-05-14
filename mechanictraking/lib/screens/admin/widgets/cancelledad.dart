import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mechanictracking/model/appointment.dart';
import 'package:mechanictracking/screens/user/scheduledetails.dart';
import 'package:mechanictracking/services/appointment_service.dart';

class CancelledScheduleAD extends StatefulWidget {
  const CancelledScheduleAD({super.key});

  @override
  State<CancelledScheduleAD> createState() => _CancelledScheduleADState();
}

class _CancelledScheduleADState extends State<CancelledScheduleAD> {
  late String userId;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Appointment>>(
      future: AppointmentService().getAllAppointmentId(userId, "Cancelado"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Appointment> appointments = snapshot.data ?? [];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Citas Canceladas",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 18000),
                  child: SingleChildScrollView(
                    child: Column(
                      children: appointments
                          .map((appointment) => CardAppointment(appointment.id))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        }
      },
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

  @override
  Widget build(BuildContext context) {
    if (_appointment == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (_appointment!.status == "Cancelado") {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
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
          child: Column(
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
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "Cancelado",
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
                    onTap: () {
                      _openAppointmentDetails(context, _appointment);
                    },
                    child: Container(
                      width: 300,
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
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
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
          child: const Column(
            children: [
              Text(
                "Aun no tiene citas canceladas",
                style: TextStyle(color: Colors.black54),
              )
            ],
          ),
        ),
      );
    }
  }

  void _openAppointmentDetails(BuildContext context, Appointment? appointment) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScheduleDetailsPage(appointment!)),
    );
  }
}
