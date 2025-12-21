import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class GalleryUtils {
  static Future<bool> saveMultipleToGallery({
    required List<File> files,
    required BuildContext context,
    VoidCallback? onPermissionDenied,
  }) async {
    try {
      bool allSaved = true;

      // Handle permissions for Android
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        Permission permission =
            androidInfo.version.sdkInt >= 33
                ? Permission.photos
                : Permission.storage;
        var status = await permission.status;

        if (!status.isGranted) {
          debugPrint('Requesting permission: $permission');
          status = await permission.request();
          if (!status.isGranted) {
            debugPrint('Permission denied: $permission');
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Storage permission is required to save files',
                  ),
                  action: SnackBarAction(
                    label: 'Retry',
                    onPressed: () {
                      debugPrint('Retry action from GalleryUtils triggered');
                      onPermissionDenied?.call();
                    },
                  ),
                ),
              );
            } else {
              debugPrint('Context not mounted, skipping permission SnackBar');
            }
            return false;
          }
        }
      }

      // Save each file to gallery
      for (final file in files) {
        if (await file.exists()) {
          try {
            final result = await GallerySaver.saveImage(
              file.path,
              albumName: 'byaz_track',
            );
            debugPrint('Saving file ${file.path}: $result');
            if (result != true) {
              debugPrint('Failed to save file to gallery: ${file.path}');
              allSaved = false;
            }
          } catch (e) {
            debugPrint('Error saving file to gallery ${file.path}: $e');
            allSaved = false;
          }
        } else {
          debugPrint('File does not exist: ${file.path}');
          allSaved = false;
        }
      }

      return allSaved;
    } catch (e) {
      debugPrint('Error in saveMultipleToGallery: $e');
      return false;
    }
  }
}
