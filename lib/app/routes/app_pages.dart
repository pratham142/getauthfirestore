import 'package:get/get.dart';

import '../modules/authpage/bindings/authpage_binding.dart';
import '../modules/authpage/views/authpage_view.dart';
import '../modules/drawboard/bindings/drawboard_binding.dart';
import '../modules/drawboard/views/drawboard_view.dart';
import '../modules/form1/bindings/form1_binding.dart';
import '../modules/form1/views/form1_view.dart';
import '../modules/form2/bindings/form2_binding.dart';
import '../modules/form2/views/form2_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register_view/bindings/register_view_binding.dart';
import '../modules/register_view/views/register_view_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/togglepages/bindings/togglepages_binding.dart';
import '../modules/togglepages/views/togglepages_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_VIEW,
      page: () => const RegisterViewView(),
      binding: RegisterViewBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.AUTHPAGE,
      page: () => const AuthpageView(),
      binding: AuthpageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.TOGGLEPAGES,
      page: () => const TogglepagesView(),
      binding: TogglepagesBinding(),
    ),
    GetPage(
      name: _Paths.FORM1,
      page: () => const Form1View(),
      binding: Form1Binding(),
    ),
    GetPage(
      name: _Paths.FORM2,
      page: () => const Form2View(),
      binding: Form2Binding(),
    ),
    GetPage(
      name: _Paths.DRAWBOARD,
      page: () => const DrawboardView(),
      binding: DrawboardBinding(),
    ),
  ];
}
