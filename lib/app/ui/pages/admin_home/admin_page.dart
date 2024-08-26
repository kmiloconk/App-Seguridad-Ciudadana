import 'package:app_prueba/app/services/firebase_service.dart';
import 'package:app_prueba/app/ui/pages/admin_home/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa url_launcher

class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    double lati = args['latitude']!;
    double long = args['longitude']!;
    String uid = args['uid'];
    CameraPosition cameraPossition =
        CameraPosition(target: LatLng(lati, long), zoom: 16);
    return ChangeNotifierProvider<AdminController>(
      create: (_) => AdminController(),
      child: WillPopScope(
        onWillPop: () async {
          _finishEmergenci(context, uid);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text('Mapp', style: TextStyle(color: Colors.white)),
            automaticallyImplyLeading: false,
          ),
          body: Selector<AdminController, bool>(
            selector: (_, controller) => controller.loading,
            builder: (context, loading, loadingWidget) {
              if (loading) {
                return loadingWidget!;
              }
              return Consumer<AdminController>(
                builder: (_, controller, gpsMessageWidget) {
                  if (!controller.gspEnable) {
                    return gpsMessageWidget!;
                  }
                  return Stack(
                    children: [
                      GoogleMap(
                        onMapCreated: (GoogleMapController mapController) {
                          controller.onMapCreated(
                              mapController, cameraPossition);
                        },
                        initialCameraPosition: cameraPossition,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        markers: controller.markers,
                        zoomControlsEnabled: false,
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: ElevatedButton(
                          onPressed: () {
                            _openGoogleMaps(lati, long);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.blue,
                            backgroundColor: Colors.white,
                          ),
                          child: const Text('Navegación'),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              _finishEmergenci(context, uid);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Terminar emergencia'),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Debe activar el gps',
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final controller = context.read<AdminController>();
                          controller.turnOnGPS();
                        },
                        child: const Text('Prender GPS'),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }

  void _finishEmergenci(BuildContext context, String uid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terminar'),
        content:
            const Text('Estas seguro que quieres terminar esta emergencia?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteEmergenci(uid);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _openGoogleMaps(double lati, double long) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$lati,$long&travelmode=driving';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open Google Maps';
    }
  }
}
