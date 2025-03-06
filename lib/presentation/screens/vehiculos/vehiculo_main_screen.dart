import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VehiculoMainScreen extends StatelessWidget {
  const VehiculoMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('multas'),
      ),
      body: Column(
        children: [
          Text('vehiculo')
        ],
      ),
    );
  }
}