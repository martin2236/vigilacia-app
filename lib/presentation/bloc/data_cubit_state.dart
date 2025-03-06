part of 'data_cubit.dart';

class DataCubitState extends Equatable{
  final String? usuario;
  final List<Raza>? razas;
  final List<Vehiculo>? vehiculos;
  final List<Infraccion> infracciones;

  const DataCubitState({
    this.usuario,
    this.razas,
    this.vehiculos,
    this.infracciones = const []
  });

  DataCubitState copyWith({
    String? usuario,
    List<Raza>? razas,
    List<Vehiculo>? vehiculos,
    List<Infraccion>? infracciones
  }) => DataCubitState(
    usuario: usuario ?? this.usuario,
    razas: razas ?? this.razas,
    vehiculos: vehiculos ?? this.vehiculos,
    infracciones: infracciones ?? this.infracciones
  );
  @override
  List<Object?> get props => [usuario, razas, vehiculos, infracciones];

}