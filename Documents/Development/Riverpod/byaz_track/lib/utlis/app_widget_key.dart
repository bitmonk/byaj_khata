import 'package:byaz_track/core/extension/extensions.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class AppWidgetKey {
  static PersistentTabController bottomBarController =
      PersistentTabController();
  static final GlobalKey<ScaffoldState> mainScaffold = GlobalKey();
  static final GlobalKey<ScaffoldState> home = GlobalKey();

  static final GlobalKey<ScaffoldState> events = GlobalKey();
  static final GlobalKey<ScaffoldState> profile = GlobalKey();
  static final GlobalKey<ScaffoldState> message = GlobalKey();
}
