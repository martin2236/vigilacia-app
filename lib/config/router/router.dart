
import 'package:go_router/go_router.dart';
import 'package:securion/presentation/screens/mascotas/mascotas_screen.dart';
import 'package:securion/presentation/screens/multas/imagen_multa_screen.dart';
import 'package:securion/presentation/screens/multas/multa_main_screen.dart';
import 'package:securion/presentation/screens/multas/multas_screen.dart';
import 'package:securion/presentation/screens/vehiculos/vehiculos_screen.dart';

import '../../presentation/screens/herramientas/herramienta_screen.dart';
import '../../presentation/screens/home_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/herramientas',
      builder: (context, state) => const HerramientasScreen() ,
      routes: [
         GoRoute(
          path: '/nuevaherramienta',
          builder: (context, state) => const  HerramientasScreen(),
        ),
      ]
    ),
    GoRoute(
      path: '/mascotas',
      builder: (context, state) => const MascotasScreen(),
      routes: [
        GoRoute(
          path: '/nuevamascota',
          builder: (context, state) => const  MascotasScreen(),
        ),
      ]
    ),
    GoRoute(
      path: '/vehiculos',
      builder: (context, state) => const VehiculosScreen(),
      routes: [
        GoRoute(
          path: '/nuevovehiculo',
          builder: (context, state) => const  VehiculosScreen(),
        ),
      ]
    ),
    GoRoute(
      path: '/multas', 
      builder: (context, state) => const  MultaMainScreen(),
      routes: [
        GoRoute(
          path: '/nuevamulta',
          builder: (context, state) => const  MultasScreen(),
          routes: [
            GoRoute(
            path: '/imagenmulta',
            builder: (context, state) => const  ImagenMultaScreen(fecha: '', hora: '', nombre: '', dominio: '', observaciones: '', lat: 0, lng: 0, imagenFrontal: '', imagenLateral: '',),
          ),
          ]
        ),
      ]
    ),
  ],
);