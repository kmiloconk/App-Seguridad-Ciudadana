import 'dart:async';

import 'package:app_prueba/app/ui/pages/request_permission/request_permission_controller.dart';
import 'package:app_prueba/app/ui/routes/routers.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermisionPage extends StatefulWidget {
  const RequestPermisionPage({super.key});

  @override
  State<RequestPermisionPage> createState() => _RequestPermisionPageState();
}

class _RequestPermisionPageState extends State<RequestPermisionPage> {
  final _controller = RequestPermissionController(Permission.locationWhenInUse);

  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = _controller.onStatusChanged.listen(
      (status) {
        if (status == PermissionStatus.granted) {
          Navigator.pushReplacementNamed(context, Routes.LOGIN);
        }
      },
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: ElevatedButton(
          child: const Text('Permiso de Ubicación'),
          onPressed: () {
            _controller.request();
          },
        ),
      ),
    );
  }
}
