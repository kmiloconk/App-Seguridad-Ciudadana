import 'dart:async';

import 'package:app_prueba/app/ui/utils/map_style.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdminController extends ChangeNotifier {
  @override
  void dispose() {
    _gpsSubscirption?.cancel();
    super.dispose();
  }

  AdminController() {
    _init();
  }

  Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  void onMapCreated(
      GoogleMapController controller, CameraPosition initialPosition) {
    controller.setMapStyle(mapStyle);
    _addMarkerAtPosition(initialPosition.target);
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

    notifyListeners();
  }

  void updateMarkers(Set<Marker> markers) {
    _markers.clear();
    for (var marker in markers) {
      _markers[marker.markerId] = marker;
    }
    notifyListeners();
  }

  void _addMarkerAtPosition(LatLng position) {
    final markerId = MarkerId('camera_position');
    final marker = Marker(
      markerId: markerId,
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(200),
    );
    _markers[markerId] = marker;
    notifyListeners();
  }
}
