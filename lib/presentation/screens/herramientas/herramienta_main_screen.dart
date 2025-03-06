import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HerramientasMainScreen extends StatelessWidget {
  const HerramientasMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('herramientas'),
      ),
      body: Column(
        children: [
          Text('multas')
        ],
      ),
    );
  }
}