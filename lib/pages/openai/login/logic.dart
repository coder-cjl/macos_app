import 'package:flutter_chatgpt_mac/pages/openai/login/manager.dart';
import 'package:get/get.dart';
import 'package:luca_flutter_common/luca_loading.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  void login() async {
    String token = state.token.text;
    if (token.isEmpty) {
      LucaLoading.showToast("请填写必要参数");
      return;
    }
    String proxy = state.proxy.text;
    if (proxy.isEmpty) {
      LucaLoading.showToast("因ChatGPT需要vpn代理才可以使用，请设置你的代理");
      return;
    }

    UserModel user = UserModel(
      token: token,
      proxy: proxy,
    );

    await UserOpenAiUtils.instance.login(user);
  }
}
