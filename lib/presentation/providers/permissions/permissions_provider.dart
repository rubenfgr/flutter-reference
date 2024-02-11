import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionProvider =
    StateNotifierProvider<PermissionNotifier, PermissionState>(
        (ref) => PermissionNotifier());

class PermissionNotifier extends StateNotifier<PermissionState> {
  PermissionNotifier() : super(PermissionState()) {
    checkPermissions();
  }

  Future<void> checkPermissions() {
    return Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status
    ]).then((statuses) {
      state = state.copyWith(
          camera: statuses[0],
          photoLibrary: statuses[1],
          sensors: statuses[2],
          location: statuses[3],
          locationAlways: statuses[4],
          locationWhenInUse: statuses[5]);
    });
  }

  Future<void> requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> requestPhotoLibraryAccess() async {
    final status = await Permission.mediaLibrary.request();
    state = state.copyWith(photoLibrary: status);

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> requestLocationAlwaysAccess() async {
    final status = await Permission.locationAlways.request();
    state = state.copyWith(locationAlways: status);

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> requestLocationWhenInUseAccess() async {
    final status = await Permission.locationWhenInUse.request();
    state = state.copyWith(locationWhenInUse: status);

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

class PermissionState {
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;

  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionState(
      {this.camera = PermissionStatus.denied,
      this.photoLibrary = PermissionStatus.denied,
      this.sensors = PermissionStatus.denied,
      this.location = PermissionStatus.denied,
      this.locationAlways = PermissionStatus.denied,
      this.locationWhenInUse = PermissionStatus.denied});

  get cameraGranted => camera == PermissionStatus.granted;
  get photoLibraryGranted => photoLibrary == PermissionStatus.granted;
  get sensorsGranted => sensors == PermissionStatus.granted;
  get locationGranted => location == PermissionStatus.granted;
  get locationAlwaysGranted => locationAlways == PermissionStatus.granted;
  get locationWhenInUseGranted => locationWhenInUse == PermissionStatus.granted;

  PermissionState copyWith(
      {PermissionStatus? camera,
      PermissionStatus? photoLibrary,
      PermissionStatus? sensors,
      PermissionStatus? location,
      PermissionStatus? locationAlways,
      PermissionStatus? locationWhenInUse}) {
    return PermissionState(
        camera: camera ?? this.camera,
        photoLibrary: photoLibrary ?? this.photoLibrary,
        sensors: sensors ?? this.sensors,
        location: location ?? this.location,
        locationAlways: locationAlways ?? this.locationAlways,
        locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse);
  }
}
