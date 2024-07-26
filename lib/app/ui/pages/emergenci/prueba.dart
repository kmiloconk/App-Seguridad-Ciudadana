import 'package:app_prueba/app/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Prueba extends StatefulWidget {
  const Prueba({super.key});

  @override
  State<Prueba> createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Prueba'),
        ),
        body: FutureBuilder<List>(
          future: getEmergenci(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data found'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var emergenciData =
                      snapshot.data![index] as Map<String, dynamic>;
                  var name = emergenciData['name'] ?? 'No name';
                  var lastname = emergenciData['lastname'] ?? 'No lastname';
                  return ListTile(
                    title: Text(name + ' ' + lastname),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
