import 'package:flutter/material.dart';
import 'package:mechanictracking/model/appointment.dart';
import 'package:mechanictracking/screens/user/diagnostic.dart';
import 'package:mechanictracking/screens/user/widgets/verticalstepper.dart'
    as step;
import 'package:mechanictracking/screens/user/widgets/verticalstepper.dart';

class TrackDetailsPage extends StatelessWidget {
  final Appointment _appointment;
  TrackDetailsPage(this._appointment, {super.key});

  List<step.Step> steps = [
    step.Step(
      shimmer: false,
      title: "Automovil en Taller",
      iconStyle: Colors.grey,
      content: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "05/04/2024 11:35 AM",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "El automovil entro a reparacion en el taller.",
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ),
    step.Step(
      shimmer: false,
      title: "Automovil en Revision",
      iconStyle: Colors.green,
      content: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "05/04/2024 08:35 AM",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "El automovil se encuentra a revision.",
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 63),
                child: Builder(builder: (context) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiagnosticPage()),
                      );
                    },
                    child: Container(
                      width: 115,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Diagnostico",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    ),
    step.Step(
      shimmer: false,
      title: "Automovil Recibido",
      iconStyle: Colors.green,
      content: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "05/04/2024 11:35 AM",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "El automovil entro a reparacion en el taller.",
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles',
          style: TextStyle(fontWeight: FontWeight.bold),
        ), // Título de la barra de aplicación
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  children: [
                    Text(
                      _appointment.auto,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(_appointment.motivo),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              VerticalStepper(steps: steps, dashLength: 2)
            ],
          ),
        ),
      ),
    );
  }
}
