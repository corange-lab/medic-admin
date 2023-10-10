import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/auth_controller.dart';
import 'package:medic_admin/controller/user_controller.dart';
import 'package:medic_admin/firebase_options.dart';
import 'package:medic_admin/screen/home_screen.dart';
import 'package:medic_admin/screen/splash_screen.dart';
import 'package:medic_admin/theme/colors_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  UserController userController = Get.put(UserController());
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        initialRoute: '/',
        useInheritedMediaQuery: true,
        title: 'Medic',
        theme: ThemeColor.mThemeData(context),
        darkTheme: ThemeColor.mThemeData(context, isDark: true),
        // initialBinding: GlobalBindings(),
        defaultTransition: Transition.cupertino,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        transitionDuration: const Duration(milliseconds: 500),
        defaultGlobalState: true,
        themeMode: ThemeMode.light,
        home: HomeScreen());
  }
}
