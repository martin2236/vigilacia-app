

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:securion/config/router/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('registro'),
      ),
      body: Padding(
        padding:const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
        child: SizedBox(
          width: size.width,
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 30,
            runSpacing: 30,
            children: [
              GestureDetector(
                onTap: ()=> context.push('/mascotas'),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: size.width * 0.30,
                        width: size.width * 0.30,
                        color: Colors.blue.shade900,
                        child: 
                            Icon(Icons.pets, color: Colors.white,size: size.width * 0.25,),
                      ),
                    ),
                       Text('Mascotas',style: text.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
               GestureDetector(
                onTap: ()=> router.push('/vehiculos'),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: size.width * 0.30,
                        width: size.width * 0.30,
                        color: Colors.blue.shade900,
                        child: 
                            Icon(Icons.two_wheeler, color: Colors.white,size:size.width * 0.25,),
                      ),
                    ),
                       Text('Vehiculos',style: text.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
               GestureDetector(
                onTap: ()=> router.push('/herramientas'),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: size.width * 0.30,
                        width: size.width * 0.30,
                        color: Colors.blue.shade900,
                        child: 
                            Icon(Icons.construction, color: Colors.white,size: size.width * 0.25,),
                      ),
                    ),
                       Text('Herramientas',style: text.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
               GestureDetector(
                onTap: ()=> router.push('/multas'),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                       height: size.width * 0.30,
                        width: size.width * 0.30,
                        color: Colors.blue.shade900,
                        child: 
                            Icon(Icons.report, color: Colors.white,size:size.width * 0.25,),
                      ),
                    ),
                       Text('Multas',style: text.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
                  ],
                ),
              )
            ] 
          ),
        ),
      ),
    );
  }
}