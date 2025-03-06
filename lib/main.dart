import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:securion/config/app_theme.dart';
import 'package:securion/config/connection/dbconnection.dart';
import 'package:securion/config/router/router.dart';
import 'package:sqflite/sqflite.dart';

import 'presentation/bloc/data_cubit.dart';
import 'presentation/bloc/permissions_cubit/permissions_cubit.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtener la ruta correcta de la base de datos
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'securion_app.db');

  // Inicializar la base de datos en la ruta correcta
  await DataBase.initializeDatabase();
  await GeolocatorPlatform.instance.checkPermission();

  // Abrir la base de datos usando la ruta correcta
  final Database db = await openDatabase(path);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DataCubit(db: db)),
        BlocProvider(create: (_) => PermissionsCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final permissionsCubit = context.read<PermissionsCubit>();

    // Solicitar permisos apenas se inicie la app
    WidgetsBinding.instance.addPostFrameCallback((_) {
      permissionsCubit.requestLocationAccess();
    });

    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}

