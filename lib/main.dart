import 'package:flutter/material.dart';
import 'package:acme_airlines_pi/screens/login.dart';
import 'package:acme_airlines_pi/screens/principal.dart';

void main() {
  runApp(const Aplicativo());
}

class Aplicativo extends StatelessWidget {
  const Aplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const Login(),
        "principal/": (context) => const Principal(),
      },
    );
  }
}
