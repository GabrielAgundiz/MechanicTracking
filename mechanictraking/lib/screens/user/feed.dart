import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// Página de alimentación (Feed)
class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feed',
          style: TextStyle(fontWeight: FontWeight.bold),
        ), // Título de la barra de aplicación
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bienvenido",
                  style: TextStyle(
                    fontSize: 28, // Tamaño de fuente 28.
                    fontWeight: FontWeight.bold, // Fuente en negrita.
                    height:
                        1, // Altura del texto (1 significa la altura normal).
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
