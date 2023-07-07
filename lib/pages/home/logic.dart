import 'package:flutter_chatgpt_mac/pages/openai/login/manager.dart';
import 'package:flutter_chatgpt_mac/routers/router.dart';
import 'package:get/get.dart';

import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  void chatgptLogout() async {
    await UserOpenAiUtils.instance.logout();
  }

  void openSetting() {
    AppPage.to(Routes.setting);
  }
}
