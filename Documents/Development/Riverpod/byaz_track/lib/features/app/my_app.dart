import 'package:byaz_track/l10n/app_localizations.dart';
import 'package:byaz_track/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/core/language/language_controller.dart';
import 'package:byaz_track/core/theme/app_theme.dart';
import 'package:byaz_track/core/theme/theme_controller.dart';

class MyApp extends StatefulWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // precacheImage(Assets.images.splash.provider(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppUtils.unfocusKeyboard(context),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          // Initialize theme controller
          final themeController = Get.put(ThemeController());
          // Initialize language controller
          final languageController = Get.put(LanguageController());

          return Obx(
            () => GetMaterialApp(
              // initialBinding: ProfileBindings(),
              debugShowCheckedModeBanner: false,
              theme: AppTheme.appTheme(context),
              darkTheme: AppTheme.darkTheme(context),
              themeMode: themeController.themeMode,
              getPages: AppRoutes.appPages,
              initialRoute: widget.initialRoute,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: L10n.all,
              locale: languageController.locale,
              home: child,
              defaultTransition: Transition.fadeIn,
            ),
          );
        },
      ),
    );
  }
}
