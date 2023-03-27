import 'package:flutter/material.dart';

class DetallesScreen extends StatelessWidget {
  const DetallesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'detalles',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
