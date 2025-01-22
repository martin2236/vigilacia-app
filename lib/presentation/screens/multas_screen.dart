


import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../config/plugins/camera_plugin.dart';
import '../../config/router/router.dart';
import '../bloc/data_cubit.dart';
import '../widgets/inputs/custom_text_form_field.dart';

int _toSecondsSinceEpoch(dynamic dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
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
  late String? imagepath = null;
  

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final text = Theme.of(context).textTheme;
    final dataCubit = context.watch<DataCubit>();
    final razas = dataCubit.state.razas;

    void _showImageDialog(BuildContext context) {
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
              setState(() {
                imagepath = path;
              });
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
                  
                  GestureDetector(
                    onTap: () => _showImageDialog(context),
                    child: DottedBorder(
                       dashPattern: const [9, 9, 9, 9],
                       color: Colors.blue.shade800,
                       strokeWidth: 2,
                      child:imagepath != null ?  
                      Image(image: FileImage(File(imagepath!)),
                      height: size.width * 0.5,
                      width: size.width * 0.9,
                      ) 
                      :  
                      Container(
                        height: size.width * 0.5,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.image_rounded,size: size.height * 0.05, color: Colors.blue.shade800,),
                            Text('Toca para agregar imagen', style:text.titleSmall!.copyWith(color: Colors.blue.shade800,),)
                          ],
                        ),
                      ),
                    ),
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
                    keyboardType: TextInputType.number,
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
                    keyboardType: TextInputType.number,
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
                        keyboardType: TextInputType.number,
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
                        keyboardType: TextInputType.number,
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
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    
                  ],
                 ),
                  
                SizedBox(
                  height: 50,
                  width: size.width,
                   child:FilledButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue.shade800,)
                    ) ,
                    onPressed: (){
                      int fecha = _toSecondsSinceEpoch(DateTime.now());
                     
        
                     
                      router.pop();
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





