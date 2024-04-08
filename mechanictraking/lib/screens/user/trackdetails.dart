import 'package:flutter/material.dart';
import 'package:mechanictracking/screens/user/widgets/verticalstepper.dart';
import 'package:mechanictracking/screens/user/widgets/verticalstepper.dart'
    as step;

class TrackDetailsPage extends StatelessWidget {
  TrackDetailsPage({super.key});

  List<step.Step> steps = [
    step.Step(
      shimmer: false,
      title: "Testing",
      iconStyle: Colors.green,
      content: Align(
        alignment: Alignment.centerLeft,
        child: Text("Testing"),
      ),
    ),
    step.Step(
      shimmer: false,
      title: "Testing",
      iconStyle: Colors.green,
      content: Align(
        alignment: Alignment.centerLeft,
        child: Text("Testing"),
      ),
    ),
    step.Step(
      shimmer: false,
      title: "Testing",
      iconStyle: Colors.blue,
      content: Align(
        alignment: Alignment.centerLeft,
        child: Text("Testing"),
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120),
                child: Column(
                  children: [
                    Text(
                      "Automovil",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text("Descripcion Servicio"),
                  ],
                ),
              ),
              SizedBox(
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
