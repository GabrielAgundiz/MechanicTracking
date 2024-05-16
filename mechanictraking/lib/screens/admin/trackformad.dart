import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mechanictracking/model/appointment.dart';
import 'package:mechanictracking/screens/admin/trackingad.dart';
import 'package:mechanictracking/screens/user/widgets/sectionheading.dart';

class TrackFormAD extends StatefulWidget {
  final Appointment _appointment;
  final Diagnostico _diagnostico;
  final Diagnostico _diagnostico2;
  final Diagnostico _diagnostico3;

  TrackFormAD(this._appointment, this._diagnostico, this._diagnostico2,
      this._diagnostico3,
      {super.key});

  @override
  State<TrackFormAD> createState() => _TrackFormADState();
}

class _TrackFormADState extends State<TrackFormAD> {
  Appointment? _appointment;
  //estado de la cita
  final _formKey = GlobalKey<FormState>();
  bool _includeDiagnostic = false;
  String _progreso = '';
  String _reason = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 8, minute: 0);

  late TextEditingController _progresoController;
  late TextEditingController _reasonController;
  late TextEditingController _descriptionController;
  late TextEditingController _costController;

  @override
  void initState() {
    super.initState();
    _progresoController = TextEditingController();
    _reasonController = TextEditingController();
    _descriptionController = TextEditingController();
    _costController = TextEditingController();
  }

  @override
  void dispose() {
    _progresoController.dispose();
    _reasonController.dispose();
    _descriptionController.dispose();
    _costController.dispose();
    super.dispose();
  }

  Future<void> _saveCite() async {
    setState(() {});
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final dateTime = DateTime.now();
      if (widget._appointment.status2 == 'Pendiente') {
        _saveInfoAceptado(dateTime);
      } else if (widget._appointment.status2 == 'Aceptado') {
        _saveInfoRevision(dateTime);
      } else if (widget._appointment.status2 == 'Diagnostico') {
        _saveInfoReparacion(dateTime);
      } else if (widget._appointment.status2 == 'Reparacion') {
        _saveInfoCompletado(dateTime);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La cita se ha agendado correctamente'),
        ),
      );
    }
  }

  Future<void> _saveInfoAceptado(DateTime dateTime) async {
    await FirebaseFirestore.instance
        .collection('citas')
        .doc(widget._appointment.id)
        .collection(
            'citasDiagnostico') // Agregar una subcolección 'citasDiagnostico' dentro del documento
        .doc(
            'Aceptado') // Puedes usar un ID único o el mismo ID del documento principal
        .set({
      'progreso2': _progresoController.text,
      'date_update': dateTime,
      'reason2': _reasonController.text,
      'costo': _costController.text,
      'descriptionService': _descriptionController.text,
      'status2': 'Aceptado',
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection('citas')
        .doc(widget._appointment.id)
        .set({
      'progreso2': _progresoController.text,
      'date_update': dateTime,
      'reason': _reasonController.text,
      'status2': 'Aceptado',
    }, SetOptions(merge: true));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrackingPageAD()),
    );
  }

  Future<void> _saveInfoRevision(DateTime dateTime) async {
    await FirebaseFirestore.instance
        .collection('citas')
        .doc(widget._appointment.id)
        .collection(
            'citasDiagnostico') // Agregar una subcolección 'citasDiagnostico' dentro del documento
        .doc(
            'Revision') // Puedes usar un ID único o el mismo ID del documento principal
        .set({
      'progreso2': _progresoController.text,
      'date_update': dateTime,
      'reason2': _reasonController.text,
      'costo': _costController.text,
      'descriptionService': _descriptionController.text,
      'status2': 'Diagnostico',
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection('citas')
        .doc(widget._appointment.id)
        .set({
      'progreso2': _progresoController.text,
      'date_update': dateTime,
      'reason2': _reasonController.text,
      'costo': _costController.text,
      'descriptionService': _descriptionController.text,
      'status2': 'Diagnostico',
    }, SetOptions(merge: true));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrackingPageAD()),
    );
  }

  Future<void> _saveInfoReparacion(DateTime dateTime) async {
    await FirebaseFirestore.instance
        .collection('citas')
        .doc(widget._appointment.id)
        .collection(
            'citasDiagnostico') // Agregar una subcolección 'citasDiagnostico' dentro del documento
        .doc(
            'Reparacion') // Puedes usar un ID único o el mismo ID del documento principal
        .set({
      'progreso2': _progresoController.text,
      'date_update': dateTime,
      'reason2': _reasonController.text,
      'costo': _costController.text,
      'descriptionService': _descriptionController.text,
      'status2': 'Reparacion',
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection('citas')
        .doc(widget._appointment.id)
        .set({
      'progreso': _progresoController.text,
      'date_update': dateTime,
      'reason': _reasonController.text,
      'status2': 'Reparacion',
    }, SetOptions(merge: true));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrackingPageAD()),
    );
  }

  Future<void> _saveInfoCompletado(DateTime dateTime) async {
    await FirebaseFirestore.instance
        .collection('citas')
        .doc(widget._appointment.id)
        .collection(
            'citasDiagnostico') // Agregar una subcolección 'citasDiagnostico' dentro del documento
        .doc(
            'Completado') // Puedes usar un ID único o el mismo ID del documento principal
        .set({
      'progreso2': _progresoController.text,
      'date_update': dateTime,
      'reason2': _reasonController.text,
      'costo': _costController.text,
      'descriptionService': _descriptionController.text,
      'status2': 'Completado',
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection('citas')
        .doc(widget._appointment.id)
        .set({
      'progreso': _progresoController.text,
      'date_update': dateTime,
      'reason': _reasonController.text,
      'status': 'Completado',
    }, SetOptions(merge: true));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrackingPageAD()),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool Diagnostico = false;
    if (widget._appointment.status2 == 'Diagnostico') {
      Diagnostico = true;
    } else {
      Diagnostico = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          //'Actualizar',
          widget._appointment.auto,
          style: const TextStyle(fontWeight: FontWeight.bold),
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
                        return 'Por favor, ingrese un estado';
                      }
                      return null;
                    },
                    controller: _progresoController,
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
                    controller: _reasonController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Diagnostico
                      ? Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const Text(
                                "¿Incluye Diagnóstico?",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Checkbox(
                                value:
                                    _includeDiagnostic, // Add a boolean variable to store the checkbox state
                                onChanged: (value) {
                                  setState(() {
                                    _includeDiagnostic = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 30,
                  ),
                  _includeDiagnostic
                      ? Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Automovil:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: widget._appointment.auto,
                                    hintStyle: const TextStyle(fontSize: 14)),
                                readOnly: true,
                                /*validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese un motivo';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _reason = value!,*/
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Reparacion:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: widget._appointment.motivo,
                                    hintStyle: const TextStyle(fontSize: 14)),
                                readOnly: true,
                                /*validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese un motivo';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _reason = value!,*/
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Descripcion:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Descripcion de la reparacion',
                                    hintStyle: TextStyle(fontSize: 14)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese un motivo';
                                  }
                                  return null;
                                },
                                controller: _descriptionController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Costo:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Costo de la reparacion MXN',
                                    hintStyle: TextStyle(fontSize: 14)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese un motivo';
                                  }
                                  return null;
                                },
                                controller: _costController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Imagenes adjuntas:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 115,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.green[400],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Agregar",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 50,
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
