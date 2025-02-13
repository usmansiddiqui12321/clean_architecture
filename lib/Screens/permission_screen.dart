import 'package:clean_architecture/Controller/theme_controller.dart';
import 'package:clean_architecture/Service/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  final PermissionHandlerService _permissionService =
      PermissionHandlerService();
  Map<Permission, bool> _permissionsStatus = {
    Permission.camera: false,
    Permission.location: false,
    Permission.storage: false,
  };

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final status = await _permissionService
        .checkMultiplePermissions(_permissionsStatus.keys.toList());
    setState(() {
      _permissionsStatus = status;
    });
  }

  Future<void> _requestPermission(Permission permission) async {
    final granted =
        await _permissionService.checkAndRequestPermission(permission);
    setState(() {
      _permissionsStatus[permission] = granted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permission Status"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _permissionsStatus.keys.map((permission) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title:
                    Text(permission.toString().split(".").last.toUpperCase()),
                subtitle: Text(
                    _permissionsStatus[permission]! ? "Granted" : "Denied"),
                trailing: ElevatedButton(
                  onPressed: () => _requestPermission(permission),
                  child: Text(
                      _permissionsStatus[permission]! ? "Granted" : "Request"),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
