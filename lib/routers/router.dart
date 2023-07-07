import 'package:flutter_chatgpt_mac/pages/home/view.dart';
import 'package:flutter_chatgpt_mac/pages/openai/setting/view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static String root = "/";
  static String setting = "/setting";
}

abstract class AppPage {
  static final pages = [
    GetPage(
      name: Routes.root,
      page: () => HomePage(),
      // children: [],

      // GetPage(
      //   name: Routes.setting,
      //   transition: Transition.downToUp,
      //   fullscreenDialog: true,
      //   page: () => SettingPage(),
      // ),
    ),
    GetPage(
      name: Routes.setting,
      transition: Transition.downToUp,
      page: () => SettingPage(),
    ),
  ];

  /// 跳转到指定页面
  /// needLogin：是否需求强制登录
  /// arguments：传参
  /// closePreviousPage: 跳转页面后，是否把上个页面dismiss掉
  /// preventDuplicates: 是否禁止打开已经存在的页面，默认为禁止
  static void to(
    String page, {
    bool needLogin = true,
    dynamic arguments,
    bool closePreviousPage = false,
    bool preventDuplicates = true,
  }) {
    var isLogin = true;
    if (needLogin && !isLogin) {
      // Get.toNamed(
      //   Routes.login,
      //   arguments: arguments,
      //   preventDuplicates: preventDuplicates,
      // );
    } else {
      if (closePreviousPage) {
        Get.offNamed(
          page,
          arguments: arguments,
          preventDuplicates: preventDuplicates,
        );
      } else {
        Get.toNamed(
          page,
          arguments: arguments,
          preventDuplicates: preventDuplicates,
        );
      }
    }
  }
}
