import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';

import 'logic.dart';

class AuidoPage extends StatelessWidget {
  final logic = Get.put(AuidoLogic());
  final state = Get.find<AuidoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
        title: const Text("语音助手"),
        actions: [
          ToolBarIconButton(
            label: "Exit",
            icon: const MacosIcon(CupertinoIcons.waveform),
            showLabel: false,
            tooltipMessage: "Exit",
            onPressed: () {
              logic.openDocument();
            },
          ),
        ],
      ),
      backgroundColor: Colors.black12,
      children: [],
    );
  }
}
