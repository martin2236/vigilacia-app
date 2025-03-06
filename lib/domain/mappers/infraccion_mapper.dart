import 'package:securion/domain/models/infraccion-model.dart';

import '../entities/infraccion_entitie.dart';

class InfraccionMapper {
  static Infraccion infraccionAEntidad(InfraccionDb infraccionDb) {
    return Infraccion(
      id: infraccionDb.id,
      nombre: infraccionDb.nombre,
      observaciones: infraccionDb.observaciones,
      dni: infraccionDb.dni,
      dominio: infraccionDb.dominio,
      tipopersona: infraccionDb.tipopersona,
      lote: infraccionDb.lote,
      latitud: infraccionDb.latitud,
      longitud: infraccionDb.longitud,
      imagen1: infraccionDb.imagen1,
      imagen2: infraccionDb.imagen2,
      imagen3: infraccionDb.imagen3,
      updatedAt: infraccionDb.updatedAt,
      deletedAt: infraccionDb.deletedAt,
    );
  }
}