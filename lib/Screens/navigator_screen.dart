import 'package:clean_architecture/Constants/app_colors.dart';
import 'package:clean_architecture/Controller/navigator_controller.dart';
import 'package:clean_architecture/Screens/home_screen.dart';
import 'package:clean_architecture/Screens/permission_screen.dart';
import 'package:clean_architecture/Screens/profile_screen.dart';
import 'package:clean_architecture/Screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  final navController = Get.put(NavigatorController());
  List pages = [
    HomeScreen(),
    PermissionScreen(),
    SettingScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light background color
      body: SafeArea(
          child: Row(
        children: [
          Expanded(flex: 1, child: AppDrawer()),
          // Main Content
          GetBuilder<NavigatorController>(
              init: navController,
              builder: (controller) {
                return Expanded(flex: 4, child: pages[controller.currentIndex]);
              })
        ],
      )),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.put(NavigatorController());

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        0.5,
      ),
      backgroundColor:
          isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
      child: GetBuilder(
          init: navController,
          builder: (controller) {
            return Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.surface : AppColors.primary,
                  ),
                  child: const Center(
                    child: Text(
                      'Menu',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    if (navController.currentIndex == 0) return;
                    navController.setIndex(0);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.security),
                  title: Text('Permission'),
                  onTap: () {
                    if (navController.currentIndex == 1) return;
                    navController.setIndex(1);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Settings'),
                  onTap: () {
                    if (navController.currentIndex == 2) return;
                    navController.setIndex(2);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () {
                    if (navController.currentIndex == 3) return;
                    navController.setIndex(3);
                  },
                ),
              ],
            );
          }),
    );
  }
}
