import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:byaz_track/core/extension/extensions.dart';

class AppUtils {
  static SystemUiOverlayStyle statusBarDarkStyle() {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light, // For iOS
      statusBarIconBrightness: Brightness.dark, // For Android
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  static SystemUiOverlayStyle statusBarLightStyle() {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light, // For iOS
      statusBarIconBrightness: Brightness.light, // For Android
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  static void unfocusKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static bool validateForm(GlobalKey<FormState> formkey) {
    return formkey.currentState?.validate() ?? false;
  }

  static BuildContext getBuildContext() {
    return Get.context!;
  }

  static OverlayEntry? _overlayEntry;

  static void showLoadingDialog(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => const Material(
            color: Colors.transparent,
            child: Center(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hideLoadingDialog(BuildContext context) {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static void showSnackbar({required String message}) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(
        GetSnackBar(
          messageText: Text(
            message,
            style: const TextStyle(
              color: AppColors.colorWhite,
              fontWeight: FontWeight.w700,
            ),
          ),
          borderRadius: 16,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          animationDuration: const Duration(milliseconds: 500),
          icon: const Icon(
            Icons.check_circle,
            weight: 1,
            size: 28,
            color: AppColors.colorWhite,
          ),
          mainButton: IconButton(
            onPressed: Get.closeCurrentSnackbar,
            icon: const Icon(
              Icons.close,
              color: AppColors.colorWhite,
              weight: 400,
            ),
          ),
          backgroundGradient: const LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
          ),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  static void showErrorSnackbar({
    String message = 'Invalid Url',
    void Function()? onRetry,
    String buttonText = 'Retry',
  }) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!Get.isSnackbarOpen) {
        Get.showSnackbar(
          GetSnackBar(
            messageText: Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.colorWhite,
              ),
            ),
            borderRadius: 16,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            animationDuration: const Duration(milliseconds: 500),
            icon: const Icon(
              Icons.error,
              weight: 1,
              size: 28,
              color: AppColors.colorWhite,
            ),
            mainButton: Row(
              children: [
                if (onRetry != null)
                  TextButton(
                    onPressed: () {
                      Get.closeCurrentSnackbar();
                      Future.delayed(const Duration(seconds: 1), () {
                        onRetry.call();
                      });
                    },
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: AppColors.colorWhite,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                IconButton(
                  onPressed: Get.closeCurrentSnackbar,
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.colorWhite,
                    weight: 400,
                  ),
                ),
              ],
            ),
            backgroundGradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 17, 0),
                Color.fromARGB(255, 242, 104, 77),
              ],
            ),
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    });
  }

  static Future<XFile?> pickImage(BuildContext context) async {
    // final profileController = Get.find<ProfileController>();
    final source = await showModalBottomSheet<ImageSource>(
      backgroundColor: AppColors.white,
      useRootNavigator: true,
      context: context,
      builder:
          (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.photo_outlined,
                    color: AppColors.textColor50,
                  ),
                  title: const Text(
                    'Pick From Gallery',
                    style: AppTextStyles.titleSm,
                  ),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
                const AppDivider(),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.textColor50,
                  ),
                  title: const Text(
                    'Take a Picture',
                    style: AppTextStyles.titleSm,
                  ),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                const AppDivider(),
                ListTile(
                  leading: const Icon(
                    Icons.photo_outlined,
                    color: AppColors.textColor50,
                  ),
                  title: const Text(
                    'Remove Image',
                    style: AppTextStyles.titleSm,
                  ),
                  onTap: () async {},
                ),
                const VerticalSpacing(6),
              ],
            ),
          ),
    );
    if (source == null) {
      return null;
    }
    if (!context.mounted) {
      return null;
    }

    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage == null) {
      return null;
    }
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.primary500,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );
    if (croppedFile == null) {
      return pickedImage;
    } else {
      return XFile(croppedFile.path);
    }
  }
}
