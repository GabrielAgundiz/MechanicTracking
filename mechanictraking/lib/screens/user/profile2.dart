import 'package:flutter/material.dart';
import 'package:mechanictracking/screens/user/home.dart';
import 'package:mechanictracking/screens/user/notifies.dart';
import 'package:mechanictracking/screens/user/widgets/circularimage.dart';
import 'package:mechanictracking/screens/user/widgets/profiledata.dart';
import 'package:mechanictracking/screens/user/widgets/sectionheading.dart';

class ProfilePage2 extends StatelessWidget {
  const ProfilePage2({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Perfil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ), // Título de la barra de la aplicación, que muestra "Perfil"
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              24,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircularImage(
                        image:
                            "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745",
                        width: 140,
                        height: 140,
                      ),
                      TextButton(
                        onPressed: () {},
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
                ProfileData(title: 'Nombre', value: 'Gabriel Agundiz', onPressed: (){}),
                ProfileData(title: 'User ID', value: '45123213', icon: Icons.copy, onPressed: (){}),
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
                ProfileData(title: 'E-mail:', value: 'usuario@gmail.com', onPressed: (){}),
                ProfileData(title: 'Telefono', value: '810000000', onPressed: (){}),
                ProfileData(title: 'Direccion', value: 'Monterrey #345, N.L.', onPressed: (){}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

