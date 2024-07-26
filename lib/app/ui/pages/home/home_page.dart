import 'package:app_prueba/app/ui/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool active = false;

  @override
  void initState() {
    super.initState();
    active = false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('My App', style: TextStyle(color: Colors.white)),
          automaticallyImplyLeading: false,
        ),
        body: Selector<HomeController, bool>(
          selector: (_, controller) => controller.loading,
          builder: (context, loading, loadignWidget) {
            if (loading) {
              return loadignWidget!;
            }
            return Consumer<HomeController>(
              builder: (_, controller, gpsMessageWidget) {
                if (!controller.gspEnable) {
                  return gpsMessageWidget!;
                }
                return Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: controller.onMapCreated,
                      initialCameraPosition: controller.cameraPossition,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      markers: controller.markers,
                      zoomControlsEnabled: false,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          _emergenci(context, controller);
                        },
                        child: const Text('Emergencia'),
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
                        final controller = context.read<HomeController>();
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
    );
  }

  _emergenci(BuildContext context, HomeController controller) {
    if (active) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Advertencia'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Ya se ha realizado la emergencia, una patrulla va en camino'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                controller.newCameraposition();
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    } else {
      TextEditingController nameController = TextEditingController(text: "");
      TextEditingController lastnameController =
          TextEditingController(text: "");
      TextEditingController messageController = TextEditingController(text: "");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Emergencia'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ingrese sus datos para realizar la emergencia'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'Nombre'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: lastnameController,
                      decoration: const InputDecoration(hintText: 'Apellido'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: messageController,
                decoration: const InputDecoration(hintText: 'Mensaje'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                controller.newCameraposition();
                controller.sendData(
                  nameController.text,
                  lastnameController.text,
                  messageController.text,
                );
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
      setState(() {
        active = true;
      });
    }
  }
}
