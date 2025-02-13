// ignore_for_file: unintended_html_in_doc_comment

import 'dart:io' show Platform;
import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PermissionHandlerService {
  ///  * Check if a specific permission is granted
  Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    log('Checking permission status for: $permission');
    return status.isGranted;
  }

  ///  * Request a specific permission
  Future<bool> requestPermission(Permission permission) async {
    log('Requesting permission for: $permission');
    final status = await permission.request();

    switch (status) {
      case PermissionStatus.denied:
        log('Permission denied for $permission. Consider explaining why this permission is needed.');
        return false;
      case PermissionStatus.permanentlyDenied:
        log('Permission permanently denied for $permission. Opening app settings...');
        await openAppSettings(); // Open app settings to allow the user to grant permission manually
        return false;
      default:
        log('Permission request result for $permission: ${status.isGranted}');
        return status.isGranted;
    }
  }

  Future<bool> checkPermission(Permission permission) async {
    if (await isPermissionGranted(permission)) {
      log('Permission already granted for: $permission');
      return true;
    } else {
      log('Permission not granted for: $permission, requesting now...');
      return false;
    }
  }

  ///  * Check and request permission if not granted
  Future<bool> checkAndRequestPermission(Permission permission) async {
    if (await isPermissionGranted(permission)) {
      log('Permission already granted for: $permission');
      return true;
    } else {
      log('Permission not granted for: $permission, requesting now...');
      return await requestPermission(permission);
    }
  }

  ///  * Function to check the status of multiple permissions
  Future<Map<Permission, bool>> checkMultiplePermissions(
      List<Permission> permissions) async {
    final permissionStatus = <Permission, bool>{};

    for (var permission in permissions) {
      final status = await isPermissionGranted(permission);
      permissionStatus[permission] = status;
      log('Permission status for $permission: $status');
    }
    return permissionStatus;
  }

  ///  * Function to request multiple permissions
  Future<Map<Permission, bool>> requestMultiplePermissions(
      List<Permission> permissions) async {
    final permissionStatus = <Permission, bool>{};

    for (var permission in permissions) {
      final status = await requestPermission(permission);
      permissionStatus[permission] = status;
      log('Requested $permission - Granted: $status');
    }
    return permissionStatus;
  }

  // --------------------------------------------------------------------------
  //! Platform-Specific Permissions
  // --------------------------------------------------------------------------

  ///  * Android: Add to AndroidManifest.xml
  ///  * <uses-permission android:name="android.permission.CAMERA" />
  ///  * iOS: Add to Info.plist
  ///  * <key>NSCameraUsageDescription</key>
  ///  * <string>We need access to your camera to take photos.</string>
  Future<bool> checkAndRequestCameraPermission() async {
    return await checkAndRequestPermission(Permission.camera);
  }

  ///  * Android: Add to AndroidManifest.xml
  ///  * <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  ///  * <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
  ///  * iOS: Add to Info.plist
  ///  * <key>NSLocationWhenInUseUsageDescription</key>
  ///  * <string>We need access to your location to provide location-based services.</string>
  ///  * <key>NSLocationAlwaysUsageDescription</key>
  ///  * <string>We need access to your location to provide location-based services.</string>
  Future<bool> checkAndRequestLocationPermission() async {
    return await checkAndRequestPermission(Permission.location);
  }

  ///  * Android: Add to AndroidManifest.xml
  ///  * <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
  ///  * <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
  ///  * iOS: Add to Info.plist
  ///  * <key>NSPhotoLibraryUsageDescription</key>
  ///  * <string>We need access to your photos to upload images.</string>
  Future<bool> checkAndRequestStoragePermission() async {
    if (Platform.isAndroid && await _isAndroid13OrAbove()) {
      // For Android 13+, use Permission.photos
      return await checkAndRequestPermission(Permission.photos);
    } else if (Platform.isAndroid) {
      // For Android 12 and below, use Permission.storage
      return await checkAndRequestPermission(Permission.storage);
    } else {
      // For iOS, use Permission.photos
      return await checkAndRequestPermission(Permission.photos);
    }
  }

  ///  * Android: Add to AndroidManifest.xml
  ///  * <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" /> (API 33+)
  ///  * <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" /> (API < 33)
  ///  * iOS: Add to Info.plist
  ///  * <key>NSPhotoLibraryUsageDescription</key>
  ///  * <string>We need access to your photos to upload images.</string>
  Future<bool> checkAndRequestPhotosPermission() async {
    if (Platform.isIOS) {
      // For iOS, use Permission.photos
      return await checkAndRequestPermission(Permission.photos);
    } else if (Platform.isAndroid) {
      if (await _isAndroid13OrAbove()) {
        // For Android 13+, use Permission.photos
        return await checkAndRequestPermission(Permission.photos);
      } else {
        // For Android 12 and below, use Permission.storage
        return await checkAndRequestPermission(Permission.storage);
      }
    } else {
      // Handle other platforms if needed
      log('Unsupported platform for photo/gallery permissions.');
      return false;
    }
  }

  ///  * Helper function to check if the Android device is running API level 33 or above
  Future<bool> _isAndroid13OrAbove() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt >= 33;
    }
    return false;
  }
}
