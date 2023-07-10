import 'package:authentications/middlewares/middleware.dart';
import 'package:authentications/screens/auth/login_screen.dart';
import 'package:authentications/screens/auth/registration_screen.dart';
import 'package:authentications/screens/home/admin_home_screen.dart';
import 'package:authentications/screens/home/admin_manage_user.dart';
import 'package:authentications/services/home/home_service.dart';
import 'package:authentications/services/login/login_service.dart';
import 'package:get/get.dart';
import '../home/user_home_screen.dart';

class PageConfig {
  static final List<GetPage> pages = [
    GetPage(
      name: '/adminhome',
      page: () => AdminHomeScreen(),
      binding: BindingsBuilder(() {
        HomeService();
      }),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: '/adminmanageuser',
      page: () => AdminManageUserScreen(),
      binding: BindingsBuilder(() {
        HomeService();
      }),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: '/userhome',
      page: () => UserHomeScreen(),
      binding: BindingsBuilder(() {
        HomeService();
      }),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: '/register',
      page: () => RegistrationScreen(),
      binding: BindingsBuilder(() {
        Get.put(LoginService());
      }),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(LoginService());
      }),
      middlewares: [GlobalMiddleware()],
    ),
  ];
}
