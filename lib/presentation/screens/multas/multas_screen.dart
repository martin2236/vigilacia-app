


import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:securion/domain/entities/infraccion_entitie.dart';
import 'package:securion/presentation/bloc/permissions_cubit/permissions_cubit.dart';
import 'package:securion/presentation/screens/multas/imagen_multa_screen.dart';

import '../../../config/plugins/camera_plugin.dart';
import '../../../config/router/router.dart';
import '../../bloc/data_cubit.dart';
import '../../widgets/inputs/custom_text_form_field.dart';

int _toSecondsSinceEpoch(dynamic dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
   Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 
    return await Geolocator.getCurrentPosition();
  }

class MultasScreen extends StatefulWidget {
  const MultasScreen({super.key});

  @override
  State<MultasScreen> createState() => _MultasScreenState();
}

class  _MultasScreenState extends State<MultasScreen> {

  //datos del producto
  String? nombre;
  String? observaciones;
  String? dni;
  String? dominio;
  String? tipoPersona;
  String? lote;
  bool cargando = false;
  late String? imagepath1 = null;
  late String? imagepath2 = null;
  late String? imagepath3 = null;
  

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final text = Theme.of(context).textTheme;
   

    void _showImageDialog(BuildContext context, int image) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            FilledButton.icon(icon:const Icon(Icons.camera_alt_rounded),onPressed: ()async{
              Navigator.pop(context);
             final path =  await CameraPlugin().takePhoto();
              switch (image) {
                case 1:
                  setState(() {
                    imagepath1 = path;
                  });
                  break;
                  case 2:
                  setState(() {
                    imagepath2 = path;
                  });
                  break;
                  case 3:
                  setState(() {
                    imagepath3 = path;
                  });
                  break;
                default:
              }
            }, label: const Text('Tomar foto')),
            FilledButton.icon(
              icon: const Icon(Icons.image_search),
              onPressed: (){
                Navigator.pop(context);
                CameraPlugin().selectPhoto();
              }, 
              label: const Text('Abrir galería')
              ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    ),
  );
}


    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Multa'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding:const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
          Form(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.03),
                  
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:Row(  
                    children: [
                      GestureDetector(
                    onTap: () => _showImageDialog(context,1),
                    child: DottedBorder(
                       dashPattern: const [9, 9, 9, 9],
                       color: Colors.blue.shade800,
                       strokeWidth: 2,
                      child:imagepath1 != null ?  
                      Image(image: FileImage(File(imagepath1!)),
                      height: size.width * 0.55,
                      width: size.width * 0.44,
                      ) 
                      :  
                      Container(
                        height: size.width * 0.55,
                        width: size.width * 0.44,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.image_rounded,size: size.height * 0.05, color: Colors.blue.shade800,),
                            Text('Toca para agregar imagen', style:text.titleSmall!.copyWith(color: Colors.blue.shade800,),textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03,),
                  GestureDetector(
                    onTap: () => _showImageDialog(context,2),
                    child: DottedBorder(
                       dashPattern: const [9, 9, 9, 9],
                       color: Colors.blue.shade800,
                       strokeWidth: 2,
                      child:imagepath2 != null ?  
                      Image(image: FileImage(File(imagepath2!)),
                      height: size.width * 0.55,
                      width: size.width * 0.44,
                      ) 
                      :  
                      Container(
                        height: size.width * 0.55,
                        width: size.width * 0.44,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.image_rounded,size: size.height * 0.05, color: Colors.blue.shade800,),
                            Text('Toca para agregar imagen', style:text.titleSmall!.copyWith(color: Colors.blue.shade800,),textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  ],
                  )
                ),
                  SizedBox(height: size.height * 0.03),
                   SizedBox(
                  height: 80,
                  width: size.width,
                   child: CustomTextFormField(
                    onChanged: (value){
                      setState(() {
                        nombre = value;
                      });
                    },
                    hint: 'NOMBRE',
                    alignText: true,
                   ),
                 ),
                     SizedBox(
                  height: 130,
                  width: size.width,
                   child: CustomTextFormField(
                    onChanged: (value){
                      setState(() {
                        observaciones = value;
                      });
                    },
                    hint: 'OBSERVACIONES',
                    maxLines: 3,
                    alignText: true,
                   ),
                 ),
                
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 80,
                      width: size.width * 0.45,
                      child: CustomTextFormField(
                        onChanged: (value){  
                          setState(() {
                          dni = value.toString();
                        });
                        },
                        hint: 'DNI',
                        alignText: true,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                      
                     SizedBox(
                      height: 80,
                      width: size.width * 0.45,
                      child: CustomTextFormField(
                        onChanged: (value){  
                          setState(() {
                          dominio = value.toString();
                        });
                        },
                        hint: 'DOMINIO',
                        alignText: true,
                      ),
                    ),
                    
                  ],
                 ),
                 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 80,
                      width: size.width * 0.45,
                      child: CustomTextFormField(
                        onChanged: (value){  
                          setState(() {
                          tipoPersona = value.toString();
                        });
                        },
                        hint: 'TIPO PERSONA',
                        alignText: true,
                      ),
                    ),
                      
                     SizedBox(
                      height: 80,
                      width: size.width * 0.45,
                      child: CustomTextFormField(
                        onChanged: (value){  
                          setState(() {
                          lote = value.toString();
                        });
                        },
                        hint: 'LOTE',
                        alignText: true,
                      ),
                    ),
                    
                  ],
                 ),
                  
                SizedBox(
                  height: 50,
                  width: size.width,
                   child:
                   cargando ? CircularProgressIndicator() : FilledButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue.shade800,)
                    ) ,
                    onPressed: () async {
  try {
    setState(() {
      cargando = true;
    });

    final datacubit = context.read<DataCubit>();
    int fecha = _toSecondsSinceEpoch(DateTime.now());

    final position = await _determinePosition();
    print('🌍 Ubicación obtenida: ${position.latitude}, ${position.longitude}');

    final infraccion = Infraccion(
      nombre: nombre ?? '',
      observaciones: observaciones ?? '',
      dni: dni ?? '',
      dominio: dominio ?? '',
      tipopersona: tipoPersona ?? '',
      lote: lote ?? '',
      latitud: position.latitude.toString(),
      longitud: position.longitude.toString(),
      imagen1: imagepath1 ?? '',
      imagen2: imagepath2 ?? '',
      imagen3: imagepath3 ?? '',
      updatedAt: fecha.toString(),
      deletedAt: null,
    );

    print('📋 Multa generada: $infraccion');

    final (response, mensaje) = await datacubit.generarMulta(infraccion);

    print('✅ Respuesta de la multa: $response, Mensaje: $mensaje');

    setState(() {
      cargando = false;
    });

    if (response == true) {
      print('🔄 Navegando a ImagenMultaScreen');
      Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ImagenMultaScreen(fecha: DateTime.now().toLocal().toString().split(' ')[0], hora: TimeOfDay.now().format(context), nombre: nombre ?? '', dominio: dominio ?? '', observaciones: observaciones ?? '', lat: position.latitude, lng: position.longitude, imagenFrontal: imagepath1 ?? '', imagenLateral: imagepath2 ?? ''
))
      );
    
    } else {
      print('⚠ No se pudo generar la multa.');
    }
  } catch (e, stack) {
    print('❌ Error al generar la multa: $e');
    print(stack);
  }
},

                    
                    icon: Icon(Icons.add_circle, size:size.height * 0.035,),
                    label:  Text('Generar multa',style:text.titleLarge!.copyWith(color:Colors.white))
                    ),
                 ),
                
              ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}





