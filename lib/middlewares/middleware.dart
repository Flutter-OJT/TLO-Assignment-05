import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../services/auth/auth_service.dart';

class GlobalMiddleware extends GetMiddleware {
  final authService = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.authenticated ||
            route == '/login' ||
            route == '/register'
        ? null
        : const RouteSettings(name: '/login');
  }
  //
  // @override
  // GetPage? onPageCalled(GetPage? page) {
  //   print('>>> Page ${page!.name} called');
  //   print('>>> User ${authController.username} logged');
  //   return page;
  // }
  //
  // @override
  // GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
  //   print('Bindings of ${page.toString()} are ready');
  //   return page;
  // }
  //
  // @override
  // Widget onPageBuilt(Widget page) {
  //   print('Widget ${page.toStringShort()} will be showed');
  //   return page;
  // }
}
