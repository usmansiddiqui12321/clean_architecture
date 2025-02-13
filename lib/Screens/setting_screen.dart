import 'package:clean_architecture/Controller/theme_controller.dart';
import 'package:clean_architecture/Screens/permission_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Settings", style: Theme.of(context).textTheme.headlineMedium)
            .paddingAll(10),
        GetBuilder(
            init: themeController,
            builder: (controller) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                value: controller.theme == ThemeMode.dark,
                onChanged: (value) {
                  controller.toggleTheme();
                },
              );
            }),
        ListTile(
            title: const Text('Permission Status'),
            onTap: () {
              Get.to(() => PermissionScreen());
            })
      ],
    );
  }
}
