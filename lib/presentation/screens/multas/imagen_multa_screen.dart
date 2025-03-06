import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ImagenMultaScreen extends StatefulWidget {
  final String fecha;
  final String hora;
  final String nombre;
  final String dominio;
  final String observaciones;
  final double lat;
  final double lng;
  final String imagenFrontal;
  final String imagenLateral;

  const ImagenMultaScreen({
    Key? key,
    required this.fecha,
    required this.hora,
    required this.nombre,
    required this.dominio,
    required this.observaciones,
    required this.lat,
    required this.lng,
    required this.imagenFrontal,
    required this.imagenLateral,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImagenMultaScreenState createState() => _ImagenMultaScreenState();
}

class _ImagenMultaScreenState extends State<ImagenMultaScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> _guardarCaptura() async {
    final Uint8List? image = await screenshotController.capture();
    if (image == null) return;

    final directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/infraccion.png';
    final File file = File(filePath);
    await file.writeAsBytes(image);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Captura guardada en: $filePath")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        appBar: AppBar(title: const Text("Infracción Generada")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Colors.greenAccent,
                padding: const EdgeInsets.all(10),
                child: const Text("Aviso de infracción",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              
              Text("Fecha: ${widget.fecha}    Hora: ${widget.hora}",                    
                  style: const TextStyle(fontSize: 16)),
              Row(
                children: [Text("Nombre: ", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              Text("${widget.nombre}"),],
              ),
              Row(
                children: [
                      Text("Dominio: ", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              Text("${widget.dominio}"),
                ],
              ),
            
              const Text("Observaciones:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(widget.observaciones, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Image(image: FileImage(File(widget.imagenFrontal),),width: 150,),
                  
                  const SizedBox(width: 10),
                   Image(image: FileImage(File(widget.imagenLateral),),width: 150,),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(widget.lat, widget.lng),
                    zoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 40.0,
                          height: 40.0,
                          point: LatLng(widget.lat, widget.lng),
                          child:  const Icon(Icons.location_pin, size: 40, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _guardarCaptura,
                child: const Text("📸 Guardar Captura"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
