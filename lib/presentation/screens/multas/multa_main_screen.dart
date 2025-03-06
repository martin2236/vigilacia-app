import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:securion/presentation/bloc/data_cubit.dart';

import '../../../domain/entities/infraccion_entitie.dart';

class MultaMainScreen extends StatefulWidget {
  const MultaMainScreen({super.key});

  @override
  State<MultaMainScreen> createState() => _MultaMainScreenState();
  
}

class _MultaMainScreenState extends State<MultaMainScreen> {

  @override
  void initState() {
    super.initState();
    print('initState'	);
    final dataCubit = context.read<DataCubit>();
    dataCubit.traerMultas();

  }

  @override
  Widget build(BuildContext context) {
    final dataCubit = context.watch<DataCubit>();
    final infracciones = dataCubit.state.infracciones;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('multas'),
      ),
      floatingActionButton: IconButton.filledTonal(onPressed: (){context.go('/multas/nuevamulta');}, icon: const Icon(Icons.add)),
      body:
      infracciones.isEmpty ? const Center(child: Text('No hay multas'),) 
      :
       Column(
        children: [
          Text('multas generadas'),
          Expanded(
            child: ListView.builder(
              itemCount: infracciones.length,
              itemBuilder: (context, index)  =>  InfraccionCard(infraccion: infracciones[index]),
            ),
          )
        ],
      ),
    );
  }
}

class InfraccionCard extends StatelessWidget {
  final Infraccion infraccion;
  const InfraccionCard({super.key, required this.infraccion});
  
  @override
  Widget build(BuildContext context) {
    print('${infraccion.updatedAt}');
  DateTime date = DateTime.fromMillisecondsSinceEpoch(infraccion.updatedAt);
  
  String formattedDate = "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  


    return Container(
      color: Colors.white,
      height: 200,
      width: 100,
      child: Stack(
        children: [
          Image(image: FileImage(File(infraccion.imagen1))),
          Positioned(
            top: 20,
            child: 
            Text(infraccion.dominio, style: TextStyle( fontWeight: FontWeight.bold),
            )
            ),
          Positioned(
            top: 5,
            child: 
            Text(formattedDate, style: TextStyle( fontWeight: FontWeight.bold),
            )
            ),
        ],
      ),
    );
  }
}