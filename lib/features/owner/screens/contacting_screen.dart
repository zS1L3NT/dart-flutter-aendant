import 'package:flutter/material.dart';

class ContactingScreen extends StatelessWidget {
  const ContactingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Contacting Authorities and\nNext of Kin",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
