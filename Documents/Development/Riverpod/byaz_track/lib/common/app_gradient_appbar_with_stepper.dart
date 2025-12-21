import 'package:byaz_track/common/app_stepper.dart';
import 'package:byaz_track/core/extension/extensions.dart';

class AppGradientAppBarWithStepper extends StatelessWidget
    implements PreferredSizeWidget {
  const AppGradientAppBarWithStepper({
    super.key,
    required this.onBackTap,
    required this.index,
  });
  final VoidCallback onBackTap;
  final int index;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   // Status bar color
        //   statusBarColor: Colors.transparent,

        //   // Status bar brightness (optional)
        //   statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
        // ),
        // surfaceTintColor: AppColors.white,
        automaticallyImplyLeading: false,
        // backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 4),
            child: Row(
              children: [
                IconButton(
                  onPressed: onBackTap,
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: AppColors.color111719,
                  ),
                ),
                Expanded(child: Center(child: AppStepper(index: index))),
                SizedBox(width: 48), // Same width as leading to balance layout
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppGradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppGradientAppBar({
    super.key,
    required this.onBackTap,
    this.title,
    this.titleSpacing,
  });
  final VoidCallback onBackTap;
  final String? title;
  final double? titleSpacing;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: Colors.transparent,

      //   statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
      // ),
      // backgroundColor: Colors.transparent,
      title: Text(
        title!,
        style: context.text.titleLarge!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      titleSpacing: titleSpacing,
      centerTitle: false,
      leading: IconButton(
        onPressed: onBackTap,
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.color111719,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
