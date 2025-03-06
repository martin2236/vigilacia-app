
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:securion/domain/entities/infraccion_entitie.dart';
import 'package:securion/domain/entities/raza_entitie.dart';
import 'package:securion/domain/entities/vehiculo_entitie.dart';
import 'package:securion/domain/mappers/mappers.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/models.dart';

part 'data_cubit_state.dart';

class DataCubit extends Cubit<DataCubitState>{
  final Database db;
  DataCubit({required this.db}) : super(const DataCubitState());

   Future<(bool,String)> traerMultas() async {
    print('Traer multas');
  try {
    final List<Map<String, dynamic>> jsonDataList = await db.query(
      'infracciones',
      where: 'deleted_at IS NULL', // Filtrar productos donde deleted_at sea NULL
    );
  
     final List<InfraccionDb> infraccionDbList = jsonDataList.map((map) => InfraccionDb.fromJson(map)).toList();
      final List<Infraccion> infracciones = infraccionDbList.map((infraccionDb) => InfraccionMapper.infraccionAEntidad(infraccionDb)).toList();
      print(infracciones);
      emit(state.copyWith(infracciones: infracciones));
    return(true,'multas cargadas');
  } catch (e) {
    return(false,'Error al traer productos: $e');
  }
} 


Future<(bool, String)> generarMulta(Infraccion infraccion) async {
  final db = await openDatabase('securion_app.db');

  try {
    await db.rawInsert(
      '''
      INSERT INTO infracciones (
        nombre, 
        observaciones, 
        dni, 
        dominio, 
        tipopersona, 
        lote, 
        latitud, 
        longitud, 
        imagen1, 
        imagen2,
        imagen3,
        updated_at
      ) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''',
      [
        infraccion.nombre,
        infraccion.observaciones,
        infraccion.dni,
        infraccion.dominio,
        infraccion.tipopersona,
        infraccion.lote,
        infraccion.latitud,
        infraccion.longitud,
        infraccion.imagen1,
        infraccion.imagen2,
        infraccion.imagen3,
        DateTime.now().millisecondsSinceEpoch,
      ],
    );
    return (true, 'Producto creado con éxito');
  } catch (e) {
    print('Error al insertar producto: $e');
    return (false, 'Error al insertar el producto');
  }
}
  
}