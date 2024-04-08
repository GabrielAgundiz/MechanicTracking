import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechanictracking/screens/user/home.dart';
import 'package:mechanictracking/screens/user/notifies.dart';
import 'package:mechanictracking/screens/user/widgets/circularimage.dart';
import 'package:mechanictracking/screens/user/widgets/profiledata.dart';
import 'package:mechanictracking/screens/user/widgets/sectionheading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ProfilePage2 extends StatefulWidget {
  ProfilePage2({super.key});

  @override
  _ProfilePage2State createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
  String? _photoUrl;
  Map<String, dynamic>? _userData;
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final client = FirebaseFirestore.instance
        .collection('client')
        .doc(user?.uid)
        .snapshots();
    final picker = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: const Text(
          'Perfil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotifiesPage()),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              24,
            ),
            child: Column(
              children: [
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: client,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              CircularImage(
                                image: _userData?['image'] ??
                                    'https://static.vecteezy.com/system/resources/previews/019/879/198/non_2x/user-icon-on-transparent-background-free-png.png',
                                width: 140,
                                height: 140,
                              ),
                              TextButton(
                                onPressed: () async {
                                  final pickedFile = await picker.pickImage(
                                      source: ImageSource
                                          .gallery); // Permite al usuario seleccionar una foto de la galería
                                  if (pickedFile != null) {
                                    setState(() {
                                      _photoUrl = pickedFile
                                          .path; // Actualiza la URL de la foto seleccionada
                                    });
                                  }
                                },
                                child: const Text(
                                  'Cambiar foto de perfil',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 16,
                        ),
                        const SectionHeading(
                          title: "Informacion de Usuario",
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ProfileData(
                            title: 'Nombre',
                            value: _userData?['name'] ?? 'N/A',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  String? newName;
                                  return AlertDialog(
                                    title: const Text('Editar nombre'),
                                    content: TextField(
                                      onChanged: (value) {
                                        newName = value;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Nombre'),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (newName != _userData?['name']) {
                                            setState(() {
                                              _userData!['name'] = newName;
                                            });
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Guardar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                        ProfileData(
                            title: 'User ID',
                            value: _userData?['uid'] ?? 'N/A',
                            icon: Icons.copy,
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                  text: _userData?['uid'] ?? 'N/A'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Los datos se han copiado'),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 16,
                        ),
                        const SectionHeading(
                          title: "Informacion Personal",
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ProfileData(
                            title: 'E-mail:',
                            value: _userData?['email'] ?? 'N/A',
                            icon: Icons.copy,
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                  text: _userData?['email'] ?? 'N/A'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Los datos se han copiado'),
                                ),
                              );
                            }),
                        ProfileData(
                            title: 'Telefono',
                            value: _userData?['phone'] ?? 'N/A',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  String? newPhone;
                                  return AlertDialog(
                                    title: const Text('Editar telefono'),
                                    content: TextField(
                                      onChanged: (value) {
                                        newPhone = value;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Telefono'),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (newPhone != _userData?['phone']) {
                                            setState(() {
                                              _userData!['phone'] = newPhone;
                                            });
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Guardar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                        ProfileData(
                            title: 'Direccion',
                            value: _userData?['address'] ?? 'N/A',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  String? newAddress;
                                  return AlertDialog(
                                    title: const Text('Editar direccion'),
                                    content: TextField(
                                      onChanged: (value) {
                                        newAddress = value;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Direccion'),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (newAddress !=
                                              _userData?['address']) {
                                            setState(() {
                                              _userData!['address'] =
                                                  newAddress;
                                            });
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Guardar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
