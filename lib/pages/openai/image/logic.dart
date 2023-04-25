import 'package:flutter_chatgpt_mac/pages/network/api.dart';
import 'package:flutter_chatgpt_mac/pages/network/url.dart';
import 'package:flutter_chatgpt_mac/pages/openai/image/model.dart';
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
    var res = await Api().post(ApiURL.imagePrompt, data: {
      "n": 5,
      "size": "512x512",
      "prompt": txt,
    });
    if (res.isSuccessful()) {
      LucaLoading.dismiss();
      List data = res.data["data"];
      state.items.value = data.map((e) => ImageModel(url: e["url"])).toList();
      state.items.refresh();
    } else {
      LucaLoading.showToast(res.message);
    }
  }
}
