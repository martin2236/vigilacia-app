part of 'data_cubit.dart';

class DataCubitState extends Equatable{
  final String? usuario;
  final List<Raza>? razas;
  final List<Vehiculo>? vehiculos;

  const DataCubitState({
    this.usuario,
    this.razas,
    this.vehiculos
  });

  DataCubitState copyWith({
    String? usuario,
    List<Raza>? razas,
    List<Vehiculo>? vehiculos,
  }) => DataCubitState(
    usuario: usuario ?? this.usuario,
    razas: razas ?? this.razas,
    vehiculos: vehiculos ?? this.vehiculos
  );
  @override
  List<Object?> get props => [usuario, razas, vehiculos];

}