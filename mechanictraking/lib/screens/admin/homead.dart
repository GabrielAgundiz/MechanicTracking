import 'package:flutter/material.dart';
import 'package:mechanictracking/screens/admin/messagesad.dart';
import 'package:mechanictracking/screens/admin/schedulead.dart';
import 'package:mechanictracking/screens/admin/trackingad.dart';

class HomePageAD extends StatefulWidget {
  const HomePageAD({super.key});

  @override
  _HomePageADState createState() => _HomePageADState();
}

class _HomePageADState extends State<HomePageAD> {
  int selectedIndex =
      0; // Índice del elemento seleccionado en la barra de navegación inferior

  @override
  Widget build(BuildContext context) {
    final screens = [
      SchedulePageAD(),
      TrackingPageAD(),
      MessagesPageAD(),
    ];

    Color selectedColor = Colors.green[
        400]!; // Color del elemento seleccionado en la barra de navegación inferior
    Color unselectedColor = Colors.grey[
        600]!; // Color del elemento no seleccionado en la barra de navegación inferior

    return Scaffold(
      // Crea una nueva instancia de la clase Scaffold
      body: IndexedStack(
        // Muestra una de las pantallas según el índice seleccionado
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Barra de navegación inferior
        currentIndex: selectedIndex, // Índice del elemento seleccionado
        onTap: (value) {
          // Llamado cuando se selecciona un elemento
          setState(() {
            selectedIndex = value; // Actualiza el índice seleccionado
          });
        },
        elevation: 10, // Sombra del elemento
        selectedItemColor: selectedColor, // Color del elemento seleccionado
        unselectedItemColor:
            unselectedColor, // Color del elemento no seleccionado
        backgroundColor: Colors.white
            .withOpacity(1), // Fondo de la barra de navegación inferior
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), // Icono del elemento
            label: 'Citas', // Etiqueta del elemento
          ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.content_paste_search), // Icono del elemento
                 label: 'Seguimiento', // Etiqueta del elemento
               ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensajes',
          ),
        ],
      ),
    );
  }
}
