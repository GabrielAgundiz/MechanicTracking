import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanictracking/screens/user/widgets/sectionheading.dart';

class TrackFormAD extends StatefulWidget {
  const TrackFormAD({super.key});

  @override
  State<TrackFormAD> createState() => _TrackFormADState();
}

class _TrackFormADState extends State<TrackFormAD> {
  //estado de la cita
  final _formKey = GlobalKey<FormState>();
  String _model = '';
  String _reason = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 8, minute: 0);

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _saveCite() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final dateTime = _selectedDate.add(
          Duration(hours: _selectedTime.hour, minutes: _selectedTime.minute));
      await FirebaseFirestore.instance.collection('citas').add({
        'automovil': _model,
        'date': dateTime,
        'motivo': _reason,
        'status': 'Pendiente',
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La cita se ha agendado correctamente'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Actualizar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SectionHeading(
                    title: "Estado del servicio",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Ingresa el estado del automovil:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Estado del automóvil',
                        hintStyle: TextStyle(fontSize: 14)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese un modelo';
                      }
                      return null;
                    },
                    onSaved: (value) => _model = value!,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Descripción del estado:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Descripción del estado',
                        hintStyle: TextStyle(fontSize: 14)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese un motivo';
                      }
                      return null;
                    },
                    onSaved: (value) => _reason = value!,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "¿Incluye Diagnóstico?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
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
                        onTap: _saveCite,
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Guardar",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
