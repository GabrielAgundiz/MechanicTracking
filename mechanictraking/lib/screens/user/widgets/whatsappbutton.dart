import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappButton extends StatelessWidget {
  const WhatsappButton({super.key});

  void launchWhatsapp({required String number, required String message}) async {
    final String androidUrl = "whatsapp://send?phone=$number&text=$message";
    final Uri androidUri = Uri.parse(androidUrl);

    final String webUrl =
        "https://api.whatsapp.com/send/?phone=$number&text=$message";
    final Uri webUri = Uri.parse(webUrl);

    if (await canLaunchUrl(androidUri)) {
      await launchUrl(androidUri);
    } else {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            launchWhatsapp(number: '8121912748', message: "Hola");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.whatsapp),
              SizedBox(width: 10),
              Text("Iniciar chat con el Taller"),
            ],
          ),
        ),
      ),
    );
  }
}
