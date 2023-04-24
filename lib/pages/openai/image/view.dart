import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_mac/pages/openai/image/model.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';

import 'logic.dart';

class ImagePage extends StatelessWidget {
  final logic = Get.put(ImageLogic());
  final state = Get.find<ImageLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(
            () => GridView.builder(
              controller: state.scrollController,
              itemCount: state.items.value.length,
              itemBuilder: (context, index) {
                ImageModel item = state.items.value[index];
                return Image.network(item.url ?? "");
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                // childAspectRatio: 6,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  width: Get.width - 300,
                  child: MacosTextField(
                    controller: state.input,
                    onSubmitted: (value) {
                      logic.sendText();
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                PushButton(
                  buttonSize: ButtonSize.large,
                  onPressed: () {
                    logic.sendText();
                  },
                  child: const Text("Send"),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ],
    );
  }
}
