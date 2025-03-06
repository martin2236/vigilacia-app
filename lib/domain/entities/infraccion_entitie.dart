

class Infraccion {
     final int? id;
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

    Infraccion({
       this.id,
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
        required this.deletedAt
    });
}