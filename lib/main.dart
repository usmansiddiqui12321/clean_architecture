import 'package:clean_architecture/Controller/theme_controller.dart';
import 'package:clean_architecture/Screens/navigator_screen.dart';
import 'package:clean_architecture/Service/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize window manager
  await windowManager.ensureInitialized();

  // Set minimum window size
  const minimumSize =
      Size(900, 600); // Set your desired minimum width and height
  await windowManager.setMinimumSize(minimumSize);

  // Optionally, set an initial size for the window
  const initialSize =
      Size(1200, 800); // Set your desired initial width and height
  await windowManager.setSize(initialSize);

  // Center the window on the screen
  await windowManager.center();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeController.theme,
      home: const NavigatorScreen(),
    );
  }
}
