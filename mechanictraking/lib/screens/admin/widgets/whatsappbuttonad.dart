import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WhatsappButtonAD extends StatelessWidget {
  const WhatsappButtonAD({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Expanded(
            flex: 6,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.whatsapp),
                  SizedBox(width: 10,),
                  Text("Iniciar chat con el Usuario"),
                ],
              ),
            ),
          ),
        ),
    );
  }
}