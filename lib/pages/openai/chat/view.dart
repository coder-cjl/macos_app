import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import 'logic.dart';
import 'model.dart';

class ChatPage extends StatelessWidget {
  final logic = Get.put(ChatLogic());
  final state = Get.find<ChatLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(
            () => ListViewObserver(
              controller: state.observerController,
              child: ListView.builder(
                controller: state.scrollController,
                itemCount: state.items.value.length,
                itemBuilder: (context, index) {
                  TextModel item = state.items.value[index];
                  return _content(item);
                },
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

  Widget _content(TextModel item) {
    return logic.parse(item);
  }
}
