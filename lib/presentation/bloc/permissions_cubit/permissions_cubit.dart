import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';


part 'permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
    bool _isRequestingPermissions = false;
  PermissionsCubit() : super(const PermissionsState());
  
    Future<void> checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.sensorsAlways.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);
    emit(state.copyWith(
      camera: permissionsArray[0],
      photolibrary: permissionsArray[1],
      sensors: permissionsArray[2],
      sensorsAlways: permissionsArray[3],
      location: permissionsArray[4],
      locationAlways: permissionsArray[5],
      locationWhenInUse: permissionsArray[6],
    ));
  }

  void openSettingsScreen() {
    openAppSettings();
  }

  void _checkPermissionsStatus(PermissionStatus status) {
    if (status == PermissionStatus.permanentlyDenied) {
      openSettingsScreen();
    }
  }

  Future<void> requestCameraAccess() async {
    final status = await Permission.camera.request();
    emit(state.copyWith(camera: status));
    _checkPermissionsStatus(status);
  }

  Future<void> requestPhotoLibraryAccess() async {
    if (_isRequestingPermissions) {
      return;
    }
    _isRequestingPermissions = true;

    try {
      if (Platform.isAndroid) {
        final androidVersion = await getAndroidVersion();
        if (androidVersion != null) {
          if (androidVersion >= 34) { // UPSIDE_DOWN_CAKE
            await [
              Permission.photos,
              Permission.videos,
              Permission.mediaLibrary
            ].request();
          } else if (androidVersion >= 33) { // TIRAMISU
            await [
              Permission.photos,
              Permission.videos
            ].request();
          } else { // android <= 12
            await Permission.storage.request();
          }
        }
      } else if (Platform.isIOS) {
        await Permission.photos.request();
      }
    } finally {
      _isRequestingPermissions = false;
      if (Platform.isAndroid) {
        final androidVersion = await getAndroidVersion();
        if (androidVersion != null && androidVersion <= 32) {
          final status = await Permission.storage.status;
          emit(state.copyWith(photolibrary: status));
          _checkPermissionsStatus(status);
        } else {
          final status = await Permission.photos.status;
          emit(state.copyWith(photolibrary: status));
          _checkPermissionsStatus(status);
        }
      } else if (Platform.isIOS) {
        final status = await Permission.photos.status;
        emit(state.copyWith(photolibrary: status));
        _checkPermissionsStatus(status);
      }
    }
  }

  Future<int?> getAndroidVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt;
    }
    return null;
  }

  Future<void> requestStorageAccess() async {
  if (Platform.isAndroid) {
    final status = await Permission.storage.request();
    emit(state.copyWith(storage: status));
    _checkPermissionsStatus(status);
  }
}

  Future<void> requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    emit(state.copyWith(sensors: status));
    _checkPermissionsStatus(status);
  }

  Future<void> requestSensorsAlwaysAccess() async {
    final status = await Permission.sensorsAlways.request();
    emit(state.copyWith(sensorsAlways: status));
    _checkPermissionsStatus(status);
  }

  Future<void> requestLocationAccess() async {
    final status = await Permission.location.request();
    emit(state.copyWith(location: status));
    _checkPermissionsStatus(status);
  }

  Future<void> requestLocationWhenInUseAccess() async {
    final status = await Permission.locationWhenInUse.request();
    emit(state.copyWith(locationWhenInUse: status));
    _checkPermissionsStatus(status);
  }

  Future<void> requestLocationAlwaysAccess() async {
    final status = await Permission.locationAlways.request();
    emit(state.copyWith(locationAlways: status));
    _checkPermissionsStatus(status);
  }
}
