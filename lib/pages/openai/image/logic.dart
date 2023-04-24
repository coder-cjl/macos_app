import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_chatgpt_mac/pages/openai/image/model.dart';
import 'package:flutter_chatgpt_mac/pages/openai/login/manager.dart';
import 'package:get/get.dart';
import 'package:luca_flutter_common/luca_loading.dart';

import 'state.dart';

class ImageLogic extends GetxController {
  final ImageState state = ImageState();

  void sendText() async {
    String txt = state.input.text.trim();
    if (txt.isEmpty) {
      LucaLoading.showToast("请输入提示内容");
      return;
    }

    LucaLoading.show(timeout: 60);
    try {
      var req = Dio();
      (req.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (url) {
          return UserOpenAiUtils.instance.user?.proxy ?? "";
        };
        client.badCertificateCallback = (cert, host, port) {
          return true;
        };
        return client;
      };

      var res = await req.post(
        "https://api.openai.com/v1/images/generations",
        data: {
          "n": 5,
          "size": "512x512",
          "prompt": txt,
        },
        options: Options(
          headers: {
            "Authorization":
                "Bearer ${UserOpenAiUtils.instance.user?.token ?? ""}",
            "Content-Type": "application/json",
          },
        ),
      );

      req.close();
      // state.input.clear();

      if (res.statusCode == 200) {
        LucaLoading.dismiss();
        List data = res.data["data"];
        state.items.value = data.map((e) => ImageModel(url: e["url"])).toList();
        state.items.refresh();
      } else {
        LucaLoading.showToast("请求出错");
      }
    } catch (e) {
      LucaLoading.showToast("请求出错");
    }
  }
}
