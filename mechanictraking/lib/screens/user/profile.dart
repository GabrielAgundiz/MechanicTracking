import 'package:flutter/material.dart';
import 'dart:io'; // Importación de la biblioteca para operaciones de entrada/salida
import 'package:firebase_auth/firebase_auth.dart'; // Importación de la biblioteca de autenticación de Firebase
import 'package:cloud_firestore/cloud_firestore.dart'; // Importación de la biblioteca Firestore de Firebase
import 'package:mechanictracking/screens/user/home.dart';
import 'package:mechanictracking/screens/user/notifies.dart'; // Importación de la pantalla de notificaciones
import 'package:image_picker/image_picker.dart'; // Importación de la biblioteca para seleccionar imágenes desde el dispositivo

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>(); // Clave global para el formulario
  String? _name; // Variable para almacenar el nombre del usuario
  String? _description; // Variable para almacenar la descripción del usuario
  String? _address; // Variable para almacenar la dirección del usuario
  String? _photoUrl; // Variable para almacenar la URL de la foto del usuario
  bool _notifications =
      false; // Variable para controlar la configuración de notificaciones
  bool _news = false; // Variable para controlar la configuración de noticias

  final picker =
      ImagePicker(); // Instancia de la clase ImagePicker para seleccionar imágenes

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth
        .instance.currentUser; // Obtiene el usuario actualmente autenticado
    final client = FirebaseFirestore
        .instance // Obtiene la colección 'client' de Firestore
        .collection('client')
        .doc(user
            ?.uid) // Obtiene el documento asociado al UID del usuario actual
        .snapshots(); // Crea un flujo de instantáneas de datos del documento

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage()), // Navega a la página de registro.
            );
          },
        ),
        title: const Text(
            'Perfil', style: TextStyle(fontWeight: FontWeight.bold),), // Título de la barra de la aplicación, que muestra "Perfil"
        actions: <Widget>[
          // Lista de acciones en la barra de la aplicación
          IconButton(
            // Botón de icono
            icon: const Icon(Icons.notifications), // Icono de notificaciones
            onPressed: () {
              // Acción cuando se presiona el botón de notificaciones
              Navigator.push(
                // Navega a la página de notificaciones (NotifiesPage)
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NotifiesPage()), // Crea una ruta para la página de notificaciones
              );
            },
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream:
            client, // Utiliza el flujo de instantáneas del documento del usuario
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(); // Muestra un indicador de progreso si no hay datos disponibles
          }

          final clientData = snapshot.data!
              .data(); // Obtiene los datos del documento del usuario

          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 75,
                          backgroundImage: _photoUrl != null
                              ? FileImage(File(
                                  _photoUrl!)) // Si hay una URL de foto, carga la foto desde el archivo
                              : const AssetImage(
                                      'assets/images/profile_picture.png')
                                  as ImageProvider, // De lo contrario, carga una imagen de perfil predeterminada
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
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
                          child: Text('Seleccionar foto'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: clientData?[
                              'name'], // Establece el valor inicial del campo con el nombre del cliente
                          decoration: const InputDecoration(
                              labelText:
                                  'Nombre'), // Etiqueta del campo de entrada de texto
                          validator: (value) {
                            // Función de validación que verifica si se ingresó un nombre válido
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu nombre';
                            }
                            return null; // Retorna nulo si el nombre es válido
                          },
                          onSaved: (value) => _name =
                              value, // Guarda el valor ingresado en la variable _name
                        ),
                        const SizedBox(height: 8), // Espacio vertical
                        Text(
                          user?.email ??
                              'Correo', // Muestra el correo electrónico del usuario actual
                        ),

                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: clientData?[
                              'description'], // Establece el valor inicial del campo con la descripción del cliente
                          decoration: const InputDecoration(
                              labelText:
                                  'Descripción'), // Etiqueta del campo de entrada de texto
                          validator: (value) {
                            // Función de validación que verifica si se ingresó una descripción válida
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa una descripción';
                            }
                            return null; // Retorna nulo si la descripción es válida
                          },
                          onSaved: (value) => _description =
                              value, // Guarda el valor ingresado en la variable _description
                        ),
                        const SizedBox(height: 16), // Espacio vertical
                        TextFormField(
                          initialValue: clientData?[
                              'address'], // Establece el valor inicial del campo con la dirección del cliente
                          decoration: const InputDecoration(
                              labelText:
                                  'Dirección'), // Etiqueta del campo de entrada de texto
                          validator: (value) {
                            // Función de validación que verifica si se ingresó una dirección válida
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu dirección';
                            }
                            return null; // Retorna nulo si la dirección es válida
                          },
                          onSaved: (value) => _address =
                              value, // Guarda el valor ingresado en la variable _address
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text(
                              'Notificaciones'), // Título del interruptor para las notificaciones
                          value:
                              _notifications, // Valor actual del interruptor (activado o desactivado)
                          onChanged: (value) {
                            // Función que se ejecuta cuando el usuario cambia el estado del interruptor
                            setState(() {
                              // Establece el estado con el nuevo valor del interruptor
                              _notifications = value;
                            });
                          },
                          activeTrackColor: Colors.green.withAlpha(
                              50), // Color de la pista del interruptor cuando está activado
                          activeColor: Colors
                              .green, // Color del botón del interruptor cuando está activado
                        ),
                        SwitchListTile(
                          title: const Text(
                              'Noticias'), // Título del interruptor para las noticias
                          value:
                              _news, // Valor actual del interruptor (activado o desactivado)
                          onChanged: (value) {
                            // Función que se ejecuta cuando el usuario cambia el estado del interruptor
                            setState(() {
                              // Establece el estado con el nuevo valor del interruptor
                              _news = value;
                            });
                          },
                          activeTrackColor: Colors.green.withAlpha(
                              50), // Color de la pista del interruptor cuando está activado
                          activeColor: Colors
                              .green, // Color del botón del interruptor cuando está activado
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            // Función que se ejecuta cuando se presiona el botón
                            if (_formKey.currentState!.validate()) {
                              // Verifica si el formulario es válido
                              _formKey.currentState!
                                  .save(); // Guarda los valores del formulario

                              try {
                                // Actualiza los datos del usuario en la base de datos
                                await FirebaseFirestore.instance
                                    .collection('client')
                                    .doc(user?.uid)
                                    .update({
                                  'name': _name,
                                  'description': _description,
                                  'address': _address,
                                  'photo': _photoUrl,
                                  'notifications': _notifications,
                                  'news': _news,
                                });

                                // Muestra un mensaje de éxito al guardar los datos
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Los datos se han guardado'),
                                  ),
                                );
                              } catch (e) {
                                // Muestra un mensaje de error si ocurre un problema al guardar los datos
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Error al guardar los datos'),
                                  ),
                                );
                              }
                            }
                          },
                          child:
                             Text('Guardar cambios'), // Texto del botón
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.green, // Color de fondo del botón
                            foregroundColor:
                                Colors.white, // Color del texto del botón
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
