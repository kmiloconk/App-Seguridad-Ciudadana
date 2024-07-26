import 'dart:async';

import 'package:app_prueba/app/services/firebase_service.dart';
import 'package:app_prueba/app/ui/utils/map_style.dart';
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends ChangeNotifier {
  GoogleMapController? _mapController;

  @override
  void dispose() {
    _gpsSubscirption?.cancel();
    super.dispose();
  }

  HomeController() {
    _init();
  }

  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  bool cameraInit = true;
  late CameraPosition cameraPossition;

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.setMapStyle(mapStyle);
  }

  Future<void> turnOnGPS() => Geolocator.openLocationSettings();

  void onTap(LatLng position) {
    final markerId = MarkerId(_markers.length.toString());

    final marker = Marker(
        markerId: markerId,
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(200),
        draggable: true);

    _markers[markerId] = marker;
    notifyListeners();
  }

  bool _loading = true;
  bool get loading => _loading;

  late bool _gpsEnable;
  bool get gspEnable => _gpsEnable;

  StreamSubscription? _gpsSubscirption;

  Future<void> _init() async {
    _gpsEnable = await Geolocator.isLocationServiceEnabled();
    _loading = false;
    _gpsSubscirption =
        Geolocator.getServiceStatusStream().listen((status) async {
      _gpsEnable = status == ServiceStatus.enabled;
      notifyListeners();
    });
    if (cameraInit) {
      cameraPossition = const CameraPosition(
          target: LatLng(-36.8353143, -73.0540391), zoom: 12);
      cameraInit = false;
    }

    notifyListeners();
  }

  void newCameraposition() async {
    Position userPosition = await Geolocator.getCurrentPosition();
    cameraPossition = CameraPosition(
        target: LatLng(userPosition.latitude, userPosition.longitude),
        zoom: 16);

    final markerId = MarkerId('user_position');
    final marker = Marker(
      markerId: markerId,
      position: LatLng(userPosition.latitude, userPosition.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(200),
    );

    _markers[markerId] = marker;
    _mapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPossition));
    notifyListeners();
  }

  void sendData(String name, String lastname, String message) async {
    Position userPosition = await Geolocator.getCurrentPosition();
    await addEmergenci(
        name, lastname, message, userPosition.latitude, userPosition.longitude);
  }
}
