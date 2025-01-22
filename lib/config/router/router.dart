
import 'package:go_router/go_router.dart';
import 'package:securion/presentation/screens/mascotas_screen.dart';
import 'package:securion/presentation/screens/multas_screen.dart';
import 'package:securion/presentation/screens/vehiculos_screen.dart';

import '../../presentation/screens/herramientas_screen.dart';
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
    ),
    GoRoute(
      path: '/mascotas',
      builder: (context, state) => const MascotasScreen(),
    ),
    GoRoute(
      path: '/vehiculos',
      builder: (context, state) => const VehiculosScreen(),
    ),
    GoRoute(
      path: '/multas',
      builder: (context, state) => const MultasScreen(),
    ),
  ],
);