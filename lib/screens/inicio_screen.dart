import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'inicio',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
