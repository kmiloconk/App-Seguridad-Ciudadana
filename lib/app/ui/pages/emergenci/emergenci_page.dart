import 'package:app_prueba/main.dart';
import 'package:flutter/material.dart';
import 'package:app_prueba/app/services/firebase_service.dart';
import 'package:app_prueba/app/ui/routes/routers.dart';

class Emergenci extends StatefulWidget {
  const Emergenci({super.key});

  @override
  State<Emergenci> createState() => _EmergenciState();
}

class _EmergenciState extends State<Emergenci> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Emergencias",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              iconTheme: const IconThemeData(color: Colors.white),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              title: const Text('Emergencias',
                  style: TextStyle(color: Colors.white)),
            ),
            body: FutureBuilder<List>(
                future: getEmergenci(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    return RefreshIndicator(
                      onRefresh: _refreshData,
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                _elegir(context, Persona.fromMap(data),
                                    snapshot.data?[index]['uid']);
                              },
                              title:
                                  Text('${data['name']} ${data['lastname']}'),
                              subtitle: Text(data['message']),
                              leading: const CircleAvatar(
                                child: Icon(Icons.warning_amber),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            );
                          }),
                    );
                  }
                }))));
  }

  _elegir(context, Persona persona, String uid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Emergencia'),
              content: const Text(
                  'Estas seguro que quieres elegir esta emergencia?'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.ADMIN, arguments: {
                        'latitude': persona.latitude,
                        'longitude': persona.longitude,
                        'uid': uid
                      });
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }
}

class Persona {
  String name = '';
  String lastname = '';
  String message = '';
  double latitude = 0;
  double longitude = 0;

  Persona(
      this.name, this.lastname, this.message, this.latitude, this.longitude);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastname': lastname,
      'message': message,
      'latitude': latitude,
      'longitude': longitude
    };
  }

  static Persona fromMap(Map<String, dynamic> map) {
    return Persona(
      map['name'],
      map['lastname'],
      map['message'],
      (map['latitude'] ?? 0.0).toDouble(),
      (map['longitude'] ?? 0.0).toDouble(),
    );
  }
}
