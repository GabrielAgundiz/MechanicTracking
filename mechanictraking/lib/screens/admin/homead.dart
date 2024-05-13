import 'package:flutter/material.dart';
import 'package:mechanictracking/screens/admin/messagesad.dart';
import 'package:mechanictracking/screens/admin/schedulead.dart';
import 'package:mechanictracking/screens/admin/trackingad.dart';

class HomePageAD extends StatefulWidget {
  const HomePageAD({Key? key}) : super(key: key);

  @override
  _HomePageADState createState() => _HomePageADState();
}

class _HomePageADState extends State<HomePageAD> {
  int selectedIndex = 0;

  Color selectedColor = Colors.green[400] ?? Colors.green;
  Color unselectedColor = Colors.grey[600] ?? Colors.grey;

  final screens = [
    SchedulePageAD(),
    TrackingPageAD(),
    MessagesPageAD(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 10,
        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,
        backgroundColor: Colors.white.withOpacity(1),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Citas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste_search),
            label: 'Seguimiento',
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
