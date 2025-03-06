// To parse this JSON data, do
//
//     final infraccionDb = infraccionDbFromJson(jsonString);

import 'dart:convert';

List<InfraccionDb> infraccionDbFromJson(String str) => List<InfraccionDb>.from(json.decode(str).map((x) => InfraccionDb.fromJson(x)));

String infraccionDbToJson(List<InfraccionDb> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfraccionDb {
    final int id;
    final String nombre;
    final String observaciones;
    final String dni;
    final String dominio;
    final String tipopersona;
    final String lote;
    final String latitud;
    final String longitud;
    final String imagen1;
    final String imagen2;
    final String imagen3;
    final dynamic updatedAt;
    final dynamic deletedAt;

    InfraccionDb({
        required this.id,
        required this.nombre,
        required this.observaciones,
        required this.dni,
        required this.dominio,
        required this.tipopersona,
        required this.lote,
        required this.latitud,
        required this.longitud,
        required this.imagen1,
        required this.imagen2,
        required this.imagen3,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory InfraccionDb.fromJson(Map<String, dynamic> json) => InfraccionDb(
        id: json["id"],
        nombre: json["nombre"],
        observaciones: json["observaciones"],
        dni: json["dni"],
        dominio: json["dominio"],
        tipopersona: json["tipopersona"],
        lote: json["lote"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        imagen1: json["imagen1"],
        imagen2: json["imagen2"],
        imagen3: json["imagen3"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "observaciones": observaciones,
        "dni": dni,
        "dominio": dominio,
        "tipopersona": tipopersona,
        "lote": lote,
        "latitud": latitud,
        "longitud": longitud,
        "imagen1": imagen1,
        "imagen2": imagen2,
        "imagen3": imagen3,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
    };
}
