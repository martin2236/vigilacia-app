
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:securion/domain/entities/raza_entitie.dart';
import 'package:securion/domain/entities/vehiculo_entitie.dart';

part 'data_cubit_state.dart';

class DataCubit extends Cubit<DataCubitState>{

  DataCubit() : super(const DataCubitState());

}