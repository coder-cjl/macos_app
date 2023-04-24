import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_mac/pages/openai/chat/view.dart';
import 'package:flutter_chatgpt_mac/pages/openai/login/manager.dart';
import 'package:flutter_chatgpt_mac/pages/openai/login/view.dart';
import 'package:flutter_chatgpt_mac/pages/other/view.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        maxWidth: 200,
        topOffset: 20,
        builder: (context, controller) {
          return Obx(
            () => SidebarItems(
              items: const [
                SidebarItem(
                  label: Text("Chat Open Ai"),
                ),
                SidebarItem(
                  label: Text("Other"),
                ),
              ],
              currentIndex: state.currentIndex.value,
              onChanged: (index) {
                state.currentIndex.value = index;
              },
            ),
          );
        },
      ),
      child: Obx(
        () => IndexedStack(
          index: state.currentIndex.value,
          children: [
            Obx(
              () => UserOpenAiUtils.instance.isLoginObs.value
                  ? MacosScaffold(
                      toolBar: ToolBar(
                        title: const Text("陈三傻"),
                        actions: [
                          ToolBarIconButton(
                            label: "Exit",
                            icon: const MacosIcon(Icons.exit_to_app_sharp),
                            showLabel: false,
                            tooltipMessage: "Exit",
                            onPressed: () {
                              logic.chatgptLogout();
                            },
                          ),
                        ],
                      ),
                      backgroundColor: Colors.black12,
                      children: [
                        ContentArea(
                          builder: (context, controller) {
                            return ChatPage();
                          },
                        ),
                      ],
                    )
                  : ContentArea(builder: (context, controller) {
                      return LoginPage();
                    }),
            ),
            OtherPage(),
          ],
        ),
      ),
    );
  }
}
