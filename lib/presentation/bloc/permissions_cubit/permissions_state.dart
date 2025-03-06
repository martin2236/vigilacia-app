part of 'permissions_cubit.dart';


 class PermissionsState extends Equatable {
  final PermissionStatus camera;
  final PermissionStatus photolibrary;
  final PermissionStatus sensors;
  final PermissionStatus storage;
  final PermissionStatus sensorsAlways;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

 const PermissionsState({
    this.camera = PermissionStatus.denied,
    this.photolibrary = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.storage = PermissionStatus.denied,
    this.sensorsAlways = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.locationWhenInUse = PermissionStatus.denied,
  });

  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photolibrary,
    PermissionStatus? sensors,
    PermissionStatus? storage,
    PermissionStatus? sensorsAlways,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) {
    return PermissionsState(
      camera: camera ?? this.camera,
      photolibrary: photolibrary ?? this.photolibrary,
      sensors: sensors ?? this.sensors,
      storage: storage ?? this.storage,
      sensorsAlways: sensorsAlways ?? this.sensorsAlways,
      location: location ?? this.location,
      locationAlways: locationAlways ?? this.locationAlways,
      locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
    );
  }
  @override
  List<Object?> get props => [camera, photolibrary,sensors,storage,sensorsAlways,location,locationAlways,locationWhenInUse];
 }


